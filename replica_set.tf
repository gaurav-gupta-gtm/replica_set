provider "kubernetes" {
  config_context_cluster = "minikube"
}

resource "kubernetes_deployment" "deploy" {
  metadata {
    name = "mysite"
    labels = {
      test = "Wordpress"
    }
  }


  spec {
    replicas = 3

    selector {
      match_labels = {
        test = "Wordpress"
      }
      match_expressions {
              key      = "dc"
              operator = "In"
              values   = [ "IN" ]
         }
    }

    template {
      metadata {
        labels = {
          test = "Wordpress",
          dc = "IN"
        }
      }

      spec {
        container {
          image = "wordpress:4.8-apache"
          name  = "cont"
         }
      }
    }
  }
}
