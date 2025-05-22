<h1 align="center">Provisionamento do Amazon Comprehend para IA 👾</h1>

### Objetivos

Este projeto provisiona a infraestrutura necessária para treinar um classificador de documentos personalizado no Amazon Comprehend utilizando o Terraform.
Ele cria:

- um bucket S3 para armazenar os arquivos de treino/teste,
- uma role IAM com permissões para o Comprehend acessar os dados,
- e o recurso aws_comprehend_document_classifier, responsável por iniciar o processo de treinamento.
<br>

<!--

    ### REFERENCIAS PARA O PROJETO

 https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/comprehend_entity_recognizer
 
  -->