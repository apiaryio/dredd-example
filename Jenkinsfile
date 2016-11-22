// use node 6
node {
   stage('Get source code') {
      git url: 'https://github.com/apiaryio/dredd-example.git', branch: 'master'      
   }
   stage('Install Deps') {
      if(isUnix()) {
         sh 'node -v'
         sh 'npm -v'
         sh 'npm install'
         sh 'npm -g install dredd@stable'
      } else {
         bat 'node -v'
         bat 'npm -v'
         bat 'npm install'
         bat 'npm -g install dredd@stable'
      }
   }
   stage('Test Swagger') {
      if(isUnix()) {
         wrap([$class: 'AnsiColorBuildWrapper', 'colorMapName': 'XTerm']) {
          sh 'dredd --config ./swagger/dredd.yml --reporter junit --output swagger.xml'
         }
      } else {
         bat 'dredd --config ./swagger/dredd.yml --reporter junit --output swagger.xml'
      }
   }   
   stage('Test API Blueprint') {
      if(isUnix()) {
         wrap([$class: 'AnsiColorBuildWrapper', 'colorMapName': 'XTerm']) {
          sh 'dredd --config ./api-blueprint/dredd.yml --reporter junit --output blueprint.xml'
         }
      } else {
         bat 'dredd --config ./api-blueprint/dredd.yml --reporter junit --output blueprint.xml'
      }
   }
   stage('Get JUnit Results') {
      junit 'blueprint.xml'
      junit 'swagger.xml'
   }
}
