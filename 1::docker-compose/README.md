
## SmartCow - Task 1::
### DOCKER COMPOSE [ MULTI CONTAINER SETUP ] + WEBSERVER(NGINX - REVERSE PROXY) + APPSERVER(GUNICORN)

`DOCKER COMPOSE :`

1. Stay at root (where you have the docker-compose.yml)
    ```bash
    $ cd <root directory > ex: 1::docker-compose
    ```    

2. `Build` the images 
    ```bash
    $ docker-compose build
    ```
3. `Run` the containers
    ```bash
    $ docker-compose up -d

    ```
4. Bring `down` the containers : ***Optional***
    ```bash
    $ docker-compose down
    ```
5. Alternatively, can run `run_docker.sh` - it would delete currently running dockers on the local machine and rebuild the dockers and brung them up : ***Optional***
    ```bash
    $ cd <root directory > of the subproject => 1::docker-compose
    $ ./run_docker.sh 
    ```
    ![](./img/1-docker_ps.png)


`VALIDATE :`

1. Access SmartCow Stats UI on any `browser`

    ```bash
    $ http://localhost
    ```  
    `Recorded and attached a .gif for better review` 
    
    ![](./img/gif/1-validate-localhost.gif)
   

    `Note` : UI would take ~1 min to come up and eventually for NGINX to proxy the request and send the response back to the browser


2. Can check the response of both the backend(flask) and frontend(node application) 

    `backend - gunicorn serving flask app exposed at 8000; endpoint "/stats"`
    ```bash
    $ http://localhost:8000/stats
    ```  
    
`CURRENT APPROACH :`

1. Dockerise the frontend, backend and the webserver/proxy (nginx)

    `Original Project Structure` 
    ```bash

    $ (smartCow-venv) ➜  SmartCow git:(pvt/dkagitha/task-1) ✗ tree  -I 'smartCow-venv|node_modules|*pycache*'
    .
    ├── README.md
    ├── REQUIREMENTS.md
    ├── api
    │   ├── app.py
    │   └── requirements.txt
    ├── img
    │   └── readme.jpg
    └── sys-stats
        ├── README.md
        ├── package-lock.json
        ├── package.json
        ├── public
        │   ├── favicon.ico
        │   ├── index.html
        │   ├── logo192.png
        │   ├── logo512.png
        │   ├── manifest.json
        │   └── robots.txt
        ├── src
        │   ├── App.css
        │   ├── App.js
        │   ├── App.test.js
        │   ├── index.css
        │   ├── index.js
        │   ├── logo.svg
        │   ├── reportWebVitals.js
        │   └── setupTests.js
        └── yarn.lock

    5 directories, 23 files
    ```
    Structure the existing into (reduced the tree level o/p to 4 as the `public` and `src` directory content is unaltered )

    ```bash
        ➜  1::docker-compose git:(pvt/dkagitha/task1) ✗ tree  -I 'smartCow-venv|node_modules|*pycache*|AWSCLIV2.pkg|img' -L 4
        .
        ├── README.md
        ├── api
        │   └── docker
        │       ├── Dockerfile
        │       ├── README.md
        │       ├── core
        │       │   ├── app.py
        │       │   ├── requirements.txt
        │       │   └── wsgi.py
        │       └── entrypoint.sh
        ├── docker-compose.yml
        ├── nginx
        │   ├── Dockerfile
        │   ├── nginx.conf
        │   └── server.conf
        ├── run_docker.sh
        └── sys-stats
            ├── README.md
            └── docker
                ├── Dockerfile
                ├── core
                │   ├── package.json
                │   ├── public
                │   ├── src
                │   └── yarn.lock
                └── entrypoint.sh

        9 directories, 17 files
    ```    

    `1.1` Dockerise :: Flask 

    - Structure the existing api directory (flask app) into 
        
        ```bash
        ➜  api git:(pvt/dkagitha/task1) ✗ tree  -I 'smartCow-venv|node_modules|*pycache*|AWSCLIV2.pkg|img'     
        .
        └── docker
            ├── Dockerfile
            ├── README.md
            ├── core
            │   ├── app.py
            │   ├── requirements.txt
            │   └── wsgi.py
            └── entrypoint.sh

        2 directories, 6 files
        ```    
    
    - So added each of the original component level code into a docker directory each and moved the core application into `core` directory unaltered. In the docker directory added the 
        -   `Dockerfile` - Snippet, access the Dockerfile for complete content

            -The working directory is `core`, since the application code is moved into core directory
            ```
            WORKDIR /core
            COPY ./core /core            
            ```
            
            -`ENTRYPOINT` would be an execution of a bash file , we can either pass an CMD or run the gunicorn command in `docker-compose` , more details in `BEST PRACTICES` section
            ```
            COPY ./entrypoint.sh /
            RUN chmod +x /entrypoint.sh
            ENTRYPOINT [ "/entrypoint.sh" ]
            ```
            -`entrypoint.sh` - Initialising gunicorn(WSGI server), now the python-flask application - a WSGI compliant web app can be now bridged/hooked to the web facing webserver like nginx.         

            ```
            exec gunicorn wsgi:app \
            --name flask_docker \
            --bind 0.0.0.0:8000 \
            ```

        -   In the `api` directory added the `wsgi` directory as the main function to call the `app` and later pass the gunicorn(WSGI server) command via `entrypoint.sh` to serve the flask application at port `8000` 

    - So now we can build the backend flask app docker standalone by running `docker` commands 

        ```bash
        $ cd 1::docker-compose/api/docker
        $ docker build -t sc-app .
        $ docker run -d -i sc-app:latest

        # To check if the docker container status
        $ docker ps 

        # curl to see the application response
        $ curl http://localhost:8000/stats

        ```
    `1.2` Dockerise :: nginx 

    - Structure the existing api directory (flask app) into 
        
        ```bash
        ➜  nginx git:(pvt/dkagitha/task1) ✗ tree  -I 'smartCow-venv|node_modules|*pycache*|AWSCLIV2.pkg|img' 
        .
        ├── Dockerfile
        ├── nginx.conf
        └── project.conf

        0 directories, 3 files
        ```    

    - So added a 
        -   `Dockerfile` - file would contain the actions to remove the default nginx.conf and default.conf and replace with the customised content in project.conf - which would contain the reverse proxy info 
        -   Default `nginx.conf` - which would provide the user details , the number of workers and log info 
        -   Custom `project.conf` - which would contain the server info

        `Recorded and attached a .gif for better review- Check the complete nginx setup here` 

        ![](./img/gif/1-vaildate-nginx.gif)

    `1.3` Dockerise :: React  

    - Structure the existing api directory (flask app) into 
        
        ```bash
        ➜  sys-stats git:(pvt/dkagitha/task1) ✗ tree  -I 'smartCow-venv|node_modules|*pycache*|AWSCLIV2.pkg|img' -L 4
        .
        ├── README.md
        └── docker
            ├── Dockerfile
            ├── core
            │   ├── package.json
            │   ├── public
            │   │   ├── favicon.ico
            │   │   ├── index.html
            │   │   ├── logo192.png
            │   │   ├── logo512.png
            │   │   ├── manifest.json
            │   │   └── robots.txt
            │   └── src
            │       ├── App.css
            │       ├── App.js
            │       ├── App.test.js
            │       ├── index.css
            │       ├── index.js
            │       ├── logo.svg
            │       ├── reportWebVitals.js
            │       └── setupTests.js
            └── entrypoint.sh

        4 directories, 18 files
        ```    

    - So added a `Dockerfile` - Move all the original content into `core` directory and added `entrypoint.sh` to add the `yarn` and `npm` command.
    - entrypoint.sh content 

        ```
        #!/bin/sh

        ## Can use NPM for dev like environments

        # npm install
        # # npm build
        # npm start

        ## Alternatively can use YARN for production like environments

        yarn cache clean
        yarn config set registry https://registry.npmjs.org
        rm yarn.lock
        yarn
        yarn install
        yarn build
        yarn start
        ```


`BEST PRACTICES :`

1. Usually in ideal setup, we ought to have 
    - Tests, 
    - Configuration and Data directories  
    - Log aggregrator (could be a custom choice as like we use in Oracle ( it's called `Lumberjack` ) or can choose any open source tool like `ELK`, `Graylog` or `Fluentd`)
    - Monitoring setup like `Prometheus`  
    - Build management tool related content like `gradle`   
    
    ```
    .
    ├── README.md
    ├── api
    │   └── docker
    │       ├── Dockerfile
    │       ├── README.md
    │       ├── core
    │       │   ├── app.py
    │       │   ├── requirements.txt
    │       │   └── wsgi.py
    │       └── entrypoint.sh
    ├── docker-compose.yml
    ├── nginx
    ├── build
    │   ├── README.md
    │   ├── classes
    │   ├── docker
    │   │   ├── Dockerfile
    │   │   ├── artifacts
    │   │   └── log_aggregator
    │   │            └── run
    │   ├── jacoco
    │   ├── libs
    │   ├── test-results
    │   ├── project.conf
    ├── run_docker.sh
    ├── build.gradle
    ├── gradle
    │   ├── docker.gradle
    │   └── wrapper
    │       ├── gradle-wrapper.jar
    │       └── gradle-wrapper.properties
    ├── gradle.properties
    ├── gradlew
    ├── gradlew.bat
    ├── settings.gradle
    └── src
        ├── main
        │   ├── PrometheustelemetryInitializer
        │   └── resources
        │       └── logback.xml

    ``` 
2. Can initiate gunicorn in various ways 
    - `CMD` : 
        - `CMD [ "gunicorn", "-w", "1" ,"-b","0.0.0.0:8000", "wsgi:app" ] `
        - EXEC form
        - CMD sets a default command but can always be overwritten from command line when docker container runs.
    - `ENTRYPOINT` : Current Implementation 
        - ENTRYPOINT command and parameters will not be overwritten from command line unlike CMD but rather all command line arguments will be added to the existing entrypoint parameters.
    - `docker-compose.yml` : 
        - `command: gunicorn -w 1 -b 0.0.0.0:8000 wsgi:app` 
        - SHELL form
    
3. We need both the wsgi compliant application webserver like gunicorn, uwsgi to be compliant with  - Nginx has some web server functionality (e.g., serving static pages; SSL handling) that gunicorn does not, whereas gunicorn implements WSGI (which nginx does not).

4. Can have ssl configuration in the server.conf of nginx to serve the requests with `https` and port `443` 

    ```bash
        server {
        listen                *:80;
        listen                443 ssl;
        server_name           smartcow-stats.info;
        ssl on;
        ssl_certificate           /etc/letsencrypt/live/smartcow-stats.info/cert.pem;
        ssl_certificate_key       /etc/letsencrypt/live/smartcow-stats.info/privkey.pem;
        }
    ```

5. Run all the dockers as `non-root` user by creating and adding to a group as a good security practice   

    ```
    ENV APP_USER=smartcow
    ENV APP_HOME=/home/$APP_USER
    RUN groupadd -r $APP_USER && \
    useradd -rm -d $APP_HOME -s /bin/bash -g root -G sudo -u 1001 $APP_USER 
    ```
