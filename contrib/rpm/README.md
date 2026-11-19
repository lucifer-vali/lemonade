# RPM packaging

RPM packages for Fedora and EPEL, built on
[Copr](https://copr.fedorainfracloud.org/coprs/g/lemonade-server/lemonade/).

## Installation

```bash
sudo dnf copr enable @lemonade-server/lemonade
sudo dnf install lemonade
```

The `lemonade` package pulls in the server. The remaining subpackages are
optional:

| Package | Contents |
| --- | --- |
| `lemonade-server` | `lemond` server, service unit, FHS paths and state directory |
| `lemonade-server-embedded` | Self-contained server that runs without a system service user; conflicts with `lemonade-server` |
| `lemonade-cli` | `lemonade` command-line client |
| `lemonade-tray` | System tray application |
| `lemonade-desktop` | Tauri desktop application |
| `lemonade-web` | `lemonade-web` browser launcher and desktop entry |

## How releases are built

Releases are cut from tags of the form `vYYYY.WW.N` (see `tools/release.py`).
On tag push, `.github/workflows/copr-rpm.yml` builds and uploads packages:

1. `tools/source_archive.py` writes `lemonade-<version>.tar.gz` from the tag.
2. The workflow stamps `Version:` in `lemonade.spec` from the tag, so the value
   committed here is informational only.
3. One source RPM is built per distro family (Fedora 43/44/45, Fedora rawhide,
   EPEL 10) so each carries the correct dist tag.
4. Each source RPM is submitted to the `@lemonade-server/lemonade` project for
   the matching x86_64 and aarch64 chroots, with a 12-hour build timeout.

## Building locally

Build a source RPM the same way CI does, stamping the spec with the version
derived from the checkout:

```bash
VERSION=$(python3 tools/version.py)
mkdir -p dist
python3 tools/source_archive.py --output-dir dist --version "$VERSION"
cp contrib/rpm/lemonade.spec dist/lemonade.spec
sed -i "s|^Version:.*|Version:        ${VERSION}|" dist/lemonade.spec
rpmbuild -bs dist/lemonade.spec \
    --define "_sourcedir $PWD/dist" \
    --define "_srcrpmdir $PWD/dist"
```

Then build the binary RPMs in a chroot, which resolves `BuildRequires` and
supplies a reproducible environment:

```bash
sudo dnf install mock
sudo usermod -aG mock "$(id -un)"
mock -r fedora-44-x86_64 --rebuild dist/lemonade-*.src.rpm
```

Building outside of `mock` requires the full `BuildRequires` set, network access
for npm and Cargo, and a matching `%dist` tag.
