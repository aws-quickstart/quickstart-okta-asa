
---
global:
  marketplace-ami: false
  owner: quickstart-eng@amazon.com
  qsname: quickstart-okta-asa
  regions:
    - ap-northeast-1
    - ap-northeast-2
    - ap-southeast-1
    - ap-southeast-2
    - eu-central-1
    - eu-west-1
    - sa-east-1
    - us-east-1
    - us-west-1
    - us-west-2
  reporting: true

tests:
  quickstart-okta-asat1:
    parameter_input: quickstart-okta-asa-example-params1.json
    template_file: quickstart-okta-asa-example1.template
  quickstart-okta-asat2:
    parameter_input: quickstart-okta-asa-example-params2.json
    template_file: quickstart-okta-asa-example2.template