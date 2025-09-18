job "monitoring-demo" {
  region      = "global"
  datacenters = ["dev"]
  type        = "service"

  meta {
    version = "1.0"
    purpose = "observability-demo"
  }

  group "monitoring" {
    count = 1

    network {
      port "grafana" {
        static = 3000
      }
      port "prometheus" {
        static = 9090
      }
    }

    # Grafana service for visualization
    task "grafana" {
      driver = "docker"

      config {
        image = "grafana/grafana:latest"
        ports = ["grafana"]
        
        mount {
          type   = "bind"
          source = "local/grafana"
          target = "/etc/grafana/provisioning"
        }
      }

      template {
        data = <<EOF
apiVersion: 1

datasources:
  - name: Prometheus
    type: prometheus
    access: proxy
    url: http://localhost:9090
    isDefault: true
EOF
        destination = "local/grafana/datasources/prometheus.yml"
      }

      env {
        GF_SECURITY_ADMIN_PASSWORD = "admin123"
        GF_USERS_ALLOW_SIGN_UP = "false"
      }

      service {
        name = "grafana"
        port = "grafana"
        
        tags = [
          "monitoring",
          "grafana",
          "visualization"
        ]

        check {
          type     = "http"
          path     = "/api/health"
          interval = "10s"
          timeout  = "3s"
        }
      }

      resources {
        cpu    = 200
        memory = 256
      }
    }

    # Prometheus for metrics collection
    task "prometheus" {
      driver = "docker"

      config {
        image = "prom/prometheus:latest"
        ports = ["prometheus"]
        
        args = [
          "--config.file=/etc/prometheus/prometheus.yml",
          "--storage.tsdb.path=/prometheus",
          "--web.console.libraries=/etc/prometheus/console_libraries",
          "--web.console.templates=/etc/prometheus/consoles",
          "--web.enable-lifecycle"
        ]

        mount {
          type   = "bind"
          source = "local/prometheus.yml"
          target = "/etc/prometheus/prometheus.yml"
        }
      }

      template {
        data = <<EOF
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']

  - job_name: 'nomad'
    consul_sd_configs:
      - server: 'localhost:8500'
        services: ['nomad', 'nomad-client']
    
  - job_name: 'consul'
    static_configs:
      - targets: ['localhost:8500']
    metrics_path: /v1/agent/metrics
    params:
      format: ['prometheus']
EOF
        destination = "local/prometheus.yml"
      }

      service {
        name = "prometheus"
        port = "prometheus"
        
        tags = [
          "monitoring",
          "prometheus",
          "metrics"
        ]

        check {
          type     = "http"
          path     = "/-/healthy"
          interval = "10s"
          timeout  = "3s"
        }
      }

      resources {
        cpu    = 200
        memory = 256
      }
    }

    restart {
      attempts = 3
      interval = "30m"
      delay    = "15s"
      mode     = "fail"
    }
  }
}