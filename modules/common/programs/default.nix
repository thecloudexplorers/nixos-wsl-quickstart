{
    config,
    ...
}:
let
    cfg = config.modules.core;
in
{
    imports = [
        ./development
    ];
    
}