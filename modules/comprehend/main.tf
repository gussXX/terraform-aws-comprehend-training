# DOC OFICIAL https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/comprehend_entity_recognizer

### Ferramenta de IA da AWS para reconhecimento de entidades em textos. Utilizada para 
### simplificar o processos de extração de informações de um documento, sendo capapz de identificar o sentimento 
### daquele documento, o que facilita a análise de dados e a tomada de decisões.

resource "aws_comprehend_entity_recognizer" "aws_comprehend_module" {

    # Você deve definir um nome para o seu reconhecedor de entidades.
    name = "example"

    # Role para o IAM que o Amazon Comprehend usará para acessar os dados de entrada.
    # O IAM deve ter permissão para acessar o bucket do S3 e o arquivo de entrada.
    data_access_role_arn = aws_iam_role.example.arn

    # O idioma do reconhecedor de entidades. Sendo em duas letras, como por exemplo "en" para inglês ou "pt" para português
    # Fundamental para o reconhecimento correto das entidades.
    language_code = "en"

    # Aqui voce define o tipo de reconhecimento de entidades que deseja fazer.
    input_data_config {

        annotations {
            # Define o local das anotações que vão ser usadas para treinar o reconhecedor de entidades.
            s3_uri = "s3://${aws_s3_bucket.annotations.bucket}/${aws_s3_object.annotations.id}"
            # Define o local das anotações de teste que vão ser usadas para validar o reconhecedor de entidades.
            test_s3_uri = "s3://${aws_s3_bucket.annotations.bucket}/${aws_s3_object.test_annotations.id}"
        }

        # Define o formato dos dados de entrada. O Amazon Comprehend suporta CSV e JSON. Sendo o CSV o mais utilizado e Padrão.
        data_format =  "COMPREHEND_CSV"

        # Unico recurso obrigatório para o treinamento do reconhecedor de entidades.
        # Aqui voce define o conjunto de entidades que deseja reconhecer.
        # O Amazon Comprehend suporta até 25 tipos de entidades diferentes.
        # Confira o exemplo de como definir os tipos de entidades.
        # entity_types = [
        #     {
        #         type = "PESSOA"
        #     },
        #     {
        #         type = "EMPRESA"
        #     },
        #     {
        #         type = "LOCAL"
        #     }
        # ]
        entity_types {
            type = "ENTITY_1"
        }
        entity_types {
            type = "ENTITY_2"
        }

        # Sobe o arquivo com os documentos de texto de treino
        documents {
            s3_uri = "s3://${aws_s3_bucket.documents.bucket}/${aws_s3_object.documents.id}"
        }

        # Define o local dos dados da lista de entidades que vão ser usadas para treinar o reconhecedor de entidades.
        entity_list {
            s3_uri = "s3://${aws_s3_bucket.entities.bucket}/${aws_s3_object.entities.id}"
        }
    }
    # Polices para o treinamento do reconhecedor de entidades.
    depends_on = [
        aws_iam_role_policy.example
    ]
}

# Sobe o arquivo com os documentos de texto de treino
resource "aws_s3_object" "documents" {
    bucket = aws_s3_bucket.documents.bucket
    key    = "documents.json"
    source = "${path.module}/files/documents.json"
}

# Define o local dos dados da lista de entidades que vão ser usadas para treinar o reconhecedor de entidades.
resource "aws_s3_object" "entities" {
    bucket = aws_s3_bucket.entities.bucket
    key    = "entities.json"
    source = "${path.module}/files/entities.json"
}