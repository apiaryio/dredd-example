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
   stage('Test OpenAPI 2') {
      if(isUnix()) {
         wrap([$class: 'AnsiColorBuildWrapper', 'colorMapName': 'XTerm']) {
          sh 'dredd --config ./openapi2/dredd.yml --reporter junit --output openapi2.xml'
         }
      } else {
         bat 'dredd --config ./openapi2/dredd.yml --reporter junit --output openapi2.xml'
      }
   }
   stage('Test API Blueprint') {
      if(isUnix()) {
         wrap([$class: 'AnsiColorBuildWrapper', 'colorMapName': 'XTerm']) {
          sh 'dredd --config ./apiblueprint/dredd.yml --reporter junit --output blueprint.xml'
         }
      } else {
         bat 'dredd --config ./apiblueprint/dredd.yml --reporter junit --output blueprint.xml'
      }
   }
   stage('Get JUnit Results') {
      junit 'blueprint.xml'
      junit 'openapi2.xml'
   }
}
