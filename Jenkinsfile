pipeline {
    agent any

    environment {
        AWS_CREDENTIALS = credentials('aws-credentials')  // Make sure this ID matches the one in Jenkins
        AWS_DEFAULT_REGION = 'ap-south-1'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/YOUR_GITHUB_USERNAME/YOUR_REPO.git'
            }
        }
        stage('Terraform Init') {
            steps {
                sh '''
                export $(echo $AWS_CREDENTIALS | xargs)
                terraform init
                '''
            }
        }
        stage('Terraform Plan') {
            steps {
                sh '''
                export $(echo $AWS_CREDENTIALS | xargs)
                terraform plan -out=tfplan
                '''
            }
        }
        stage('Terraform Apply') {
            steps {
                sh '''
                export $(echo $AWS_CREDENTIALS | xargs)
                terraform apply -auto-approve tfplan
                '''
            }
        }
    }
}
