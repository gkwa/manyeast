Our app will use cobra-cli package along with viper package for commandline arg parsing along with app config.

When writing golang apps using cobra-cli, its tempting to put app logic in cmd directory but this is considered bad practice.

Our app domain logic should be in our app directory and the go files in cmd directory should remain lite and call out to packages in our domain logic directories.
