# Quartermaster
Quartermaster is a native Sailfish OS Home Assistant client which aims to provide the same functionality like the offical Android/iOS app.  
[Home Assistant](https://www.home-assistant.io/) is an open source home automation platform written in Python

>![](icons/128x128/harbour-quartermaster.png)

## Current state of development
The development is in alpha state at the moment. Not everythings works perfectly and needs testing.

## Sailfish OS
This application is tested with Sailfish OS Versions:

- 3.4.0.24 (Pallas Yllästunturi)

## Implemented Features
Here is a list of all implemented features so far. Not all features listed below are finished or error free and are still in active development.

**Features:**

- Setup wizard for first start
- Authentification with Long-Lived Access Token (see "Authentication" section)
- Secure storage of all secrets using Sailfish-Secrets
- Device tracking using GPS (not tested well)
- Device tracking using available and connected wifi networks
- Device sensors:  
>  - *Battery level* 
>  - *Battery charging*
 
- Entity/Devices control:  
> 
>  - *Automation*
>  - *Cameras (only single pictures)*
>  - *Climate devices (partial)*
>  - *Groups*
>  - *Lights*
>  - *Persons*
>  - *Sensors*
>  - *Switches*
>  - *Zones*
 
- Home Assistant cloud support (not tested)
- Logging of API traffic for development purpose (deactivated by default)
- Update notification if an update of Home Assistant is available.
- Websocket connection for live updates of entity states
- Backup & Restore of settings (Wifi, more to come)
- Notifications from Home Assistant Server (see section "Home Assistant -> Notifications")
- Browse error log of Home Assistant
- Check if Home Assistant configuration is valid
- Internal web view of Home Assistant UI using Gecko engine (seperate login required / not very performant)

## Planned Features
- Two-Factor authentication to get access token (Qt OAuth2 functionality needs at least Qt 5.8 / Sailfish OS 3.4 has antique Qt 5.6 libraries)
- Autodetect Home Assistant server in local network during setup
- Encryption of API traffic (webhook api)
- Cover actions
- Automatically switch connection to server from remote to local url if connected to home network
- Access to history log
- More devices and entity types (need you help because I don't have all of them)
- More device sensors if requested
- Internal web view of Home Assistant UI without extra login
- all other feature requests

## Translations
Available translations:

- English
- German  
  
If you missing your native language you are welcome to support this project with your translation.

## Home Assistant Configuration
#### Components
To get this app working with Home Assistant you need to activate the following components:

- api
- mobile_app
- webhook
- websocket
- config

If you have "default_config:" in your configuration.yaml these components should already be active. If you need help please refer to [Home Assistant Documentation](https://www.home-assistant.io/docs/).

#### Remote Access

You can get remote access by obtaining a Home Assistant Cloud account (paid subscription needed) or you need to make the server accessible by internet. 
For self hosting you need a dedicated IP by your provider (not shared one) and a dynamic DNS service because domain name is mandatory since version 0.77.
Please refer to [Home Assistant Documentation](https://www.home-assistant.io/docs/configuration/remote/) for details.

I don't have a cloud account, so no guarantee that this works with this app. In theory it should, all functionality is available for this.

#### Notifications

Notifications can be received via websocket connection. At the moment only global notifications works (not device specific)

To send a notification you need to call the service "notify.notify" in Home Assistant:

	service: notify.notify
	data:
  		message: Tina comes home!
  		title: Tina Location

The values "message" and ""title" need to have data!

Please refer to [Home Assistant Documentation](https://www.home-assistant.io/docs/configuration/remote/) for details.

## Authentication
Authentication is only possible with a Long-Lived Access Token at the moment. 
You can create one in profile settings on your Home Assistant web interface.

## Device Tracking
Device tracking is turned of by default. You can activate it in the settings.
Keep in mind that tracking will increase battery usage!
For device tracking a remote access to Home Assistant is mandatory.

#### Wifi Tracking
To work with the wifi tracking you need to define zones inside your Home Assistant server.
Afterwards you can add wifi networks (AP) to the different zones in application settings.  
When your device connects to a tracked network, the app will send the location coordinates of the zone linked to this network as the new device location.


## Development Support
You can help with the development of Quartermaster.

#### Entities / Devices
If you miss some functionality of some devices or you have an unsupported one, you can provide necessary data for development.
In application settings you should turn on API logging to log all api traffic. Don't turn this on all the time, because it will generate a lot of data over time.
   
The files are stored in "Documents/harbour-quartermaster" folder. These files you can pack into an issue report here on GitHub.

## Donations

If you like my work, you can buy me a beer! 

[PayPal](https://www.paypal.com/paypalme/nubecula/1)

[Liberapay](https://liberapay.com/black-sheep-dev/donate)
