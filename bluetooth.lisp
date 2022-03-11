(defpackage #:bluetooth-control
  (:use :cl)
  (:shadow :remove :list :block)
  (:export #:power
           #:devices
	   #:paired-devices
           #:pair
	   #:remove
	   #:connect
	   #:disconnect
           #:info
           #:trust
           #:untrust
           #:block
           #:unblock
           #:list
           #:show)
  (:nicknames #:Btc))
(in-package #:btc)

(defun shell (command-string)
  (trivial-shell:shell-command command-string))

(defmacro bt-cmd (name &optional args output input)
  `(defun ,(intern (string-upcase name)) (,@args)
     (let ((string (shell (format nil "bluetoothctl ~a ~{~a ~}" ,name
                                  ,(if input
                                       `(mapcar (function ,input) (cl:remove '&optional (cl:list  ,@args)))
                                       (cl:remove '&optional `(cl:list ,@args)))))))
       ,(if output
            `(funcall ,output string)
            'string))))

(defun test (string)
  (shell (format nil "bluetoothctl ~a" string)))

(defun parse-device (string)
  (when string 
    (setf string (string-trim '(#\return) string))
    (let* ((mac-start (1+ (position #\space string)))
	   (name-start (1+ (position #\space string :start mac-start)))
	   (type (subseq string 0 (1- mac-start)))
	   (mac (subseq string mac-start (1- name-start)))
	   (name (subseq string name-start)))
      (cons name mac))))

(defun parse-devices (string)
  (mapcar #'parse-device (split-sequence:split-sequence #\newline string :remove-empty-subseqs t)))

(bt-cmd "power" (state) nil string-downcase)
(bt-cmd "devices" () 'parse-devices)
(bt-cmd "paired-devices" () 'parse-devices)
(bt-cmd "pair" (mac-string))
(bt-cmd "remove" (mac-string))
(bt-cmd "connect" (mac-string))
(bt-cmd "disconnect" (mac-string))
(bt-cmd "info" (mac-string))
(bt-cmd "trust" (mac-string))
(bt-cmd "untrust" (mac-string))
(bt-cmd "block" (mac-string))
(bt-cmd "unblock" (mac-string))
(bt-cmd "list")
(bt-cmd "show")
