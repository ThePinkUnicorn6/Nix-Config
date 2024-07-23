{ config, settings, ... }:
let
  directories = [
    "${settings.serviceConfigRoot}/immich"
    "${settings.serviceConfigRoot}/immich/postgresql"
    "${settings.serviceConfigRoot}/immich/postgresql/data"
    "${settings.serviceConfigRoot}/immich/config"
    "${settings.serviceConfigRoot}/immich/machine-learning"
    "${settings.mediaRoot}/Photos"
    "${settings.mediaRoot}/Photos/Immich"
  ];
in
{
  users ={
    groups.immich = {
      gid = 993;
    };
    users.immich = {
      isSystemUser = true;
      uid = 994;
      group = "immich";
    };
  };
  systemd.tmpfiles.rules = map (x: "d ${x} 0775 immich immich - -") directories;
  systemd.services = {
    podman-immich = {
      requires = [
        "podman-immich-redis.service"
        "podman-immich-postgres.service"
      ];
      after = [
        "podman-immich-redis.service"
        "podman-immich-postgres.service"
      ];
    };
    podman-immich-postgres = {
      requires = [ "podman-immich-redis.service" ];
      after = [ "podman-immich-redis.service" ];
    };
  };

  virtualisation.oci-containers.containers = {
    immich = {
      autoStart = true;
      image = "ghcr.io/imagegenius/immich:latest";
      volumes = [
        "${settings.serviceConfigRoot}/immich/config:/config"
        "${settings.mediaRoot}/Photos/Immich:/photos"
        "${settings.mediaRoot}/Photos/S10m:/import:ro"
        "${settings.serviceConfigRoot}/immich/machine-learning:/config/machine-learning"
      ];
      #environmentFiles = [ config.age.secrets.ariaImmichDatabase.path ];
      environment = {
        PUID = "994";
        PGID = "993";
        TZ = "Europe/London";
        DB_HOSTNAME = "immich-postgres";
        DB_USERNAME = "immich";
        DB_DATABASE_NAME = "immich";
        REDIS_HOSTNAME = "immich-redis";
      };
      extraOptions = [
        "--network=container:immich-redis"
        "--device=/dev/dri:/dev/dri"
      ];
    };

    immich-redis = {
      autoStart = true;
      image = "redis";
        extraOptions = [
      #   "-l=traefik.enable=true"
      #   "-l=traefik.http.routers.immich.rule=Host(`photos.${settings.domainName}`)"
      #   "-l=traefik.http.routers.immich.service=immich"
      #   "-l=traefik.http.services.immich.loadbalancer.server.port=8080"
      ];
    };

    immich-postgres = {
      autoStart = true;
      image = "tensorchord/pgvecto-rs:pg14-v0.2.1";
      volumes = [
        "${settings.serviceConfigRoot}/immich/postgresql/data:/var/lib/postgresql/data"
      ];
    #  environmentFiles = [ config.age.secrets.ariaImmichDatabase.path ];
      environment = {
        POSTGRES_USER = "immich";
        POSTGRES_DB = "immich";
      };
      extraOptions = [ "--network=container:immich-redis" ];
    };
  };
}
