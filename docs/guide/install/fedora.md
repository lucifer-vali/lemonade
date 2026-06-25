# Fedora Installation

Lemonade is built for Fedora 43 and 44.

## Step 1: Install lemonade-server

=== "Fedora 43"

    Get the RPM from the [latest release](https://github.com/lemonade-sdk/lemonade/releases):
    `lemonade-server-<version>-fc43.x86_64.rpm`

    ```bash
    sudo dnf install ./lemonade-server-*-fc43.x86_64.rpm
    ```

=== "Fedora 44"

    Get the RPM from the [latest release](https://github.com/lemonade-sdk/lemonade/releases):
    `lemonade-server-<version>-fc44.x86_64.rpm`

    ```bash
    sudo dnf install ./lemonade-server-*-fc44.x86_64.rpm
    ```

Enable and start the service:

```bash
sudo systemctl enable --now lemond
```

Check that it's running:

```bash
sudo systemctl status lemond
```

Once the service is running, open [http://localhost:13305](http://localhost:13305) in your browser.

## System tray app

A system tray application for quick access to model management, logs, and the web app.
Requires GTK3 and AppIndicator3.

```bash
sudo dnf install ./lemonade-tray-*-fc43.x86_64.rpm
```

Then start it:

```bash
lemonade-tray
```
