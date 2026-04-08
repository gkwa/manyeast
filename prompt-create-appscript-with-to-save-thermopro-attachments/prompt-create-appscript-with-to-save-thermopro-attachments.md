Lets create project colorfulcrane.

Its google app script to scan email from noreply@itronicsglobal.com and save csv attachments similar to "ThermoProSensor_export_TP350S _09212025.csv" to google drive in folder thermopro.

We'll need credentials to be able to save the file to google drive and google app script allows for saving secrets.  We'll name the secret COLORFULCRANE.

- we should use justfile as makefile alternative
- we'll use clasp to deploy our app.
- clasp referene https://github.com/google/clasp?tab=readme-ov-file#clasp

{{ include "../webui-common/webui-common.md" . | trim }}"
