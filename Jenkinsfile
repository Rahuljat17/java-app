pipeline {
	agent any
	stages {
		stage ("pull code from git repo"){
			steps{
				git branch: 'main', url: 'https://github.com/Rahuljat17/java-app.git'
			}
		}
		stage ("Build the code"){
			steps{
				sh 'sudo mvn dependency:purge-local-repository'
				sh 'sudo mvn clean package'
			}
		}
		stage ("Building docker image"){
			steps{
				sh 'sudo docker build -t java-app:$BUILD_TAG .'
				sh 'sudo docker tag java-app:$BUILD_TAG rahul9664/java-app:$BUILD_TAG '
			}
		}
		stage ("Push on Docker-Hub"){
			steps{
				withCredentials([string(credentialsId: 'docker-hub-passwd', variable: 'docker-hub-id')]) {
    					sh 'sudo docker login -u rahul9664 -p ${docker-hub-id}'
					sh 'sudo docker push rahul9664/java-app:$BUILD_TAG'
				}
			}
		}
		stage ("Testing the Build"){
			steps{
				sh 'sudo docker run -dit --name java-test$BUILD_TAG -p 8090:8080 rahul9664/java-app:$BUILD_TAG'
			}
		}
		stage ("QAT Testing"){
			steps{
				retry(7){
					script{
						sh 'sudo curl --silent http://13.201.132.89:8090/java-web-app/ | grep -i -E "(india|sr)"'
					}
				}
			}
		}
		stage ("Approval from QAT"){
			steps {
				script {
					Boolean userInput = input(id: 'Proceed1', message: 'Do you want to Promote this build?', parameters: [[$class: 'BooleanParameterDefinition', defaultValue: true, description: '', name: 'Please confirm you agree with this']])
                				echo 'userInput: ' + userInput
				}
			}
		}
		stage ("Prod ENV"){
			steps{
				sshagent(credentials:['node-1']) {
			    	 	sh 'ssh -o StrictHostKeyChecking=no ubuntu@65.2.31.89 sudo docker run  -dit  -p  :8080  rahul9664/java-app:$BUILD_TAG'
				}
			}
		}
	}
}
