# siriproxy-ninjablock

Integrates NinjaBlock with Siri-Proxy. This allows you to interact with the Ninja Block API via Siri.

## Requirements

* [NinjaBlock API](https://github.com/ninjablocks/ruby-ninja-blocks)
* [SiriProxy](https://github.com/plamoni/SiriProxy)

Note: the Install guide below covers installation of everything.

## Install

Add this configuration entry to your ~/.siriproxy/config.yml:

```
    - name: 'NinjaBlock'
      git: 'git://github.com/samgregory/siriproxy-ninjablock'
      token: 'YOUR API TOKEN'
```

Don't forget to supply your API Token.

Then run siriproxy bundle (this will load the plugin from this git repository and install the ninjablock gem if needed)

## Guide

Below is a full guide to get Siri Proxy running on a Ninja Block (Beagle Bone)

1. Install pre-requisites. If this fails at first, run the command again.

	`sudo apt-get install libxslt1.1 libxslt-dev xvfb build-essential git-core curl libyaml-dev libssl-dev`
	
2. Download and install RVM (if you don't have it already):
	* Download/install RVM:  
		`curl -L https://get.rvm.io | bash -s stable --ruby`  
	* Update .bashrc:  
		`echo '[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"' >> ~/.bashrc`
		`echo 'export PATH=$HOME/.rvm/bin:$PATH' >> ~/.bashrc`  
	* Activate changes:  
		`. ~/.bashrc`   

3. Confirm that Ruby 2.0.0 (installed by default) will run:   

	`ruby --version`  

4. Now install the siriproxy gem:

```
gem install siriproxy
```

5. Create the ~/.siriproxy configuration directory (in your home):

```
mkdir ~/.siriproxy
```

6. Copy over the example configuration file to your siriproxy configuration directory:

```
cp ~/.rvm/gems/ruby-2.0.0-p???/gems/siriproxy-0.5.4/config.example.yml ~/.siriproxy/config.yml
```

7. Edit the ~/.siriproxy/config.yml file using a text/code editor and add this entry to the plugin section with the proper values:

```
    - name: 'HaikuHelper'
      git: 'git://github.com/samgregory/siriproxy-ninjablock.git'
      token: 'YOUR API TOKEN`

* Tip: Be careful to use exact spacing in the config.yml file as the YML format is indentation-sensitive.

8. Run the siriproxy command to bundle the siriproxy-ninjablock plugin:

```
siriproxy bundle
```

9. Generate the certificates for siriproxy:

```
siriproxy gencerts
```

10. Transfer the generated certificate (ca.pem) to your phone (you will need to sftp into your NB and get the file from):

```
~/.siriproxy/ca.pem
```

11. On you your iOS devices, open the e-mail and tap the ca.pem and accept it to add it to your certificate chain.

12. Tell your phone to use your Ninja Block's LAN IP as its DNS server (under Settings > Wi-Fi > Your network)

13. Start SiriProxy (replace XXX.XXX.XXX.XXX with the LAN IP of the NinjaBlock):

```
rvmsudo siriproxy server -d XXX.XXX.XXX.XXX -u nobody
```

* If you get an error about port 443 or 53 being in use, make sure you are not running a web server or DNS server. 


14. Test the server by telling Siri "test siri proxy"

Note: You can update siriproxy and siriproxy-ninjablock in the future by running:

```
siriproxy update
```

Note: Further information on installing SiriProxy is available on the project's github page. 

## Vocabulary

Then, once you have it working, here are some of the commands, many can be prefixed/suffixed as you wish. The format of this section is:

```
required
{required} or {required|choose|one|of}
(optional) or (optional|choose|one|of)
```

### Control commands:

* (Run) (the) {button_name} {button|rule}
* (Turn) all lights {on|off}
* {Turn on|Turn off|Brighten|Dim} (the) {light_name} (in (the) {room_name}))
* {Set|Change} (the) {light_name} (level) (in (the) {room_name}) to {0-100} (percent)
* {Set|Change} (the) {room_name} scene to {a|b|c|d|one|two|three|four}

### Query commands:

* What is the outdoor temperature?
* What is the outdoor humidity?
* What is the {temperature|humidity} {in|on|at|for} (the) {thermostat_name}?
* What is the {value|high setpoint|low setpoint} for (the) {sensor_name}?
* What time is (the) {sunrise|sunset} (time)?

### Examples:

* Change the basement heat setpoint to 21 degrees
* Turn off the chandelier in the living room
* Turn on the fireplace pot lights
* Dim the chandelier in the foyer
* Change the fireplace pot lights level to 50 percent
* Turn all lights off
* What is the outdoor humidity?
* What is the front door status?
* What is the temperature on the main level?
* What is the sunset time?


## License

MIT

## Links

* https://github.com/plamoni/SiriProxy
* http://ninjablocks.com/

## Contributing

* Fork the project.
* Make your feature addition or bug fix.
* Send me a pull request.
