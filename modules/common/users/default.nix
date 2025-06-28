{
    ...
}:

{
    users = {
        mutableUsers = true;
        groups = {
            nix-admin = {
                name = "nix-admin";
                gid = 447;
            };
            ssl-cert = {
                name = "ssl-cert";
                gid = 992;
            };
        };
    };
    
}