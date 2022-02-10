docker build -t sgkasif/multi-client:latest -t sgkasif/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sgkasif/multi-server:latest -t sgkasif/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sgkasif/multi-worker:latest -t sgkasif/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sgkasif/multi-client:latest
docker push sgkasif/multi-server:latest
docker push sgkasif/multi-worker:latest

docker push sgkasif/multi-client:$SHA
docker push sgkasif/multi-server:$SHA
docker push sgkasif/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sgkasif/multi-server:$SHA
kubectl set image deployments/client-deployment server=sgkasif/multi-client:SHA
kubectl set image deployments/worker-deployment server=sgkasif/multi-worker:$SHA

