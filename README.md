# Nextcloud CI/CD pipeline

<a href="https://dash.elest.io/deploy?source=cicd&social=dockerCompose&url=https://github.com/elestio-examples/nextcloud-collabora"><img src="deploy-on-elestio.png" alt="Deploy on Elest.io" width="180px" /></a>

Deploy Nextcloud with CI/CD on Elestio

<img src="nextcloud.png" style='width: 100%;'/>
<br/>
<br/>

# Once deployed ...

You can can open Nextcloud here:

    URL: https://[CI_CD_DOMAIN]
    Login: root
    password: [ADMIN_PASSWORD]

## Configuring Collabora

### 1.

On your NextCloud dashboard, click your user icon in the top right corner, and select Apps from the drop-down list.
Navigate to the Office & Text apps section.

<img src="step-01.png" style='width: 600px; max-width:100%;'/>
<img src="step-02.png" style='width: 600px; max-width:100%;'/>

Find the Nextcloud Office App, download and enable it.
<img src="step-03.png" style='width: 600px; max-width:100%;'/>

Find the Collabora Online App, download and enable it.
<img src="step-04.png" style='width: 600px; max-width:100%;'/>

### 2.

Access your user icon, and select Settings from the drop-down list.

<img src="step-05.png" style='width: 600px; max-width:100%;'/>

On the left navigation bar, click Nextcloud Office under the Administration section.

<img src="step-06.png" style='width: 600px; max-width:100%;'/>

Toggle Use your own server, enter

        https://[CI_CD_DOMAIN]:21005

and click Save. You should receive a server reachable alert.

<img src="step-06.png" style='width: 600px; max-width:100%;'/>
Scroll to Advanced settings and set your preferred default file type for documents, to work well with Microsoft Office products, use Office Open XML (OOXML). To automatically watermark documents, enable watermarking under Secure view settings.

<img src="step-07.png" style='width: 600px; max-width:100%;'/>

Navigate to Files.
Click create new + to upload supported files, or choose between text, word document, spreadsheet, or presentation files to create.
