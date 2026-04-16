#!/usr/bin/with-contenv bashio
# ==============================================================================
# Home Assistant Community Add-on: Snappier Server
# Startup script for finishing configuration
# ==============================================================================

bashio::log.info "Preparing Snappier Server Add-on..."

# Create storage directories based on configuration
RECORDINGS_FOLDER=$(bashio::config 'recordings_folder')
MOVIES_FOLDER=$(bashio::config 'movies_folder')
SERIES_FOLDER=$(bashio::config 'series_folder')
PVR_FOLDER=$(bashio::config 'pvr_folder')
EPG_FOLDER=$(bashio::config 'epg_folder')

# Create directories if they don't exist
mkdir -p "${RECORDINGS_FOLDER}"
mkdir -p "${MOVIES_FOLDER}"
mkdir -p "${SERIES_FOLDER}"
mkdir -p "${PVR_FOLDER}"
[ -n "${EPG_FOLDER}" ] && mkdir -p "${EPG_FOLDER}"

bashio::log.info "Storage directories initialized:"
bashio::log.info "  - Recordings: ${RECORDINGS_FOLDER}"
bashio::log.info "  - Movies: ${MOVIES_FOLDER}"
bashio::log.info "  - Series: ${SERIES_FOLDER}"
bashio::log.info "  - PVR: ${PVR_FOLDER}"
[ -n "${EPG_FOLDER}" ] && bashio::log.info "  - EPG: ${EPG_FOLDER}"

# Generate API token if not yet set
_api_token="$(bashio::config 'api_token')"
if [ -z "${_api_token}" ]; then
    _api_token="$(openssl rand -hex 16)"
    bashio::log.info "Generated new API token."

    _payload="$(jq -n \
        --argjson use_curl_to_download "$(bashio::config 'use_curl_to_download')" \
        --argjson download_speed_limit_mbs "$(bashio::config 'download_speed_limit_mbs')" \
        --argjson enable_remux "$(bashio::config 'enable_remux')" \
        --argjson enable_epg "$(bashio::config 'enable_epg')" \
        --arg epg_url "$(bashio::config 'epg_url')" \
        --arg epg_urls_json "$(bashio::config 'epg_urls_json')" \
        --argjson epg_refresh_interval "$(bashio::config 'epg_refresh_interval')" \
        --arg epg_folder "$(bashio::config 'epg_folder')" \
        --arg recordings_folder "$(bashio::config 'recordings_folder')" \
        --arg movies_folder "$(bashio::config 'movies_folder')" \
        --arg series_folder "$(bashio::config 'series_folder')" \
        --arg pvr_folder "$(bashio::config 'pvr_folder')" \
        --arg api_token "${_api_token}" \
        --arg timezone "$(bashio::config 'timezone')" \
        '{
            options: {
                use_curl_to_download: $use_curl_to_download,
                download_speed_limit_mbs: $download_speed_limit_mbs,
                enable_remux: $enable_remux,
                enable_epg: $enable_epg,
                epg_url: $epg_url,
                epg_urls_json: $epg_urls_json,
                epg_refresh_interval: $epg_refresh_interval,
                epg_folder: $epg_folder,
                recordings_folder: $recordings_folder,
                movies_folder: $movies_folder,
                series_folder: $series_folder,
                pvr_folder: $pvr_folder,
                api_token: $api_token,
                timezone: $timezone
            }
        }')"

    if curl -sS \
        -H "Authorization: Bearer ${SUPERVISOR_TOKEN}" \
        -H "Content-Type: application/json" \
        -d "${_payload}" \
        "http://supervisor/addons/self/options" >/dev/null; then
        bashio::log.info "API token persisted to add-on settings."
    else
        bashio::log.warning "Could not persist API token to add-on settings."
    fi
else
    bashio::log.info "API token already set."
fi

# Always write a fresh config.json with only the API token before starting.
# All other settings are passed via environment variables in the run script.
_snappier_config="/root/SnappierServer/SnappierServer/config.json"
mkdir -p "$(dirname "${_snappier_config}")"
rm -f "${_snappier_config}"
jq -n --arg token "${_api_token}" '{"api_token": $token}' > "${_snappier_config}"
bashio::log.info "Fresh config.json written with API token."

bashio::log.info "Snappier Server Add-on initialization complete!"
bashio::log.info "Access the web interface at: http://[YOUR_HA_IP]:7429"