# SmartCow App

### To Run App in Docker

1. First clone this repository.
```bash
$ git clone https://github.com/KVSDURGASURESH/SmartCow.git
```


2. Checkout `Dockerfile`.

3. Changed it to accomodate latest version of ubuntu and `python3`

4. To build docker image . 

    ```bash
    $ cd < Dockerfile directory >
    ```
    
    ```bash
    $ docker build -t smartcow-app:latest .
    ```
5. To run the docker container 
    ```bash
    $ docker run -it -d --name smartcow-app -p 5000:5000  smartcow-app:latest
    ```

6. To access in browser , enter the following in the URL field
 
    ```bash
    http://localhost:5000/stats
    ```
    
    curl -X GET 'http://localhost:5000/stats' -H 'Content-Type: application/json'
