prefix="group1-team3"
app="cards"
ver="0.0.1"

echo "mvn clean"
mvn clean

echo "mvn install"
mvn install

echo "docker build -t k8s-vga-worker1:5000/${prefix}-${app}:v${ver}"
docker build --platform=linux/amd64 -t k8s-vga-worker1:5000/${prefix}-${app}:v${ver} ./

echo "docker push k8s-vga-worker1:5000/${prefix}-${app}:v${ver}"
docker push k8s-vga-worker1:5000/${prefix}-${app}:v${ver}

echo "kubectl apply -f cards-k8s.yaml"
kubectl apply -f cards-k8s.yaml
