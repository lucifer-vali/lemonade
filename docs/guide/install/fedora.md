## Fedora Installation

Lemonade is packaged for Fedora 43 and newer.

Install from [Copr](https://copr.fedorainfracloud.org/coprs/g/lemonade-server/lemonade):

```bash
sudo dnf copr enable @lemonade-server/lemonade
sudo dnf install lemonade
```

Install individual packages instead:

```bash
sudo dnf install lemonade-cli              # Command-line client
sudo dnf install lemonade-web              # Browser launcher
sudo dnf install lemonade-tray             # Tray application
sudo dnf install lemonade-server           # Lemonade server
sudo dnf install lemonade-desktop          # Desktop application
sudo dnf install lemonade-server-embedded  # Standalone server
```

Enable and start the service:

```bash
sudo systemctl enable --now lemond
```

Check that it's running:

```bash
sudo systemctl --no-pager status lemond
```

Once the service is running, open [http://localhost:13305](http://localhost:13305) in your browser.
