resource "volterra_aws_vpc_site" "example" {
    name       = format("%s-appstackvpc-%s", var.projectPrefix, var.instanceSuffix)
    namespace  = "system"
    aws_region = var.awsRegion
    depends_on = [volterra_k8s_cluster.example]

    vpc {
        vpc_id     = var.vpcId
    }
    
    // One of the arguments from this list "default_blocked_services blocked_services" must be set
    default_blocked_services = true

    // One of the arguments from this list "aws_cred" must be set

    aws_cred {
        name      = var.volterraCloudCredAWS
        namespace = "system"
    }
    // One of the arguments from this list "direct_connect_disabled direct_connect_enabled" must be set
    direct_connect_disabled = true
    // Minimum resource requirements can be found https://docs.cloud.f5.com/docs/how-to/site-management/create-aws-site
    instance_type           = "t3.xlarge"  

    // One of the arguments from this list "logs_streaming_disabled log_receiver" must be set
    logs_streaming_disabled = true

    // One of the arguments from this list "ingress_gw ingress_egress_gw voltstack_cluster" must be set

    voltstack_cluster {
        allowed_vip_port {
            // One of the arguments from this list "use_http_port use_https_port use_http_https_port custom_ports" must be set
            use_http_port = true
        }

        aws_certified_hw    = "aws-byol-voltstack-combo"

        az_nodes {
            aws_az_name = var.awsAz1
            local_subnet {
                existing_subnet_id = var.internalSubnets["az1"].id
            }
        }

        az_nodes {
            aws_az_name = var.awsAz2
            local_subnet {
                existing_subnet_id = var.internalSubnets["az2"].id
            } 
        }

        az_nodes {
            aws_az_name = var.awsAz3
            local_subnet {
                existing_subnet_id = var.internalSubnets["az3"].id
            }
        }

    no_network_policy        = true
    no_forward_proxy         = true
    no_outside_static_routes = true
    // no_k8s_cluster           = true
    no_global_network        = true
    #default_storage         = ""
    k8s_cluster {
      namespace = "system"
      name      = "pki-k8s"
    }

    }

    // One of the arguments from this list "nodes_per_az total_nodes no_worker_nodes" must be set
    #nodes_per_az = "1"
    #total_nodes = 6
    no_worker_nodes = true
    lifecycle {
        ignore_changes = [
            labels,
        ]
    }
}

resource "volterra_k8s_cluster" "example" {
  name      = "pki-k8s"
  namespace = "system"

  // One of the arguments from this list "no_cluster_wide_apps cluster_wide_app_list" must be set
  no_cluster_wide_apps = true

  // One of the arguments from this list "use_custom_cluster_role_bindings use_default_cluster_role_bindings" must be set
  use_default_cluster_role_bindings = true

  // One of the arguments from this list "use_default_cluster_roles use_custom_cluster_role_list" must be set
  use_default_cluster_roles = true

  // One of the arguments from this list "cluster_scoped_access_deny cluster_scoped_access_permit" must be set
  cluster_scoped_access_deny = true

  // One of the arguments from this list "no_global_access global_access_enable" must be set
  no_global_access = true

  // One of the arguments from this list "no_insecure_registries insecure_registry_list" must be set

  insecure_registry_list {
    insecure_registries = ["example.com:5000"]
  }
  // One of the arguments from this list "no_local_access local_access_config" must be set
  no_local_access = true
  // One of the arguments from this list "use_default_psp use_custom_psp_list" must be set
  use_default_psp = true
}

resource "volterra_cloud_site_labels" "labels" {
  name             = volterra_aws_vpc_site.example.name
  site_type        = "aws_vpc_site"
  # need at least one label, otherwise site_type is ignored
  labels           = { 
        "site-group" = var.projectPrefix 
        "appstack-site-group" = var.projectPrefix
  }
  #ignore_on_delete = var.f5xc_cloud_site_labels_ignore_on_delete
}

resource "volterra_tf_params_action" "aws_vpc_action" {
  site_name        = volterra_aws_vpc_site.example.name
  site_kind        = "aws_vpc_site"
  action           = "apply"
  wait_for_action  = true
  ignore_on_update = false
  depends_on = [volterra_k8s_cluster.example]
}
