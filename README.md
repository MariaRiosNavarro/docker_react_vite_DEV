# docker_react_vite_DEV

## HOW TO CREATE A REACT_VITE_DEV_IMAGE & CONTAINER

### 1. CREATE A NODE CONTAINER AND RUN A VITE PROJECT INSIDE (npm i).

1a. Create a node in an Alpine container as a shell (sh)

```
docker run -it node:alpine sh
```

Example:

![](/readme_img/1.png)

1b. Check the content if you want

```
ls -l
```

Example:

![](/readme_img/2.png)

1c. Go inside the folder you want to install Vite or skip this step and install directly. Where the project is installed is important later when we copy it (Step 2c). We will need the path where Vite is installed. I chose to install it in the home folder, so the path for me later will be: /home/project_name

```
cd home
```

Example

![](/readme_img/3.png)

1d. Install your Vite Project (I used the --template react, but you can skip this if you want to select it in the setup process)

```
create vite@latest your_react_project_name -- --template react
```

Example

![](/readme_img/4.png)

1e. Follow Vite's typical instructions

![](/readme_img/4a.png)

1f. Navigate inside your app with the name you have given to it

```
cd your_react_project_name

```

Example: I used cd react_dev_in_alpine

1g. Check the inside of this folder if you like

```
ls -l
```

1h. VERY IMPORTANT, don't forget to do npm i, to install all the dependencies and have a Vite/React project in Alpine.

```
npm i
```

Example:

![](/readme_img/5.png)

1i. DON'T close this terminal for now and open a new one for step 2

---

### 2. IN ANOTHER TERMINAL, IN THE FOLDER OF YOUR PROJECT, COPY THE CONTENT OF THE VITE PROJECT OF THE FIRST CONTAINER

(The example for Step 2 is below all together)

2a. To copy, we need the name or ID of the created NODE container with the React-Vite app inside. To find the ID or the name of the created node container, use:

```
docker ps
```

or

```
docker container ls -a
```

You can find the ID and name in Docker Desktop too. Here in the example of the photos, the ID begins with 1b350 (we need it later in 2c). ALSO, Save your ID or Name for step 2c.

2b.- Now navigate to the place where you want to have your dev project

```
cd your_dev_project_place
```

2c.-And now you can COPY the content of the react-vite app inside the folder (for the `path_of_vite_project_in_the_node_container` read 1c, for `saved_id_or_name` read the end of 2a). Dont forget the small `.` at the end!:

```
docker cp saved_id_or_name:path_of_vite_project_in_the_node_container .
```

2e.- You can now to see if the project is copied.

```
ls
```

2f.-Now you can navigate inside and open your IDE for this project. I used VSC, also i use `code .`

```
cd name_your_project

```

Example:

![](/readme_img/6.png)

---

### 3. OPEN YOUR PROJECT IN YOUR IDE AND ADD THE DOCKERFILE, CREATE AN IMAGE OF THIS AND CREATE A CONTAINER OF THIS IMAGE, WITH YOUR PROJECT PATH AS VOLUME

3a. In the IDE in the project, create a new Dockerfile with this content and save

```
FROM node
WORKDIR /name_your_project
COPY . .
EXPOSE 5173
CMD ["npm","run", "dev", "--", "--host"]

```

3a. Now you can create a new image of this project. Give the name you want to the image and don't forget the `.` at the end

```
docker -t name_of_the_image .
```

Example:

![](/readme_img/7.png)

3b. Now you can create a container from this image with the volume direction in your project

```
docker run -d -p new_port_you_want:port_in_dockerfile -v ${pwd}:/name_your_project name_of_the_image

```

Example:

![](/readme_img/8.png)

3c. Now when you change something in your code in your React project in the IDE and save, you will see the changes in the port you used for your container. In the example here, the 9009

Example:

![](/readme_img/9.png)

IMPORTANT: You can now stop and remove the first node/alpine container with the first vite app, to keep your docker tidy
