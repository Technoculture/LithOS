# OTA using KAS, RAUC and HAWKBIT

## Steps for KAS build
- Download KAS using below command
```sh
git clone https://github.com/siemens/kas
```

- Download LithOS Repo using below command
```sh
git clone https://github.com/TechnocultureResearch/LithOS -b kirkstone
```

- Compile microfabricator-image using below command
```sh
$PATH_TO_KAS_DIR/kas-container build kirkstone.yaml
```

To prepare bundle image use the below command
In `kirkstone.yaml` file change the below variable
- From: `target: microfabricator-image`
- To: 
    `target: update-bundle`
    > Also to differentiate the bundle add the below line in yaml file `IMAGE_INSTALL:append = “ nano”`

> **Note**
> 
> microfabricator.service,mfab-status-led.service ,rauchawkbitupdate.service all services will be started automatically during the system boot.

## Steps to run HAWKBIT Server

### Initialization and Target Creation
1. Open the hawkBit UI in a web browser by visiting `http://172.105.43.69:8080` and login with the default username `admin` and password `admin`.
2. Enable authentication via a security token for now. This can be changed with `System Config → Allow targets to authenticate directly with their target security token`:

Save the changes by clicking on the save icon at the bottom of the screen.

> **Note**
> 
> To reduce the time between checking for new updates, you may change the polling time in the System Config to a minimum of 30 seconds. This is helpful when testing the update system, as otherwise, you may have to wait for up to 5 minutes (default polling time) before the updated bundle is downloaded.

3. Next, create a new target device in hawkBit. On the Deployment page click the plus sign next to Targets:
Enter a target controller ID to your liking. This should be human-readable, e.g. in this case, `raspberrypi4` was entered. Retrieve the security token by looking into the target's Details tab:

4. Modify config.conf file from `LithOS/poky-kirkstone/meta-microfabricator/recipes-apps/microfabricator/files` path with  
```sh
hawkbit_server            = <ip of hawkbit server>:8080
auth_token                = <security token>
target_name               = raspberrypi4
```
> Keep the other settings in `config.conf` as it is.

### Uploading RAUC Bundles to the hawkBit Server
In hawkBit, an update is split into subcategories to accommodate for various combinations of operating system and application updates. For this example, we will focus on OS updates only.

1. First, create a new software module by clicking on the plus sign in the Upload category under Software Module:
2. Enter a name and version to your liking. This software module will contain a full OS bundle. Click on Upload File and choose a fitting RAUC bundle provided by your own custom build. 
3. Create distribution as below
4. Now the software module must be assigned to a new distribution.Drag and drop the software module to the newly created distribution:
5. We will get a notification saying software module assigned with distribution as below:

### Deploying RAUC Bundles from hawkBit to the Device
1. To issue an update drag and drop the previously created distribution onto the target on the Deployment Management page. Select Forced when assigning the distribution to the target.
2. After drag and drop the server will start upgrade the bundle as below
3. Once the upgrade is successful we will get notification like below
