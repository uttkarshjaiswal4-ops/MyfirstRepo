pipeline {
    agent any
    
    environment {
        SF_AUTH_URL = credentials('salesforce-target-org-auth')
    }
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', 
                    url: 'https://github.com/uttkarshjaiswal4-ops/MyfirstRepo.git'
            }
        }
        
        stage('Authenticate Salesforce') {
            steps {
                bat '''
                    echo %SF_AUTH_URL% > authFile.txt
                    sf org login sfdx-url --sfdx-url-file authFile.txt --alias targetOrg
                    del authFile.txt
                '''
            }
        }
        
        stage('Deploy to Salesforce') {
            steps {
                bat 'sf project deploy start --target-org targetOrg --source-dir force-app --test-level RunLocalTests'
            }
        }
        
        stage('Run Tests') {
            steps {
                bat 'sf apex run test --target-org targetOrg --test-level RunLocalTests --wait 10'
            }
        }
    }
    
    post {
        always {
            bat 'if exist authFile.txt del authFile.txt'
        }
        success {
            echo 'Deployment successful!'
        }
        failure {
            echo 'Deployment failed. Check logs for details.'
        }
    }
}