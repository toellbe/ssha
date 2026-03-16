# Home Assistant Add-on: Snappier Server

**Version:** `1.1.0`  
**Runtime:** Snappier Server CLI **beta** `v1.5.0z`

> **⚠️ WORK IN PROGRESS - EXPERIMENTAL**  
> This add-on is currently under active development. Not all features have been fully tested.  
> Use at your own risk and expect potential issues or incomplete functionality.  
> Feedback and bug reports are welcome!

![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]

Self-hosted, lightweight recording and streaming service for Home Assistant.

## About

Snappier Server is a media recording and streaming application that allows you to record live TV streams, schedule recordings, and download movies and TV series. This Home Assistant add-on packages Snappier Server CLI `v1.5.0z` from the official beta binary source.

**Known Limitations:**
- Some features may not work as expected
- Documentation may be incomplete
- Configuration options may require fine-tuning

## Features

- 🎬 **Live TV Recording**: Record live streams and schedule future recordings
- 📺 **TV Series Management**: Automatic episode downloading and organization
- 🎞️ **Movie Downloads**: Download movies on demand
- 🔄 **Catch-up Recording**: Record previously aired content
- 🎛️ **FFmpeg Integration**: High-quality video processing and transcoding
- 🌐 **Web Interface**: Easy-to-use web-based management interface
- 🔗 **Home Assistant Integration**: Seamless integration with your Home Assistant setup
- 📡 **EPG Support**: Electronic Program Guide with configurable refresh intervals

## Installation

1. Add this repository to your Home Assistant add-on store:
   - Go to **Supervisor** > **Add-on Store** > **⋮** > **Repositories**
   - Add the repository URL: `https://github.com/toellbe/ssha`

2. Find the "Snappier Server" add-on and click **Install**

3. Configure the add-on (see Configuration section below)

4. Start the add-on

## Configuration

### Basic Configuration

```yaml
use_curl_to_download: true
download_speed_limit_mbs: 0
enable_remux: true
enable_epg: false
epg_url: ""
epg_refresh_interval: 24
recordings_folder: "/share/snappier/recordings"
movies_folder: "/share/snappier/movies"
series_folder: "/share/snappier/series"
pvr_folder: "/share/snappier/pvr"
api_token: ""
timezone: "Europe/Berlin"
ssl_cert: "/ssl/fullchain.pem"
ssl_key: "/ssl/privkey.pem"
```

### Advanced Configuration Options

| Option | Description | Default |
|--------|-------------|---------|
| `use_curl_to_download` | Use curl instead of FFmpeg for downloads | `true` |
| `download_speed_limit_mbs` | Download speed limit in MB/s (0 = unlimited) | `0` |
| `enable_remux` | Enable video remuxing | `true` |
| `enable_epg` | Enable EPG (Electronic Program Guide) functionality | `false` |
| `epg_url` | EPG (Electronic Program Guide) URL (optional) | `""` |
| `epg_refresh_interval` | EPG refresh interval in hours (1-168) | `24` |
| `recordings_folder` | Path for recordings | `/share/snappier/recordings` |
| `movies_folder` | Path for movies | `/share/snappier/movies` |
| `series_folder` | Path for TV series | `/share/snappier/series` |
| `pvr_folder` | Path for PVR recordings | `/share/snappier/pvr` |
| `api_token` | Auto-filled generated API token (managed by add-on) | `""` |
| `timezone` | Timezone for scheduling | `Europe/Berlin` |
| `ssl_cert` | SSL certificate path (optional) | `/ssl/fullchain.pem` |
| `ssl_key` | SSL private key path (optional) | `/ssl/privkey.pem` |

### HTTPS / SSL

- HTTPS is enabled only when both configured files exist:
    - `ssl_cert`
    - `ssl_key`
- If one of the fields is empty or a file is missing, the add-on runs on HTTP.
- Default prefilled paths match Home Assistant SSL mapping:
    - `/ssl/fullchain.pem`
    - `/ssl/privkey.pem`

## Usage

### Accessing the Web Interface

Once the add-on is running, you can access the Snappier Server web interface at:
- **External Access**: `http://[HOME_ASSISTANT_IP]:7429`
- **Home Assistant**: Use the "Open Web UI" button in the add-on interface

### Port Configuration

The add-on uses fixed internal ports for better reliability:
- **Snappier Server**: Internal port 8000 → External port 7429

External port mappings are handled automatically by Home Assistant.

### Storage

The add-on stores recordings and downloads in the `/share/snappier/` directory:
- **Recordings**: `/share/snappier/recordings/`
- **Movies**: `/share/snappier/movies/`
- **TV Series**: `/share/snappier/series/`
- **PVR**: `/share/snappier/pvr/`

These directories are accessible from other Home Assistant add-ons.

## Troubleshooting

### Add-on Won't Start
1. Check the add-on logs for error messages
2. Ensure your configuration is valid
3. Verify that the specified ports are not in use
4. Check that the storage directories exist and are writable

### Web Interface Not Accessible
1. Ensure the add-on is running
2. Check that port 7429 is not blocked by your firewall
3. Verify the add-on configuration

### Storage Issues
1. Ensure the `/share/` directory has sufficient space
2. Check write permissions to storage directories
3. Verify the configured storage paths exist

## Technical Details

### Architecture
- **Base Image**: Debian Linux for glibc compatibility
- **Snappier Server**: CLI binaries v1.5.0x from `https://snappierserver.app/betaFiles/`
- **Video Processing**: FFmpeg integration
- **Multi-Architecture**: Support for amd64, aarch64

### Build Information
- Uses Snappier Server beta CLI binaries (not Docker wrapper)
- Simplified single-service architecture
- Fixed port mapping for stability
- Persistent storage integration

## Support

**⚠️ Important Notice:**
This is an experimental add-on. While we strive to help with issues, please understand that:
- Not all features have been thoroughly tested
- Some configurations may not work as expected
- Breaking changes may occur during development

## Version History

See [snappier-server/CHANGELOG.md](./snappier-server/CHANGELOG.md) for all version changes.

## License

This project is licensed under the MIT License. See [LICENSE](./snappier-server/LICENSE) for details.

## Credits

- [Snappier Server](https://www.snappierserver.app/) by the Snappier Server Team
- Home Assistant add-on adaptation and integration
- Community feedback and contributions

---

## Repository Structure

```
ssha/
├── README.md                          # This file
├── repository.json                    # Repository configuration
└── snappier-server/                   # Snappier Server Add-on
    ├── config.yaml                    # Add-on configuration
    ├── Dockerfile                     # Container build instructions
    ├── README.md                      # Detailed add-on documentation
    ├── CHANGELOG.md                   # Version history
    ├── LICENSE                        # MIT License
    └── rootfs/                        # Container filesystem
        ├── etc/
        └── opt/
```

---

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg