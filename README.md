# Keycloak Custom Theme with Maven in Rails 8

## Prerequisites
- Keycloak v26+ running
- Basic Keycloak admin knowledge
- Familiarity with FreeMarker templates (FTL)
- Maven 3.6.3+
- Java 21+
- Rails 8 project for integration testing
- Visual Studio Code

## Overview
Customize Keycloak login, account, and email screens to match your Rails app branding.

---

## Quickstart: Keycloak + MailHog (Docker)


### 1. Clean Docker
```bash
docker rm -f $(docker ps -a -q) && docker system prune -a
```
```bash
docker network create demo-network
```
### 2. Run Keycloak
```bash
docker run -d --name keycloak --network demo-network -p 8080:8080 \
  -e KC_BOOTSTRAP_ADMIN_USERNAME=admin \
  -e KC_BOOTSTRAP_ADMIN_PASSWORD=admin \
  quay.io/keycloak/keycloak:latest start-dev
```
### 3. Run MailHog
```bash
docker run -d -p 8025:8025 --name demo-mail --network demo-network mailhog/mailhog
```

### 4. Open Keycloak admin: localhost:8080 (admin/admin)

#### 4.1 Create realm quickstart and client test-cli

### 5 Configure client as OpenID Connect with your Rails app URLs

#### 5.1 Rails Credentials
```bash
EDITOR="code --wait" rails credentials:edit
```
```code
keycloak:
  client_id: your-client-id
  client_secret: your-client-secret
  host: http://localhost
  port: 8080
  realm: quickstart
  redirect_uri: http://localhost:3000/auth/keycloak/callback

secret_key_base: <generated>
```
### 6. Build Keycloak Theme with Maven

#### 6.1 Generate Maven project
```maven
mvn archetype:generate \
  -DgroupId=com.bootlabs \
  -DartifactId=keycloak-custom-theme \
  -DarchetypeArtifactId=maven-archetype-quickstart \
  -DinteractiveMode=false
```
#### 6.2  Remove default Java sources
```bash
rm -rf src/
mkdir -p src/main/resources/theme/keycloak-custom-theme/login
```
### 7. Key Files

    login/login.ftl → Login page template

    login/resources/css/login.css → Styles

    login/resources/img/logo.png → Logo

    theme.properties → Theme metadata

    scripts/update-footer.sh → Footer script with Git commit/version

### 8. Update Footer Script
```bash
#!/bin/bash
set -e
GIT_HASH=$(git rev-parse --short HEAD)
DATE=$(date +"%Y-%m-%d")
YEAR=$(date +"%Y")
FOOTER_FILE="src/main/resources/theme/keycloak-custom-theme/login/footer.ftl"
cat <<EOF > "$FOOTER_FILE"
<#macro content>
<footer id="kc-footer" style="display:flex;flex-direction:column;align-items:center;text-align:center;padding:1rem;font-size:0.85rem;color:#666;">
<p>&copy; $YEAR Company inc — All right reserved.</p>
<p>Version $GIT_HASH ($DATE)</p>
<p>Support: <a href="mailto:support@org.inc">support@org.inc</a></p>
</footer>
</#macro>
EOF
echo "✅ Footer updated successfully in $FOOTER_FILE"
```
### 9. Build & Deploy Theme
```bash
mvn clean install
```
This runs update-footer.sh and packages the theme as a JAR

Theme is deployed to Keycloak Docker container via Maven exec plugin

### 10. Activate Theme

Go to `Keycloak > Realm quickstart > Client test-cli > Realm settings > Themes`

Set `Login Theme` to `keycloak-custom-theme` and **save**

### 10. Test

Run Rails app:
```bash
bin/dev
```
Visit `localhost:3000` and click `Login with Keycloak`

### 11. Check email via localhost:8025 (MailHog)


### 12. References

[Tutorial: OmniAuth with Keycloak in Rails 8]()

## Acknowledgements

 - [Omniauth::Keycloak](https://github.com/ccrockett/omniauth-keycloak)
 - [Jeovan Farias](https://www.linkedin.com/in/jeovan-f-6283b8145/)
 - [Keycloak For beginers](https://medium.com/jungletronics/keycloak-identity-provider-192ffd9a00ae)




## License

[MIT](https://choosealicense.com/licenses/mit/)

