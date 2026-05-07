# make sure not to make calls too often

# get time of last call
get_gwasapi_time <-
function()
{
   last <- as.numeric(Sys.getenv("GWASapi_time"))
   ifelse(is.na(last), 0, last)
}

# set gwasapi time to current
set_gwasapi_time <-
function() {
    Sys.setenv(GWASapi_time = as.numeric(Sys.time()))
}

# time since last call
time_since_gwasapi <-
function() {
    as.numeric(Sys.time()) - get_gwasapi_time()
}

# check for last time since call, and delay if necessary
# also re-set the gwasapi_time
delay_if_necessary <-
function()
{
    # look for delay amount in options; otherwise set to default
    delay_amount <- getOption("GWASapi_delay")
    if(is.null(delay_amount)) {
        delay_amount <- 10 # default delay time is 10 secs
    }

    if((timesince = time_since_gwasapi()) < delay_amount) {
        Sys.sleep(delay_amount - timesince)
    }

    set_gwasapi_time()
}
