job "feziv" {
	datacenters = ["dc1"]
	type = "service"

	group "default" {

		network { 
			port "feziv" {
				host_network = "private"
			} 
		}

		task "feziv" {
			service {
				port = "feziv"
				tags = [
					"reproxy.enabled=1",
					"reproxy.server=feziv.com,www.feziv.com",
					"timestamp=[[timeNow]]"
				]
			}
			// serve static files for feziv.com

			resources {
        memory = 64
      }

			driver = "docker"

//			artifact {
//				source = "git::https://github.com/fess932/portfolio?ref=main"
//				destination = "local/static"
//			}

			env {
//				ASSETS_LOCATION = "/local/static/public"
				LISTEN = "${NOMAD_ADDR_feziv}"
				timestamp = "[[timeNow]]"
			}

			config {
				image = "ghcr.io/umputun/reproxy"
				network_mode = "host"
			}
		}
	}
}


