docker build -t milan320/multi-client:latest -t milan320/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t milan320/multi-server:latest -t milan320/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t milan320/multi-worker:latest -t milan320/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push milan320/multi-client:latest
docker push milan320/multi-server:latest
docker push milan320/multi-worker:latest

docker push milan320/multi-client:$SHA
docker push milan320/multi-server:$SHA
docker push milan320/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=milan320/multi-server:$SHA
kubectl set image deployments/client-deployment client=milan320/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=milan320/multi-worker:$SHA