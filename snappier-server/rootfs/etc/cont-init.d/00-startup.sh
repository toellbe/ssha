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
mkdir -p "${EPG_FOLDER}"

bashio::log.info "Storage directories initialized:"
bashio::log.info "  - Recordings: ${RECORDINGS_FOLDER}"
bashio::log.info "  - Movies: ${MOVIES_FOLDER}"
bashio::log.info "  - Series: ${SERIES_FOLDER}"
bashio::log.info "  - PVR: ${PVR_FOLDER}"
bashio::log.info "  - EPG: ${EPG_FOLDER}"

bashio::log.info "Snappier Server Add-on initialization complete!"
bashio::log.info "Access the web interface at: http://[YOUR_HA_IP]:7429"