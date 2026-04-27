{ lib, ... }:
{
  services.mongodb = {
    enable = true;
    enableAuth = true;

    initialRootPasswordFile = /run/secure/mongodb-password
  };
}
