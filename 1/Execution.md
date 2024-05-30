How to start Telegraf, InfluxDB, Grafana:

1) **Telegraf:**
   Use a personal token from InfluxDB.

2) **InfluxDB:**
   Navigate to the directory `/usr/local/bin`, there is `influxd`, run it with the command `./influxd`.

3) **Grafana:**
   Navigate to the Grafana directory (version) -> `bin`, check using the command `ls`, then run the `grafana-server` directory with the command `./grafana-server`.

**Note:** For Telegraf and Grafana, there is no need to reload to start them again. InfluxDB needs to be restarted when the device is turned on.

---
