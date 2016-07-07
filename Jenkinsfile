node('docker') {
  stage 'Checkout'
  checkout scm

   stage 'Build'
   docker.build('jenkins')
}
