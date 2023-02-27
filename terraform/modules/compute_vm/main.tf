resource "google_compute_instance" "compute_vm" {
  name         = "${var.prefix_name}-${var.name}"
  machine_type = var.machine_type
  zone         = var.region_zone

  tags = ["${var.environment}", "${var.region}", "${var.tag}"]

  metadata = {
    ssh-keys = "root:${var.root_sshkey}"
  }
  metadata_startup_script = <<EOT
#!/bin/bash -ex
sed -i 's/PermitRootLogin no/PermitRootLogin prohibit-password/g' /etc/ssh/sshd_config
service sshd restart || service ssh restart
  EOT

  boot_disk {
    source = google_compute_disk.boot_disk.id
    device_name = "boot"
  }
  attached_disk {
    source = google_compute_disk.data_disk.id
    device_name = "data"
  }

  network_interface {
    subnetwork = var.subnet_id

    dynamic "access_config" {
      for_each = var.public_access ? [""] : []
      content {} // Ephemeral public IP
    }
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = var.svc_account_email
    scopes = var.svc_account_scopes
  }
}

resource "google_compute_disk" "boot_disk" {
  name  = "${var.prefix_name}-${var.name}-boot"
  type  = var.boot_disk_type
  zone  = var.region_zone
  image = var.boot_disk_image
  size  = var.boot_disk_size
  labels = {
    environment = var.environment
    region = var.region
    module = "${var.name}-boot"
  }
}

resource "google_compute_disk" "data_disk" {
  name  = "${var.prefix_name}-${var.name}-data"
  type  = var.data_disk_type
  zone  = var.region_zone
  size  = var.data_disk_size
  labels = {
    environment = var.environment
    region = var.region
    module = "${var.name}-data"
  }
}