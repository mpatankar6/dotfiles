#include <nvml.h>
#include <stdio.h>
#include <stdlib.h>

nvmlDevice_t initializeGpu() {
  nvmlReturn_t init_status = nvmlInit_v2();
  if (init_status != NVML_SUCCESS) {
    fprintf(stderr, "Error during NVML initialization: %s\n",
            nvmlErrorString(init_status));
    exit(EXIT_FAILURE);
  }

  nvmlDevice_t device = NULL;
  nvmlReturn_t device_get_status =
      // The docs recommend using PCI id or UUID, but I only have one GPU so
      // this is fine.
      nvmlDeviceGetHandleByIndex_v2(0, &device);
  if (device_get_status != NVML_SUCCESS) {
    fprintf(stderr, "Error obtaining NVML device: %s\n",
            nvmlErrorString(device_get_status));
    exit(EXIT_FAILURE);
  }
  return device;
}

void cleanup() {
  nvmlReturn_t shutdown_status = nvmlShutdown();
  if (shutdown_status != NVML_SUCCESS) {
    fprintf(stderr, "Warning: NVML did not shutdown correctly: %s\n",
            nvmlErrorString(shutdown_status));
  }
}

double gpuUsagePercentage(nvmlDevice_t device) {
  nvmlUtilization_t utilization_info = {.gpu = -1, .memory = -1};
  nvmlReturn_t utilization_get_status =
      nvmlDeviceGetUtilizationRates(device, &utilization_info);
  if (utilization_get_status != NVML_SUCCESS) {
    fprintf(stderr, "Error obtaining device utilization: %s\n",
            nvmlErrorString(utilization_get_status));
  }
  return utilization_info.gpu;
}

double gpuTemperatureCelsius(nvmlDevice_t device) {
  nvmlTemperature_t temperature_info = {.version = nvmlTemperature_v1,
                                        .sensorType = NVML_TEMPERATURE_GPU,
                                        .temperature = -1};
  nvmlReturn_t temperature_get_status =
      nvmlDeviceGetTemperatureV(device, &temperature_info);
  if (temperature_get_status != NVML_SUCCESS) {
    fprintf(stderr, "Error obtaining device temperature: %s\n",
            nvmlErrorString(temperature_get_status));
  }
  return temperature_info.temperature;
}

int main() {
  nvmlDevice_t device = initializeGpu();
  double usage_percentage = gpuUsagePercentage(device);
  double temperature_celsius = gpuTemperatureCelsius(device);
  printf("{\"text\": %.0f, \"tooltip\": \"GPU: %.0f%%\\nTemperature: %.1f°C\"}",
         usage_percentage, usage_percentage, temperature_celsius);
  cleanup();
  return 0;
}
