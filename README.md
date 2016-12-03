# HubbleNux
This is the Linux client for Hubble

## Install

First you will need libstatgrab : 
[https://www.i-scream.org/libstatgrab/](https://www.i-scream.org/libstatgrab/)

Then install the perl deps : 

    cpanm --installdeps -L local .
   
## Usage

You can run the client with the following command : 

    perl -Mlocal::lib=local -Ilib hubble_linux -u your_device_uid -s your_device_secret -e http://YouHubbleEndpoint/
    
## Todo 

- Proper logging
- Device secret/uid in config instead of parameters
- Drives detections
- libstatgrab auto install ? 
