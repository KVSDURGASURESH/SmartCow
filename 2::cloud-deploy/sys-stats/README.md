# SmartCow UI

### PRE-REQUISITE

1. First clone this repository.
```bash
$ git clone https://github.com/KVSDURGASURESH/SmartCow.git
```

### To Run App in Docker

1. Checkout `Dockerfile`

2. To build docker image 

    ```bash
    $ cd < Dockerfile directory >
    ```

    ```bash
    $ docker build -t smartcow-ui:latest .
    ```
3. To run the docker container 
    ```bash
    $ docker run -d --name smartcow-ui -p 3000:3000  smartcow-ui:latest
    ```
4. To access in browser , enter the following in the URL field
    ```bash
    http://localhost:3000/
    ```
