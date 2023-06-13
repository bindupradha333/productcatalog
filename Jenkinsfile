pipeline {
    agent any
    stages {
        stage('Build and Push Docker Image') {
            steps {
                
                script {
                    docker.withRegistry('https://http://hub.docker.com') {
                        def app = docker.build("taniaduggal60/productcatalogue1")
                        app.push("latest")
                    }
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    def kubeconfig = readFile("${env.HOME}/.kube/config")
                    writeFile file: "${env.WORKSPACE}/kubeconfig", text: kubeconfig
                    withKubeConfig([credentialsId: 'kubeconfig-credentials', kubeconfigFile: "${env.WORKSPACE}/kubeconfig", serverUrl: 'https://my-kubernetes-cluster']) {

                        sh 'kubectl apply -f deployment.yaml'
                        sh 'kubectl apply -f service.yaml'

                        timeout(time: 5, unit: 'MINUTES') {
                            sh 'kubectl rollout status deployment/my-deployment'
                        }

                        sh 'kubectl get services'
                    }
                }
            }
        }
    }
}
