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
        "student-project"
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
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hello World - Nomad Deployment</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            color: white;
        }
        .container {
            text-align: center;
            background: rgba(255, 255, 255, 0.1);
            padding: 2rem;
            border-radius: 15px;
            backdrop-filter: blur(10px);
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
            border: 1px solid rgba(255, 255, 255, 0.18);
        }
        h1 {
            font-size: 3rem;
            margin-bottom: 1rem;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }
        .info {
            font-size: 1.2rem;
            margin: 1rem 0;
        }
        .status {
            background: rgba(0, 255, 0, 0.2);
            padding: 1rem;
            border-radius: 8px;
            margin: 1rem 0;
        }
        .tech-stack {
            display: flex;
            justify-content: center;
            gap: 1rem;
            margin-top: 2rem;
        }
        .tech {
            background: rgba(255, 255, 255, 0.2);
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🚀 Hello World!</h1>
        <div class="info">
            <p><strong>MLOps Engineer Test Task</strong></p>
            <p>Nomad Cluster Deployment</p>
        </div>
        <div class="status">
            <p>✅ Application Successfully Deployed on Nomad</p>
            <p>🐳 Running in Docker Container</p>
            <p>🔧 Managed by HashiCorp Nomad</p>
        </div>
        <div class="info">
            <p><strong>Server:</strong> {{ env "NOMAD_ALLOC_NAME" }}</p>
            <p><strong>Node:</strong> {{ env "attr.unique.hostname" }}</p>
            <p><strong>Deployment Time:</strong> <span id="current-time"></span></p>
        </div>
        <div class="tech-stack">
            <div class="tech">Terraform</div>
            <div class="tech">AWS</div>
            <div class="tech">Nomad</div>
            <div class="tech">Docker</div>
            <div class="tech">Consul</div>
        </div>
    </div>
    
    <script>
        document.getElementById('current-time').textContent = new Date().toLocaleString();
    </script>
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