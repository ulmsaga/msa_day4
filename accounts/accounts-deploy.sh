source ./team-config

echo "mvn clean"
mvn clean

echo "mvn install"
mvn install

echo "docker build -t k8s-vga-worker1:5000/${TEAM_PREFIX}-${APP_NAME}:v${VERSION}"
docker build --platform=linux/amd64 -t k8s-vga-worker1:5000/${TEAM_PREFIX}-${APP_NAME}:v${VERSION} ./

echo "docker push k8s-vga-worker1:5000/${TEAM_PREFIX}-${APP_NAME}:v${VERSION}"
docker push k8s-vga-worker1:5000/${TEAM_PREFIX}-${APP_NAME}:v${VERSION}

# Replace variables in k8s yaml template and apply
cat accounts-k8s-template.yaml | \
    sed "s/\${NAMESPACE}/${NAMESPACE}/g" | \
    sed "s/\${TEAM_PREFIX}/${TEAM_PREFIX}/g" | \
    sed "s/\${APP_NAME}/${APP_NAME}/g" | \
    sed "s/\${VERSION}/${VERSION}/g" | \
    sed "s/\${NODE_PORT}/${NODE_PORT}/g" | \
    kubectl apply -f -
