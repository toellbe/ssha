# Changelog

All notable changes to this project will be documented in this file.

## [1.3.1] - 2026-04-20

### Changed
- Updated Snappier Server CLI to stable `v1.5.1-1` (amd64 + aarch64)

## [1.3.0] - 2026-04-16

### Changed
- Updated Snappier Server CLI to stable `v1.5.0`

### Added
- `epg_urls_json` config option to define multiple EPG sources as a JSON array
- API token is now auto-generated on first start if not configured, and persisted to add-on settings
- Fresh `config.json` with API token is written to `/root/SnappierServer/SnappierServer/config.json` on every startup
- `EPG_URLS` environment variable is now exported when `epg_urls_json` is set
- `epg_folder` and `epg_urls_json` are now included in the persisted add-on settings payload

## [1.2.3] - 2026-03-29

### Changed
- Working directory `/root/SnappierServer` is now used as `$HOME` — add-on no longer writes to `/data`
- Removed unused `/data/recordings`, `/data/movies`, `/data/series`, `/data/pvr` directories from container image

## [1.2.2] - 2026-03-28

### Fixed
- EPG refresh interval was ignored and fell back to app default of 24h — `EPG_REFRESH_INTERVAL` is now correctly exported

## [1.2.1] - 2026-03-28

### Fixed
- EPG refresh interval was ignored and fell back to app default of 24h — `EPG_REFRESH_INTERVAL` is now correctly exported
- Startup error "no such file or directory" for `/root/SnappierServer` — directory is now always created before `cd`
- API token no longer appears in logs — sensitive token output is redacted

### Added
- `epg_folder` config option to set a custom EPG cache path (default: empty)
- Startup log now shows EPG enabled state and configured refresh interval

## [1.2.0] - 2026-03-22

### Changed
- Split repository into two channels: stable and beta add-ons
- Switched this add-on to stable Snappier Server CLI binaries `v1.3.4`

## [1.1.2] - 2026-03-22

### Changed
- Updated Snappier Server CLI beta binaries to `v1.5.0ab`

## [1.1.1] - 2026-03-16

### Changed
- Updated Snappier Server CLI beta binaries to `v1.5.0a2`

## [1.1.0] - 2026-03-16

### Initial Release
- Initial public release of the Home Assistant add-on package
- Uses Snappier Server CLI beta binaries `v1.5.0z` from `snappierserver.app`
- Multi-architecture support: `amd64`, `aarch64`
- Configurable storage paths for recordings, movies, series, and PVR
- EPG support with configurable URL and refresh interval
- Optional SSL certificate and key path configuration (`ssl_cert`, `ssl_key`)
- If SSL cert/key paths are empty or files are missing, startup falls back to HTTP