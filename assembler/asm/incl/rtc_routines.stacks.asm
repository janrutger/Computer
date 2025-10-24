# .CODE

    MALLOC $RTC_VALUE 12247
    . $SYSTEM_EPOC 1
    . $SYSTEM_TIME 1
    

    # updates the system_time from the 
    # received valu in $RTC_VALUE
    @RTC_ISR
        ldm A $RTC_VALUE
        sto A $SYSTEM_TIME
    rti                 ; return from interrupt

# .FUNCTIONS
@INIT_RTC

        sto Z $SYSTEM_TIME          ; reset the system time

        :rtc_init_loop              ; wait for the current time
            ldm A $SYSTEM_TIME
            tste Z A 
            jmpt :rtc_init_loop

        sto A $SYSTEM_EPOC
        ret
