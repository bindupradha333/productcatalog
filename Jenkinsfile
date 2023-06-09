pipeline {
  agent any
  stages {
    stage('Clone repository') {
      steps {
        git 'https://github.com/bindupradha333/productcatalog/'
      }
    }
    stage('Build Docker image') {
      steps {
        sh 'docker build -t product-catalogue .'
      }
    }
    stage('Deploy to Kubernetes') {
      steps {
        sh 'kubectl apply -f kubernetes/deployment.yaml'
        sh 'kubectl apply -f kubernetes/service.yaml'
        sh 'kubectl apply -f kubernetes/ingress.yaml'
      }
    }
  }
}
