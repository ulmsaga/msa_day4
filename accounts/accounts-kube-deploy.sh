source ./team-config

cat accounts-k8s-template.yaml | \
    sed "s/\${NAMESPACE}/${NAMESPACE}/g" | \
    sed "s/\${TEAM_PREFIX}/${TEAM_PREFIX}/g" | \
    sed "s/\${APP_NAME}/${APP_NAME}/g" | \
    sed "s/\${VERSION}/${VERSION}/g" | \
    sed "s/\${NODE_PORT}/${NODE_PORT}/g" | \
    kubectl apply -f -