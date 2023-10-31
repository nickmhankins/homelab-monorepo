{
	acme_dns google_domains  {{ passfile.content | b64decode | trim  }}
}

erx.mandatorygoat.com {
	encode zstd gzip

	reverse_proxy https://10.0.10.1 {
		transport http {
			tls_insecure_skip_verify
		}
	}
}

pihole1.mandatorygoat.com {
	encode zstd gzip

	redir / /admin{uri}
	reverse_proxy 10.0.10.3:81
}

pihole2.mandatorygoat.com {
	encode zstd gzip

	redir / /admin{uri}
	reverse_proxy 10.0.10.4:81
}

proxmox.mandatorygoat.com {
	encode zstd gzip

	reverse_proxy https://10.0.10.10:8006 {
		transport http {
			tls_insecure_skip_verify
		}
	}
}

unifi.mandatorygoat.com {
	encode zstd gzip

	reverse_proxy https://10.0.10.3:8443 {
		transport http {
			tls_insecure_skip_verify
		}
	}
}
