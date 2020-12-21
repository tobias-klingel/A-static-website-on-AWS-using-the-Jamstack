
provider "aws"{
    region = "us-east-1"
    allowed_account_ids= ["XXXXXXXXXXX"] #<-------------------------------------- Edit
    profile    = "myaws" #<-------------------------------------- Depending on your settings can be deleted or must be edited
}


module "hugosite" {
  source              = "github.com/fillup/terraform-hugo-s3-cloudfront"
  aliases             = ["www.XXXXXXXXXXXX.com"] #<------------------------------------------------------ Edit
  bucket_name         = "my-unique-bucket-name" #<------------------------------------------------------ Edit
  cert_domain         = "www.XXXXXXXXXXXX.com" #<-------------------------------------------------------- Edit
  deployment_user_arn = "arn:aws:iam::XXXXXXXXXXX:XXXXX" #<----------------------------------------------- Edit
  origin_path         = ""
  cf_price_class      = "PriceClass_All"
  default_root_object = "index.html"
  error_document      = "404.html"
  custom_error_response = [
      {
        error_code         = 404
        response_code      = 200
        response_page_path = "/404.html"
      },
    ]
}