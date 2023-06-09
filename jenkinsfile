// codectl version : 1.4.7


pipeline {
    /* In this step, you can define where your job can run.
    
     * In more advanced usages, you can have the entire build be run inside of a Docker containers
     * in order to use custom tools not natively supported by Jenkins.
    
     */
    agent any
    
    /* The tools this pipeline needs are defined here. The available versions are the same as those
     * available in maven or freestyle job.
     */
    
	
    
       
    
    


     stages {
    stage('Clone repository') {
      steps {
        git 'https://github.com/bindupradha333/productcatalog/'
      }
    }
		
		/* In this stage, the code is being built/compiled, and the Docker image is being created and tagged.
         * Tests shouldn't been run in this stage, in order to speed up time to deployment.
         */
		
        stage ('MVN Build') {
          	steps {
				
				
				
				// Run the docker build command and tag the image with the git commit ID
				sh 'docker build -t product-catalogue .'
				
            }

        }

        
        /* In this stage, built images are being pushed
        */
		
        stage ('Push') {
            steps {
                
                
				// Authenticates with your remote Docker Repository, and pushes the value of "$DOCKER_PUSH_TAG",
				// which will exist if you used 'tagDocker' to tag your image, or set it manually. If you have done neither,
				// you can instead define your image using the 'image' parameter.
				// You can change the credentials used by using the 'authId' parameter.
				// The difference between this, and 'docker push $image', is that this handles 'docker login' for you.
				dockerPush()

				// Send Webex notification about docker push event status to the Webex room defined ID in the software details, using the
				// 'CoDE:ContainerHub' bot
				notifyDocker()
                
            }
        }     


        /* In this stage, we're running several different sub-stages in parallel. This speeds up job time by running many different
         * steps (that don't necessarily need to be run in sequence) at the same time, speeding up your job runtime.
         */
      		stage ('Deployment') {
            // Run these stages in parallel
            parallel {

                /* This stage simply runs your Static Security Scan. Uncomment it and include your stack name to use it.
                 */
                

                /* This steps runs your unit tests, and your SonarQube scan.
                 * This stage may vary heavily depending on your project language and structure.
                 */
                 stage ('Test/Sonar') {
					steps {
					    
						echo 'Starting SonarQube scan...'

						// Run your unit tests and prepare SonarQube output
						 
						sonarScan(sonarServer: 'Sonar', properties:'''
                            				mvn clean verify sonarsonar 
                                           -Dsonar.projectKey=product-catalogue 
                                           -Dsonar.projectName='product-catalogue' 
                                           -Dsonar.host.url=httplocalhost9000 
                                           -Dsonar.token=squ_6e793deb037a905a6a6f0d842162d6fea059f4a3
                                            sonar.jacoco.reportPaths=target/jacoco.exec
                                            sonar.core.codeCoveragePlugin=jacoco
											sonar.coverage.jacoco.xmlReportPaths=./target/site/jacoco-ut/jacoco.xml
											

                        			''')

						// This step will pause the pipeline and wait for the Sonar analysis to complete and return quality gate status.
						// The pipeline will fail if the quality gate stauts is not green
						timeout(time: 1, unit: 'HOURS') {
							script {
								def qg = waitForQualityGate() // Reuse taskId previously collected by withSonarQubeEnv
								if (qg.status != 'OK') {
									echo "Quality gate failed"
									error "Pipeline aborted due to quality gate failure: ${qg.status}"
								}
							}
						}
                    }
					// Make test results visible in Jenkins UI if the install step completed successfully
					
                


                /*stage ('Deploy') {
                    when { branch "master/*" }
                    
                }*/
				}             

                
            }
        }
    }
    post {
        always {
            notifyBuildEnd()
        }
    }
}
