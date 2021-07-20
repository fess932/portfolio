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

			env {
				//ASSETS_LOCATION = "/public"
				LISTEN = "${NOMAD_ADDR_feziv}"
			}

			config {
				image = "ghcr.io/fess932/portfolio:[[.tag]]"
				network_mode = "host"
			}
		}
	}
}


