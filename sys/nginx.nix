{ lib, ... }:
{
	services.nginx = {
		enable = true;
		virtualHosts."joke.enterprises" = {
			root = "/web";
			forceSSL = true;
			sslCertificate = "/webdev/domain.cert.pem";
			sslCertificateKey = "/webdev/private.key.pem";
			#extraConfig = ''
			#ssl_certificate /webdev/domain.cert.pem;
			#ssl_certificate_key /webdev/private.key.pem;
			#'';
		};
	};
}

