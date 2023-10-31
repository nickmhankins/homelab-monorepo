db.getSiblingDB("unifi").createUser({user: "unifi", pwd: "{{ db_pass }}", roles: [{role: "dbOwner", db: "unifi"}, {role: "dbOwner", db: "unifi_stat"}]});
