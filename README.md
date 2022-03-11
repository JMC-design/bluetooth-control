# bluetooth-control
Simple shell wrapper around bluetoothctl

The :bluetooth-control package is not meant to be :USEd as it shadows some cl functions.
This basic wrapper does not provide access to the advertise,scan, or gatt functions for the time being.
All MACs and parameters to functions are strings, except for POWER, which can take a keyword :on or :off.
Depends on trivial-shell
