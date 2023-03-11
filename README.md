## Heating Control

The heating has two heating circuits that can be activated separately by pumps P1 and P2. The control receives a temperature value (TEMP) in the (8.8) signed fixed point format with each rising edge of CLK (period duration 1s). 
If the EMERGENCY STOP is active, all pumps are switched off immediately (i.e. without delay).

- If the temperature falls below 20°C, the first of the two pumps starts (P1).

- If the temperature falls below 18°C, the other pump (P2) also starts. The heating heats with both circuits until the temperature is at least 20°C. Both pumps must then be switched off simultaneously.

- The pumps should only be active as long as necessary, but may only be switched off after 2 seconds of running time.
