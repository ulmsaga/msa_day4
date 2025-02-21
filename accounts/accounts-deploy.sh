prefix="group1-team3"
app="accounts"
ver="0.0.1"

echo "docker build -t k8s-vga-worker1:5000/${prefix}-${app}:v${ver}"
docker build --platform=linux/amd64 -t k8s-vga-worker1:5000/${prefix}-${app}:v${ver} ./

echo "docker push k8s-vga-worker1:5000/${prefix}-${app}:v${ver}"
docker push k8s-vga-worker1:5000/${prefix}-${app}:v${ver}

echo "kubectl apply -f accounts-k8s.yaml"
kubectl apply -f accounts-k8s.yaml
