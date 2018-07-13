# PLAYKUBO installation process

## Phase 1/2: Install Raspberry Zero with Wifi support and SSH access

### Step 1 – Create a fresh SD card using Raspbian image

Create fresh SD card using the latest available Raspbian image from the Official Download page.

- Current version of PLAYKUBO was tested on release 2018-06-27-raspbian-stretch-lite.img

NOTE: This method must be completed before you boot this card for the first time. This is the point at which the system checks for the *wpa_supplicant.conf* file. If you have already booted the card you will need to re-write with a fresh image and continue!

### Step 2 – Bootstrap WiFi setup

Create a blank text file named *wpa_supplicant.conf*. Use a plain text editor rather than a Word Processor.

If using Windows you need to make sure the text file uses Linux/Unix style line breaks. I use Notepad++ (it’s free!) and this is easy to do using “Edit” > “EOL Conversion” > “UNIX/OSX Format”. “UNIX” is then shown in the status bar.

Insert the following content into the text file :

```
country=us
update_config=1
ctrl_interface=/var/run/wpa_supplicant

network={
 scan_ssid=1
 ssid="ssid_name"
 psk="secret"
}
```

Double check the SSID and password. Both the SSID and password should be surrounded by quotes.

The Country Code should be set the ISO/IEC alpha2 code for the country in which you are using your Pi. Common codes include :

- GB (United Kingdom)
- FR (France)
- DE (Germany)
- US (United States)
- SE (Sweden)

Copy *wpa_supplicant.conf* file to the boot partition on your SD card. In Windows this is the only partition you will be able to see. It will already contain some of the following files :

bootcode.bin
loader.bin
start.elf
kernel.img
cmdline.txt

### Step 3 - Enable SSH access

SSH is disabled by default but it is easy to enable by copying a blank text file named *ssh* to the boot partition. This can be done at the same time *wpa_supplicant.conf* is copied across.

## Step 4 – Eject, Insert and Boot

Safely remove the SD card from your PC and insert into the Pi. Power up the Pi and once it has booted you should be connected to your WiFi network.

You may be able to use your Router admin interface to list connected devices. Your Pi should appear in the list with an assigned IP address.

#### Fonts:

- https://www.raspberrypi-spy.co.uk/2017/04/manually-setting-up-pi-wifi-using-wpa_supplicant-conf/


## Phase 2/2: Bootstrap PLAYKUBO

### Requirements

- You need Ansible and other tools running on your cli. Please install them with the following comands:

    * apt-get install ansible git (linux)
    * brew install ansible git (mac)

## Step 1 - Test connectivity
```
ssh pi@raspberrypi.local
# password is "raspberry"
```

- If you failed to connect please open your Router admin interface and list your connected devices and update the Ansible Inventory file *hosts* according.
You may also try to run *nmap  -sn  192.168.1.0/24* in order to find your PLAYKUBO ip address.

### Install PLAYKUBO
```
git clone git@gitlab.com:freedomson/playkubo.git
cd playkubo
ansible-playbook -i hosts site.yml
```

### Ping PLAYKUBO
```
ansible all -m ping -vvv -i hosts
```