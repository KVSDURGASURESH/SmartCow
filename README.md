# DevOps-Assignment

- Specifi version pf python packages , mention accordingly in requirement.txt
- Python virtual environment ( Mac) - https://uoa-eresearch.github.io/eresearch-cookbook/recipe/2014/11/26/python-virtual-env/
    pip install virtualenv
    virtualenv smartCow-venv
    source smartCow-venv/bin/activate


- tree  -I "smartCow-venv|node_modules|*pycache*"

(smartCow-venv) ➜  SmartCow git:(pvt/dkagitha/task-1) ✗ tree  -I "smartCow-venv|node_modules|*pycache*"
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



➜  1-docker-compose git:(pvt/dkagitha/task1) ✗ tree  -I "smartCow-venv|node_modules|*pycache*" -L 3
.
├── README.md
├── api
│   └── docker
│       ├── Dockerfile
│       ├── README.md
│       ├── core
│       └── entrypoint.sh
├── docker-compose.yml
├── nginx
│   ├── Dockerfile
│   ├── nginx.conf
│   └── project.conf
├── run_docker.sh
└── sys-stats
    ├── README.md
    └── docker
        ├── Dockerfile
        ├── core
        └── entrypoint.sh

7 directories, 12 files

ERRORS:

smartcow-app
E: Package 'python-pip' has no installation candidate -- > changed iot python3 to make it work

smartcow-ui
/home/app/node_modules/terser-webpack-plugin/node_modules/p-limit/index.js:29
                } catch {}
                        ^

SyntaxError: Unexpected token {
    at createScript (vm.js:80:10)
    at Object.runInThisContext (vm.js:139:10)
    at Module._compile (module.js:616:28)
    at Object.Module._extensions..js (module.js:663:10)
    at Module.load (module.js:565:32)
    at tryModuleLoad (module.js:505:12)
    at Function.Module._load (module.js:497:3)
    at Module.require (module.js:596:17)
    at require (internal/module.js:11:18)
    at Object.<anonymous> (/

--node version change from node:8.10.0-alpine to node:12.19.0-alpine



Serving React frontend and Flask backend using Nginx as a reverse proxy

react app --> nginix --> gunicorn --> flask


Kubernetes:

https://minikube.sigs.k8s.io/docs/drivers/virtualbox/
Minikube -https://minikube.sigs.k8s.io/docs/start/

curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-amd64
sudo install minikube-darwin-amd64 /usr/local/bin/minikube


minikube credentials

docker
tcuser

k8s
docker build -t dkagitha/k8s-smartcow-app .
docker push dkagitha/k8s-smartcow-app

RUN apk --no-cache add curl

curl -X GET 'http://localhost:5000/stats' -H 'Content-Type: application/json'

curl -X GET 'http://smartcow-app-service:5000/stats' -H 'Content-Type: application/json'

http://smartcow-app-service:5000/stats

unable to connect to minikune ingress 

and also DNS

➜  3::kubernetes git:(pvt/dkagitha/task1) ✗ minikube service smartcow-app-service -n smartcow --url
http://192.168.99.101:30883
➜  3::kubernetes git:(pvt/dkagitha/task1) ✗ minikube ip                                            
192.168.99.101


#2 :

Gradle 

build management and dockerpush

incremetal build

Cloud AWS 
- command line
https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 649577765057.dkr.ecr.ap-south-1.amazonaws.com

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 649577765057.dkr.ecr.us-east-1.amazonaws.com


The URL for your default private registry is https://aws_account_id.dkr.ecr.region.amazonaws.com.


docker tag dkagitha-dev:latest 649577765057.dkr.ecr.us-east-1.amazonaws.com/dkagitha-dev:latest



aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 649577765057.dkr.ecr.ap-south-1.amazonaws.com
docker build -t sc-app .
docker tag sc-app:latest 649577765057.dkr.ecr.ap-south-1.amazonaws.com/sc-app:latest
docker push 649577765057.dkr.ecr.ap-south-1.amazonaws.com/sc-app:latest



  "containerDefinitions": [
    {
      "name": "web-server-1",
      "image": "my-repo/ubuntu-apache",
      "cpu": 100,
      "memory": 100,
      "portMappings": [
        {
          "containerPort": 80,
          "hostPort": 80
        }
      ],
      "essential": true,
      "mountPoints": [
        {
          "sourceVolume": "webroot",
          "containerPath": "/var/www/html",
          "readOnly": true
        }
      ]
    },
    {
      "name": "web-server-2",
      "image": "my-repo/sles11-apache",
      "cpu": 100,
      "memory": 100,
      "portMappings": [
        {
          "containerPort": 8080,
          "hostPort": 8080
        }
      ],
      "essential": true,
      "mountPoints": [
        {
          "sourceVolume": "webroot",
          "containerPath": "/srv/www/htdocs",
          "readOnly": true
        }
      ]
    }
  ]