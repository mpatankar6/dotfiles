{
  services.hyprsunset = {
    enable = true;

    settings = {
      profile = [
        {
          time = "6:30";
          identity = true;
        }
        {
          time = "19:00";
          temperature = 5500;
        }
      ];
    };
  };
}
