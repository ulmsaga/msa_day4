source ./team-config

echo "mvn clean"
mvn clean

echo "mvn install"
mvn install

echo "docker build -t k8s-vga-worker1:5000/${TEAM_PREFIX}-${APP_NAME}:v${VERSION}"
docker build --platform=linux/amd64 -t k8s-vga-worker1:5000/${TEAM_PREFIX}-${APP_NAME}:v${VERSION} ./

echo "docker push k8s-vga-worker1:5000/${TEAM_PREFIX}-${APP_NAME}:v${VERSION}"
docker push k8s-vga-worker1:5000/${TEAM_PREFIX}-${APP_NAME}:v${VERSION}

# Backup existing k8s yaml file if it exists
if [ -f accounts-k8s.yaml ]; then
    timestamp=$(date +%Y%m%d_%H%M%S)
    cp accounts-k8s.yaml "accounts-k8s.yaml.backup_${timestamp}"
fi

# Generate new k8s yaml file from template
echo "Generating new accounts-k8s.yaml from template..."
cat accounts-k8s-template.yaml | \
    sed "s/\${NAMESPACE}/${NAMESPACE}/g" | \
    sed "s/\${TEAM_PREFIX}/${TEAM_PREFIX}/g" | \
    sed "s/\${APP_NAME}/${APP_NAME}/g" | \
    sed "s/\${VERSION}/${VERSION}/g" | \
    sed "s/\${NODE_PORT}/${NODE_PORT}/g" > accounts-k8s.yaml

# Apply the generated yaml file
echo "Applying generated accounts-k8s.yaml..."
kubectl apply -f accounts-k8s.yaml
