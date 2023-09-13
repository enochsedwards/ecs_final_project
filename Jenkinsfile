pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from GitHub repository
                checkout scmGit(branches: [[name: '*/master']], 
                extensions: [], userRemoteConfigs: [[url: 'https://github.com/enochsedwards/ecs_final_project.git']])
            }
        }

        stage('Deploy S3_DynamoDB') {
            steps {
                script {
                    dir('S3_DynamoDB') {
                        // Deploy DynamoDB using Terraform
                        sh 'terraform init'
                        echo "Terraform action is --> ${action}"
                        sh ("terraform ${action} -auto-approve")
                    }
                }
            }
        }

        stage('Deploy 01_DEV') {
            steps {
                script {
                    dir('01_DEV') {
                        // Deploy to the Dev environment using Terraform
                        sh 'terraform init'
                        echo "Terraform action is --> ${action}"
                        sh ("terraform ${action} -auto-approve -var-file=dev.tfvars")
                    }
                }
            }
        }
    }
}