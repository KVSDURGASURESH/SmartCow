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