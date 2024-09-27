# Config

copy `config-template.sh` to `config.sh` and edit the variable accordingly to
your settings

Set the display to run obs to. To get the value, start a remote desktop to your
server and run `echo $DISPLAY`. You could copy the value in here.
```
export DISPLAY=:10.0
```

Set the path where your obs-auto was cloned to.
```
obs_auto_path="/home/<user>/obs-auto"
```

Set the absolute path where to call obs-cli. 
To get it check https://github.com/pschmitt/obs-cli
```
obscli="/home/<user>/.local/bin/obs-cli"
```

In obs, enable websocket server and set the following variables based on it
```
obshost="localhost"
obspass="passkey"
obsport=4455
```

Folder where you songs are located and source item name where to load the files
```
music="/home/<user>/Music"
musicitem="playlist"
```

When switching from source to source, you can set a defined sleep value or a 
random one. The first variable is for the switching loop, the other one for
recording. For a defined value, use `echo SECONDS` with seconds the amount of
seconds to wait before changing source. For a randomize value you can use the
example provided using python.
```
switcher_sleep='/usr/bin/python3 -c "import random; print(random.randint(30,60))"'
record_sleep='echo 15'
```

When recording, do you want to force kill the switching loop and then restart
it ?
```
record_pause_loop=true
```

Space separated list of you camera sources item name. If you have text
dedicated for each camera, name the same but starting with `Text`. For example
if you camera is `Cam1` its text source should be `TextCam1`
```
camera="Cam1 Cam2 Cam3"
```

# Install crontab 

```
20 8 * * * sh -c "cd /home/<user>/obs-auto; ./obs-start.sh > obs-start.out "

30 8 * * * sh -c "cd /home/<user>/obs-auto; ./obs-stream-start.sh >> obs-stream-start.out "
30 18 * * * sh -c "cd /home/<user>/obs-auto; ./obs-stream-stop.sh >> obs-stream-stop.out "
30 10,13,16 * * * sh -c "cd /home/<user>/obs-auto; ./obs-record.sh >> obs-record.out "

40 18 * * * killall obs
```
