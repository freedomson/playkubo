# PLAYKUBO Tutorial 

# Phase 1: Your Own Access Point & Wifi Access

## Requirements

- Raspberry Pi Zero W
- 8gb SDCARD (and adapter for Desktop Computer)
- MacOSX or Linux Desktop Computer

## Installation Time
- ~15 minutes
- This is a headless setup so you will not be needing no monitor or any other devices to connect to your raspberry.

## Services 
- Headless Internet Service Provider (ISP) WiFi  setup.

- Private WiFi Access Point exposed.
SSID will be *[internet_provider_ssid]_PLAYKUBO*.

- Internet access shared with Private WiFi Access Point.

Below you can see an example for a internet provider SSID of <b>freedomson</b>:

![](https://gitlab.com/freedomson/playkubo/raw/5eb0224ff4bf0e5a43245f26062694e8eb6afc91/Image.png)


## 1. Install Raspberry Zero with Wifi support and SSH access

### 1.1 Create a fresh SD card using Raspbian image

Create fresh SD card using the latest available Raspbian image from the Official Download page.

- Current version of PLAYKUBO was tested on release 2018-06-27-raspbian-stretch-lite.img for more information please visit https://www.raspberrypi.org/downloads/raspbian/

NOTE: This method must be completed before you boot this card for the first time. This is the point at which the system checks for the <b>wpa_supplicant.conf<b/> file. If you have already booted the card you will need to re-write with a fresh image and continue!

### 1.2 Bootstrap WiFi setup

Create a blank text file named <b>wpa_supplicant.conf<b/>. Use a plain text editor rather than a Word Processor.

If using Windows you need to make sure the text file uses Linux/Unix style line breaks. I use Notepad++ (it’s free!) and this is easy to do using “Edit” > “EOL Conversion” > “UNIX/OSX Format”. “UNIX” is then shown in the status bar.

Insert the following content into the text file :

```
country=us
update_config=1
ctrl_interface=/var/run/wpa_supplicant

network={
 scan_ssid=1
 ssid="internet_provider_ssid_name"
 psk="internet_provider_secret"
}
```

Double check the SSID and password. Both the SSID and password should be surrounded by quotes.

The Country Code should be set the ISO/IEC alpha2 code for the country in which you are using your Pi. Common codes include :

- GB (United Kingdom)
- FR (France)
- DE (Germany)
- US (United States)
- SE (Sweden)

Copy <b>wpa_supplicant.conf<b/> file to the boot partition on your SD card. In Windows this is the only partition you will be able to see. It will already contain some of the following files :

bootcode.bin
loader.bin
start.elf
kernel.img
cmdline.txt

### 1.3 Enable SSH access

SSH is disabled by default but it is easy to enable by copying a blank text file named <b>ssh<b/> to the boot partition. This can be done at the same time <b>wpa_supplicant.conf<b/> is copied across.

## 1.4 Eject, Insert and Boot

Safely remove the SD card from your PC and insert into the Pi. Power up the Pi and once it has booted you should be connected to your WiFi network.

You may be able to use your Router admin interface to list connected devices. Your Pi should appear in the list with an assigned IP address.

## 2. Bootstrap PLAYKUBO

### 2.1 Requirements

- You need Ansible and other tools running on your cli. Please install them with the following comands:

    * apt-get install ansible git (linux)
    * brew install ansible git (mac)

### 2.2 Install PLAYKUBO
```
git clone git@gitlab.com:freedomson/playkubo.git
cd playkubo
ansible-playbook -i hosts site.yml
```

You PLAYKUBO access point SSID will be, *<b>internet_provider_ssid_name</b>_PLAYKUBO*

Your access secret will be *<b>PLAYKUBO</b>XXXX* where XXXX is a random 4 digit pin displayed at the bottom of your *ansible-playbook* run.

```
ok: [PLAYKUBO] => {
    "msg": [
        "INTERNET PROVIDER ACCESS POINT",
        "SSID:internet_provider_ssid_name",
        "PSK:internet_provider_ssid_secret",
        "",
        "PLAYKUBO ACCESS POINT",
        "SSID:<<internet_provider_ssid_name>>_PLAYKUBO", # Truncated at 32 chars maximum SSID string size
        "PSK:PLAYKUBOXXXX" # XXXX 4 digit random PIN
    ]
}
```

### 2.3 Troubleshoot

#### 2.3.1 Ping PLAYKUBO
```
ansible all -m ping -vvv -i hosts
```

#### 2.3.2 Test connectivity to raspberrypi

```
ssh pi@raspberrypi.local
# password is "raspberry"
```

- If you failed to connect please open your Router admin interface and list your connected devices and update the Ansible Inventory file *hosts* according.
You may also try to run *nmap  -sn  192.168.1.0/24* in order to find your PLAYKUBO ip address.

### 3. Credits

- https://albeec13.github.io/2017/09/26/raspberry-pi-zero-w-simultaneous-ap-and-managed-mode-wifi/

- https://gist.githubusercontent.com/lukicdarkoo/6b92d182d37d0a10400060d8344f86e4

- https://www.raspberrypi-spy.co.uk/2017/04/manually-setting-up-pi-wifi-using-wpa_supplicant-conf/

- https://www.labnol.org/software/find-wi-fi-network-password/28949/

- https://blog.thewalr.us/2017/09/26/raspberry-pi-zero-w-simultaneous-ap-and-managed-mode-wifi/

- https://www.regextester.com

- and many more ...