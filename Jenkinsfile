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

	}
}
