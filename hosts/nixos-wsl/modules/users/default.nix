{
  ...
}:

{
  imports = [
    # Import any specific users here, instead
    # of directly in one file like the basic
    # example configuration
    ./mike
  ];

  users = {
    mutableUsers = true;
    # If you prefer to split apart the groups config
    # in another file, you can of course
    groups = {
      acme = {
        name = "acme";
        gid = 991;
      };
    };
  };

}