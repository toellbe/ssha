# Changelog

All notable changes to this project will be documented in this file.

## [1.2.11-beta.1] - 2026-08-02

### Changed
- Updated Snappier Server CLI to `v1.6.0-1` (amd64 + aarch64)

## [1.2.10-beta.1] - 2026-05-30

### Changed
- Updated Snappier Server CLI to beta `v1.5.6-2` (amd64 + aarch64)

## [1.2.9-beta.1] - 2026-05-19

### Changed
- Bumped Home Assistant beta add-on version to `1.2.9-beta.1`

## [1.2.8-beta.1] - 2026-05-16

### Changed
- Updated Snappier Server CLI to beta `v1.5.5-7` (amd64 + aarch64)

## [1.2.7-beta.1] - 2026-05-04

### Changed
- Updated Snappier Server CLI to beta `v1.5.4-2` (amd64 + aarch64)

## [1.2.6-beta.1] - 2026-04-27

### Changed
- Updated Snappier Server CLI to beta `v1.5.2-2` (amd64 + aarch64)

## [1.2.5-beta.1] - 2026-04-24

### Changed
- Updated Snappier Server CLI to beta `v1.5.2-1` (amd64 + aarch64)

## [1.2.4-beta.1] - 2026-03-29

### Added
- `config_folder` config option to set a custom path for the Snappier Server config file (default: `/share/snappier`) — passed to the binary as `--config <config_folder>/config.json`

### Fixed
- API token was not redacted from logs — `[Auth] Generated API token:` pattern is now correctly detected and replaced with `[REDACTED]`
- API token was never persisted to add-on settings due to the unmatched regex — `persist_api_token_option` is now correctly invoked

## [1.2.3-beta.1] - 2026-03-29

### Changed
- Working directory `/root/SnappierServer` is now used as `$HOME` — add-on no longer writes to `/data`
- Removed unused `/data/recordings`, `/data/movies`, `/data/series`, `/data/pvr` directories from container image

## [1.2.2-beta.1] - 2026-03-28

### Fixed
- EPG refresh interval was ignored and fell back to app default of 24h — `EPG_REFRESH_INTERVAL` is now correctly exported

## [1.2.1-beta.1] - 2026-03-28

### Fixed
- EPG refresh interval was ignored and fell back to app default of 24h — `EPG_REFRESH_INTERVAL` is now correctly exported
- Startup error "no such file or directory" for `/root/SnappierServer` — directory is now always created before `cd`
- API token no longer appears in logs — sensitive token output is redacted

### Added
- `epg_folder` config option to set a custom EPG cache path (default: empty)
- `epg_urls` config option (JSON array) replaces `epg_url` — supports multiple EPG sources
- Startup log now shows EPG enabled state and configured refresh interval

## [1.2.0-beta.1] - 2026-03-22

### Changed
- Split repository into two channels: stable and beta add-ons
- This add-on is now the dedicated beta channel
- Continued to use Snappier Server CLI beta binaries `v1.5.0ab`

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
