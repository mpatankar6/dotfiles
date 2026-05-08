#include <dirent.h>
#include <errno.h>
#include <inttypes.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// This is what my personal AMD CPU uses.
#define CPU_TEMP_DRIVER "k10temp"

typedef struct {
  // We only need fields 1-7, since we're not virtualized.
  uint64_t user, nice, system, idle, iowait, irq, softirq;
} CpuStats;

uint64_t active_jiffies(const CpuStats *stats) {
  return stats->user + stats->nice + stats->system + stats->irq +
         stats->softirq;
}

uint64_t total_jiffies(const CpuStats *stats) {
  return stats->user + stats->nice + stats->system + stats->idle +
         stats->iowait + stats->irq + stats->softirq;
}

CpuStats readCpuStats() {
  CpuStats stats = {0};
  FILE *proc_stat = fopen("/proc/stat", "r");
  if (proc_stat == NULL) {
    perror("fopen /proc/stat");
    exit(EXIT_FAILURE);
  }
  int fields_read = fscanf(proc_stat,
                           "%*s %" SCNu64 " %" SCNu64 " %" SCNu64 " %" SCNu64
                           " %" SCNu64 " %" SCNu64 " %" SCNu64,
                           &stats.user, &stats.nice, &stats.system, &stats.idle,
                           &stats.iowait, &stats.irq, &stats.softirq);
  if (fields_read != 7) {
    fprintf(stderr, "Couldn't parse /proc/stat: expected 7 fields, got %d\n",
            fields_read);
    fclose(proc_stat);
    exit(EXIT_FAILURE);
  }
  return stats;
}

double cpuUsagePercentage() {
  char *runtime_dir = getenv("XDG_RUNTIME_DIR");
  if (!runtime_dir) {
    fprintf(stderr, "XDG_RUNTIME_DIR not set, falling back to /tmp\n");
    runtime_dir = "/tmp";
  }
  char *last_cpu_stats_path;
  asprintf(&last_cpu_stats_path, "%s/last_cpu_stats", runtime_dir);
  FILE *last_cpu_stats = fopen(last_cpu_stats_path, "rb");
  if (!last_cpu_stats && errno != ENOENT) {
    perror("fopen last_cpu_stats");
    exit(EXIT_FAILURE);
  }

  CpuStats first_sample;
  // We'll initialize the first sample to the current if there is no previous.
  if (!last_cpu_stats) {
    first_sample = readCpuStats();
  } else {
    if (fread(&first_sample, sizeof(CpuStats), 1, last_cpu_stats) != 1) {
      first_sample = readCpuStats();
    }
    fclose(last_cpu_stats);
  }

  CpuStats second_sample = readCpuStats();
  FILE *out = fopen(last_cpu_stats_path, "wb");
  if (out == NULL) {
    perror("fopen last_cpu_stats");
    exit(EXIT_FAILURE);
  }
  free(last_cpu_stats_path);
  fwrite(&second_sample, sizeof(CpuStats), 1, out);
  fclose(out);

  double active_delta =
      (active_jiffies(&second_sample) - active_jiffies(&first_sample));
  double total_delta =
      (total_jiffies(&second_sample) - total_jiffies(&first_sample));
  double cpu_usage_ratio = total_delta == 0 ? 0 : active_delta / total_delta;
  return cpu_usage_ratio * 100;
}

double cpuTemperatureCelsius() {
  int temperature_millidegrees = 0;

  // The path to the file with temperature information *should* be stable, but
  // just in case, let's search for it.
  DIR *hwmon_directory = opendir("/sys/class/hwmon");
  struct dirent *entry = NULL;
  while ((entry = readdir(hwmon_directory))) {
    if (strncmp(entry->d_name, "hwmon", 5) != 0) {
      continue;
    }
    char *name_path = NULL;
    asprintf(&name_path, "/sys/class/hwmon/%s/name", entry->d_name);
    FILE *name_file = fopen(name_path, "r");
    free(name_path);
    if (!name_file) {
      continue;
    }
    char *name = NULL;
    size_t len = 0;
    (void)len;
    getline(&name, &len, name_file);
    fclose(name_file);
    if (strcmp(name, CPU_TEMP_DRIVER "\n") == 0) {
      char *temperature_path;
      asprintf(&temperature_path, "/sys/class/hwmon/%s/temp1_input",
               entry->d_name);
      FILE *temp1_input = fopen(temperature_path, "r");
      free(temperature_path);
      if (!temp1_input) {
        perror("fopen temp1_input");
        exit(EXIT_FAILURE);
      }
      fscanf(temp1_input, "%d", &temperature_millidegrees);
      fclose(temp1_input);
      break;
    }
  }
  closedir(hwmon_directory);
  return temperature_millidegrees / 1000.0;
}

int main() {
  double usage_percentage = cpuUsagePercentage();
  double temperature_celsius = cpuTemperatureCelsius();
  printf("{\"text\": %.0f, \"tooltip\": \"CPU: %.0f%%\\nTemperature: %.1f°C\"}",
         usage_percentage, usage_percentage, temperature_celsius);
  return 0;
}
