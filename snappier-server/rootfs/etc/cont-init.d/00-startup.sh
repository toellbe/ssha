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
XTREAM_FOLDER=$(bashio::config 'xtream_folder')

# Create directories only when the corresponding config option is non-empty.
for directory in \
    "${RECORDINGS_FOLDER}" \
    "${MOVIES_FOLDER}" \
    "${SERIES_FOLDER}" \
    "${PVR_FOLDER}" \
    "${XTREAM_FOLDER}"; do
    [ -n "${directory}" ] && mkdir -p "${directory}"
done

bashio::log.info "Storage directories initialized:"
bashio::log.info "  - Recordings: ${RECORDINGS_FOLDER}"
bashio::log.info "  - Movies: ${MOVIES_FOLDER}"
bashio::log.info "  - Series: ${SERIES_FOLDER}"
bashio::log.info "  - PVR: ${PVR_FOLDER}"
bashio::log.info "  - Xtream: ${XTREAM_FOLDER}"

# Generate API token if not yet set
_api_token="$(bashio::config 'api_token')"
if [ -z "${_api_token}" ]; then
    _api_token="$(openssl rand -hex 16)"
    bashio::log.info "Generated new API token."

    _payload="$(jq -n \
        --arg recordings_folder "$(bashio::config 'recordings_folder')" \
        --arg movies_folder "$(bashio::config 'movies_folder')" \
        --arg series_folder "$(bashio::config 'series_folder')" \
        --arg pvr_folder "$(bashio::config 'pvr_folder')" \
        --arg xtream_folder "$(bashio::config 'xtream_folder')" \
        --arg api_token "${_api_token}" \
        --arg timezone "$(bashio::config 'timezone')" \
        '{
            options: {
                recordings_folder: $recordings_folder,
                movies_folder: $movies_folder,
                series_folder: $series_folder,
                pvr_folder: $pvr_folder,
                xtream_folder: $xtream_folder,
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

# Write config.json to the persistent add-on config dir (private, survives restarts).
# Only create it if it doesn't exist yet, so user settings are preserved.
_snappier_config="/config/snappier/config.json"
mkdir -p "$(dirname "${_snappier_config}")"
if [ ! -f "${_snappier_config}" ]; then
    jq -n --arg token "${_api_token}" '{"api_token": $token}' > "${_snappier_config}"
    bashio::log.info "config.json created at ${_snappier_config} with API token."
else
    bashio::log.info "config.json already exists at ${_snappier_config} - keeping existing settings."
fi

bashio::log.info "Snappier Server Add-on initialization complete!"
bashio::log.info "Access the web interface at: http://[YOUR_HA_IP]:7429"
