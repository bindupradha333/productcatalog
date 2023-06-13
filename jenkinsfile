pipeline {
    agent any

    stages {
        stage("Build") {
            steps {
                sh "mvn clean package"
            }
        }

        stage("Docker build") {
            steps {
                sh "docker build -t taniaduggal60/productcatalogue1:latest ."
            }
        }

        stage("Docker push") {
            steps {
                sh "docker push productcatalogue1:latest"
            }
        }

        stage("Deploy to Kubernetes") {
            steps {
                sh """
                kubectl set image deployment.yaml \
                5a4a6af524e100f1422992a904bd079305515308203179ac2fbf5120ef1b630a=taniaduggal60/productcatalogue1:latest \
                --record=true
                """
            }
        }
    }
}
