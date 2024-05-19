#!/bin/sh

if [ x"${AUTHENTIK_URL}" == "x" ]; then
  echo "AUTHENTIK_URL is not set"
  exit 1
fi

if [ x"${AUTHENTIK_TOKEN}" == "x" ]; then
  echo "AUTHENTIK_TOKEN is not set"
  exit 2
fi

if [ x"${AUTHENTIK_DEFAULT_BRAND_DOMAIN}" == "x" ]; then
  echo "AUTHENTIK_DEFAULT_BRAND_DOMAIN is not set"
  exit 3
fi

if [ x"${AUTHENTIK_DEFAULT_BRAND_DEFAULT}" == "x" ]; then
  echo "AUTHENTIK_DEFAULT_BRAND_DEFAULT is not set"
  exit 4
fi

_JSON_RESPONSE=$(curl -X GET "${AUTHENTIK_URL}/api/v3/core/brands/?domain=${AUTHENTIK_DEFAULT_BRAND_DOMAIN}" \
 -H "Accept: application/json" \
 -H "Authorization: Bearer ${AUTHENTIK_TOKEN}")

_BRAND_UUID=$(echo $_JSON_RESPONSE | grep -o '"brand_uuid":"[^"]*' | grep -o '[^"]*$')

_PAYLOAD="{\"default\":${AUTHENTIK_DEFAULT_BRAND_DEFAULT},\"domain\":\"${AUTHENTIK_DEFAULT_BRAND_DOMAIN}\"}"

curl -X PUT "${AUTHENTIK_URL}/api/v3/core/brands/${_BRAND_UUID}/" \
 -H "Accept: application/json" \
 -H "Authorization: Bearer ${AUTHENTIK_TOKEN}" \
 -H "Content-Type: application/json" \
 -d "${_PAYLOAD}"

