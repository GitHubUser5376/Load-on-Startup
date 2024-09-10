;; ------------------------------------------------------------------------------------------------ ;;
;; Loading Code Case ------------------------------------------------------------ Loading Code Case ;;

;; Startup notice required
(cond
    ;; Condition 01 - File has just been loaded
    (   (wcmatch (getvar "GETLSTCMD") "LOADAPPLICATION")
        (if (alert
                "Notice: For this file to work as intended, set this file to be enabled at startup. Proceed?"
                "Installation Notice"
                "QUESTION"
            )(progn
            (command "ADDINS")
            (alert
                (strcat
                    "For the commands to become available, close all "
                    (vla-get-name (vlax-get-acad-object))
                    " sessions. Make this session the last session to be close."
                );strcat
                "Restart Required"
                "INFORMTION"
            );alert
            (setq
                *AppID* (cdr (reverse (vl-string->list (vl-prin1-to-string (vlax-get-acad-object)))));; List
                *AppID* (substr (vl-list->string (reverse *AppID*)) (1+ (length (member 32 *AppID*)))); String
            );setq
            (setenv "WAIT-TO-CLOSE" *AppID*); Application must first be closed
            (setenv "STARTUP-LOADED" "TRUE")
        ));if<-progn
    ); Condition 01
    ;; Condition 02 - Load the contents
    (   (null (and
            (getenv "WAIT-TO-CLOSE")
            (setq
                *AppID* (cdr (reverse (vl-string->list (vl-prin1-to-string (vlax-get-acad-object)))));; List
                *AppID* (substr (vl-list->string (reverse *AppID*)) (1+ (length (member 32 *AppID*)))); String
            );setq
            (= (getenv "WAIT-TO-CLOSE") *AppID*)
        ));null<-and
        
        ;; First succesful startup notification
        (if (getenv "STARTUP-LOADED")(progn
            (alert "The LSP file has been successfully loaded." "Startup Load Successful")
            (setenv "STARTUP-LOADED" ""); Disabling notification
            (setenv "WAIT-TO-CLOSE" "");; Condition fulfilled
        ));if<-progn
        
        ;; Loading Code Case ---------------------------------------------------- Loading Code Case ;;
        ;; ---------------------------------------------------------------------------------------- ;;
        ;; Loading the Code ------------------------------------------------------ Loading the Code ;;
        
        (princ "The functions are being loaded.\n")
        (princ "The functions have been loaded.\n")
        
        ;; Loading the Code ------------------------------------------------------ Loading the Code ;;
        ;; ---------------------------------------------------------------------------------------- ;;
    ); Condition 02
);cond