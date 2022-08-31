# OTA using KAS, RAUC and HAWKBIT

## Steps for KAS build
1. Download KAS using below command
    ```sh
    git clone https://github.com/siemens/kas
    ```
2. Download LithOS Repo using below command
    ```sh
    git clone https://github.com/TechnocultureResearch/LithOS -b kirkstone
    ```


## Steps to run HAWKBIT Server

### Initialization and Target Creation
1. Open the hawkBit UI in a web browser by visiting `http://172.105.43.69:8080` and login with the default username `admin` and password `admin`.
2. Enable authentication via a security token for now. This can be changed with `System Config → Allow targets to authenticate directly with their target security token`:
![image1](https://user-images.githubusercontent.com/33483920/186618984-7e83d47d-053e-47a0-a780-cce03c2e9505.png)


Save the changes by clicking on the save icon at the bottom of the screen.

> **Note**
> 
> To reduce the time between checking for new updates, you may change the polling time in the System Config to a minimum of 30 seconds. This is helpful when testing the update system, as otherwise, you may have to wait for up to 5 minutes (default polling time) before the updated bundle is downloaded.

3. Next, create a new target device in hawkBit. On the Deployment page click the plus sign next to Targets:
Enter a target controller ID to your liking. This should be human-readable, e.g. in this case, `raspberrypi4` was entered. Retrieve the security token by looking into the target's Details tab:
![image2](https://user-images.githubusercontent.com/33483920/186618979-aeb68402-2b19-459e-8a55-006bd36e2915.png)
4. Modify config.conf file from `LithOS/poky-kirkstone/meta-microfabricator/recipes-apps/microfabricator/files` path with  
```sh
hawkbit_server            = <ip of hawkbit server>:8080
auth_token                = <security token>
target_name               = raspberrypi4
```
> Keep the other settings in `config.conf` as it is.
5. Compile microfabricator-image using below command after these changes are done then flash it to the device then only OTA update can be downloaded to the device.
    ```sh
    $PATH_TO_KAS_DIR/kas-container build kirkstone.yaml
    ``` 
    
6. To prepare bundle image use the below command
    In `kirkstone.yaml` file change the below variable
    - From: `target: microfabricator-image`
    - To: 
        `target: update-bundle`
        > Also to differentiate the bundle add the below line in yaml file `IMAGE_INSTALL:append = “ nano”`
7. Build with these parameters to get the update bundle package

> **Note**
> 
> `microfabricator.service`,`mfab-status-led.service`, `rauchawkbitupdate.service` all services will be started automatically during the system boot.

### Uploading RAUC Bundles to the hawkBit Server
In hawkBit, an update is split into subcategories to accommodate for various combinations of operating system and application updates. For this example, we will focus on OS updates only.

1. First, create a new software module by clicking on the plus sign in the Upload category under Software Module:
![image3](https://user-images.githubusercontent.com/33483920/186618903-b7ea5349-3edb-4e88-85f3-c4b051ec3910.png)
2. Enter a name and version to your liking. This software module will contain a full OS bundle. Click on Upload File and choose a fitting RAUC bundle provided by your own custom build.
![image4](https://user-images.githubusercontent.com/33483920/186618935-85f62e7e-eee7-4125-bb9f-9946c0143ec0.png)
![image5](https://user-images.githubusercontent.com/33483920/186618941-69000a1c-aaf1-49ba-bcaf-fd3a55b54cfe.png)
3. Create distribution as below
![image6](https://user-images.githubusercontent.com/33483920/186618945-11cc7366-d93c-491d-a35e-5a7872f44948.png)
4. Now the software module must be assigned to a new distribution.Drag and drop the software module to the newly created distribution:
![image7](https://user-images.githubusercontent.com/33483920/186618951-b6b8d6ae-b8e5-45c3-b568-7afdba069b56.png)
5. We will get a notification saying software module assigned with distribution as below:
![image8](https://user-images.githubusercontent.com/33483920/186618953-e7adb681-780e-4a17-9dee-69f858daf629.png)

### Deploying RAUC Bundles from hawkBit to the Device
1. To issue an update drag and drop the previously created distribution onto the target on the Deployment Management page. Select Forced when assigning the distribution to the target.
![image9](https://user-images.githubusercontent.com/33483920/186618961-625c0bd5-25cd-4d54-9fe4-d3870dfb4046.png)
2. After drag and drop the server will start upgrade the bundle as below
![image10](https://user-images.githubusercontent.com/33483920/186618967-8b496125-f6c4-4c42-ba43-9c7620322abf.png)
3. Once the upgrade is successful we will get notification like below
![image11](https://user-images.githubusercontent.com/33483920/186618972-aa3d3871-50d3-4ef7-920f-1bd830a2c007.png)

---

Reference for Update Server: [Hawkbit](https://www.eclipse.org/hawkbit/gettingstarted/)

- On the server at `172.105.43.69`.

```sh
$ git clone https://github.com/eclipse/hawkbit.git
$ cd hawkbit/hawkbit-runtime/docker
$ docker-compose up -d
```
