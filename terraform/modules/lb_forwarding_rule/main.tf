resource "google_compute_global_address" "global_address" {
  name = "${var.prefix_name}-${var.name}"
  # purpose     = "GLOBAL"
  description = "${var.prefix_name}-${var.name}-Global-Address"
}

resource "google_compute_region_backend_service" "default" {
  region                = var.region
  name                  = "${var.prefix_name}-${var.name}-region-service"
  health_checks         = [google_compute_region_health_check.http-region-health-check.id]
  load_balancing_scheme = "EXTERNAL_MANAGED"
  locality_lb_policy    = "RING_HASH"
  session_affinity      = "HTTP_COOKIE"
  protocol              = "HTTP"
  circuit_breakers {
    max_connections = 10
  }
  consistent_hash {
    http_cookie {
      ttl {
        seconds = 11
        nanos   = 1111
      }
      name = "mycookie"
    }
  }
  outlier_detection {
    consecutive_errors = 2
  }
}

resource "google_compute_region_health_check" "http-region-health-check" {
  name = "${var.prefix_name}-${var.name}-region-health-check"

  timeout_sec        = 1
  check_interval_sec = 1

  http_health_check {
    port = "80"
  }
}