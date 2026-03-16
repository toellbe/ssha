# Changelog

All notable changes to this project will be documented in this file.

## [1.1.0] - 2026-03-16

### Initial Release
- Initial public release of the Home Assistant add-on package
- Uses Snappier Server CLI beta binaries `v1.5.0z` from `snappierserver.app`
- Multi-architecture support: `amd64`, `aarch64`
- Configurable storage paths for recordings, movies, series, and PVR
- EPG support with configurable URL and refresh interval
- Optional SSL certificate and key path configuration (`ssl_cert`, `ssl_key`)
- If SSL cert/key paths are empty or files are missing, startup falls back to HTTP