pipeline {
    agent any

    environment {
        TF_VERSION = '1.5.0'
        TF_WORKING_DIR = '/var/lib/jenkins/workspace/Terraform-pipeline'
        ARM_CLIENT_ID = "9e14bb22-2061-4d5a-b34e-9846811a7538"
        ARM_CLIENT_SECRET = "e6v8Q~W5n3bdqodf2O1c9K3J7caj.qwFqyy.db4d"
        ARM_SUBSCRIPTION_ID = "56547eac-ec4c-45fb-a21d-e1b0362b3cbb"
        ARM_TENANT_ID = "efdcb83a-0641-4cd5-ba9a-f16252e85ec6"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git url: 'https://github.com/Vertuoso101/terraform.git', branch: 'main'
            }
        }
        
        stage('Terraform Init') {
            steps {
                dir(TF_WORKING_DIR) {
                     sh '''
                    terraform init \
                      -backend-config="client_secret=${ARM_CLIENT_SECRET}" \
                      -backend-config="subscription_id=${ARM_SUBSCRIPTION_ID}" \
                      -backend-config="tenant_id=${ARM_TENANT_ID}" \
                      -reconfigure
                    '''
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir(TF_WORKING_DIR) {
                    sh '''
                        export ARM_CLIENT_ID=${ARM_CLIENT_ID}
                        export ARM_CLIENT_SECRET=${ARM_CLIENT_SECRET}
                        export ARM_SUBSCRIPTION_ID=${ARM_SUBSCRIPTION_ID}
                        export ARM_TENANT_ID=${ARM_TENANT_ID}
                        
                        terraform plan --var-file=dev.tfvars -out=tfplan
                    '''
                }
            }
        }

        stage('Approval Before Apply') {
            steps {
                script {
                    def userInput = input(
                        id: 'UserInput', message: 'Do you approve to apply these Terraform changes?',
                        parameters: [
                            choice(name: 'Proceed', choices: ['Yes', 'No'], description: 'Choose Yes to apply changes or No to abort')
                        ]
                    )

                    // Check user response
                    if (userInput == 'No') {
                        error('User chose not to apply Terraform changes.')
                    }
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir(TF_WORKING_DIR) {
                    sh 'terraform apply tfplan'
                }
            }
        }

        stage('Post Actions') {
            steps {
                echo 'Terraform workflow complete!'
            }
        }
    }

}