#!/bin/bash
set -e

# Get Git commit hash
GIT_HASH=$(git rev-parse --short HEAD)
DATE=$(date +"%Y-%m-%d")
YEAR=$(date +"%Y")

# Output file
FOOTER_FILE="src/main/resources/theme/keycloak-custom-theme/login/footer.ftl"

# Write footer
cat <<EOF > "$FOOTER_FILE"
<#macro content>
<footer id="kc-footer" style="display: flex; flex-direction: column; align-items: center; justify-content: center; text-align: center; padding: 1rem; font-size: 0.85rem; color: #666;">
  <p>&copy; $YEAR Company inc - All right reserved.</p>
  <p>Version $GIT_HASH ($DATE)</p>
  <p>Support: <a href="mailto:support@org.inc">support@org.inc</a></p>
</footer>
</#macro>
EOF

echo "✅ Footer updated successfully in $FOOTER_FILE"