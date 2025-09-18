job "hello-world" {
  # Region and datacenter configuration
  region      = "global"
  datacenters = ["dev"]
  type        = "service"

  # Job metadata
  meta {
    version = "1.0"
    owner   = "student"
  }

  # Group configuration
  group "web" {
    # Number of instances
    count = 2

    # Networking configuration
    network {
      port "http" {
        static = 8080
      }
    }

    # Service registration with Consul
    service {
      name = "hello-world"
      port = "http"
      
      tags = [
        "web",
        "hello-world",
        "demo"
      ]

      check {
        type     = "http"
        path     = "/"
        interval = "10s"
        timeout  = "3s"
      }
    }

    # Restart policy
    restart {
      attempts = 3
      interval = "30m"
      delay    = "15s"
      mode     = "fail"
    }

    # Task configuration
    task "web-server" {
      driver = "docker"

      # Docker configuration
      config {
        image = "nginx:alpine"
        ports = ["http"]
        
        # Mount custom index.html
        mount {
          type   = "bind"
          source = "local/index.html"
          target = "/usr/share/nginx/html/index.html"
        }
      }

      # Custom HTML content
      template {
        data = <<EOF
<!doctype html>
<html>
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1" />
    <title>Hello - Nomad demo</title>
    <style>
      body { font-family: Arial, sans-serif; padding: 1rem; }
      .card { max-width: 700px; margin: 2rem auto; border: 1px solid #ddd; padding: 1rem; }
      h1 { margin-top: 0 }
      .meta { color: #555 }
    </style>
  </head>
  <body>
    <div class="card">
      <h1>Hello — Nomad demo</h1>
      <p class="meta">Small demo job to verify Nomad scheduling and Consul registration.</p>
      <dl>
        <dt>Alloc</dt>
        <dd>{{ env "NOMAD_ALLOC_NAME" }}</dd>
        <dt>Node</dt>
        <dd>{{ env "attr.unique.hostname" }}</dd>
        <dt>Deployed</dt>
        <dd><span id="time"></span></dd>
      </dl>
      <p>Author: Koushal Sharma (student demo)</p>
    </div>
    <script>document.getElementById('time').textContent = new Date().toLocaleString();</script>
  </body>
</html>
EOF
        destination = "local/index.html"
      }

      # Resource allocation
      resources {
        cpu    = 100
        memory = 128
      }

      # Logs configuration
      logs {
        max_files     = 10
        max_file_size = 10
      }
    }
  }
}