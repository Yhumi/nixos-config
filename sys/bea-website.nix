{ lib, ... }:
{
	services.static-web-server = {
		enable = true;
		listen = "[::]:80";
		root = "/web";
		configuration.general.directory-listing = true;
	};
}

