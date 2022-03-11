(in-package :asdf-user)
(defsystem "bluetooth-control"
  :author "Johannes Martinez Calzada"
  :description "Simple shell wrapper for bluetoothctl"
  :licence "llgpl"
  :depends-on ("trivial-shell")
  :components ((:file "bluetooth")))
