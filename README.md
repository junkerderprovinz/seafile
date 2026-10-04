<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/junkerderprovinz/seafile/main/.github/assets/banner-dark.png">
    <img src="https://raw.githubusercontent.com/junkerderprovinz/seafile/main/.github/assets/banner.png" alt="Seafile" width="100%">
  </picture>
</p>

<p align="center">
  <a href="https://github.com/junkerderprovinz/seafile/actions/workflows/build.yml"><img src="https://img.shields.io/github/actions/workflow/status/junkerderprovinz/seafile/build.yml?label=Build&style=for-the-badge&logo=githubactions&logoColor=white" alt="Build" height="36"></a>&nbsp;
  <a href="https://github.com/junkerderprovinz/seafile/actions/workflows/lint.yml"><img src="https://img.shields.io/github/actions/workflow/status/junkerderprovinz/seafile/lint.yml?label=Lint&style=for-the-badge&logo=githubactions&logoColor=white" alt="Lint" height="36"></a>&nbsp;
  <a href="https://hub.docker.com/r/junkerderprovinz/seafile"><img src="https://img.shields.io/docker/pulls/junkerderprovinz/seafile?style=for-the-badge&logo=docker&logoColor=white&label=Pulls&color=f7a21b" alt="Docker Pulls" height="36"></a>&nbsp;
  <a href="https://github.com/junkerderprovinz/seafile/pkgs/container/seafile"><img src="https://img.shields.io/badge/Arch-amd64-success?style=for-the-badge&logo=linux&logoColor=white" alt="Arch" height="36"></a>&nbsp;
  <a href="https://www.seafile.com"><img src="https://img.shields.io/badge/Upstream-Seafile%2014-f7a21b?style=for-the-badge&logoColor=white" alt="Seafile 14" height="36"></a>&nbsp;
  <a href="https://unraid.net"><img src="https://img.shields.io/badge/Unraid-Template-f15a2c?style=for-the-badge&logo=unraid&logoColor=white" alt="Unraid" height="36"></a>&nbsp;
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-AGPL--3.0-blue?style=for-the-badge&logo=gnu&logoColor=white" alt="License: AGPL-3.0" height="36"></a>
</p>

<br>

<p align="center">
The official <b>Seafile</b> server, installable on Unraid from a single template. It creates its own
secrets on the first start, and it can run MariaDB, Redis and the notification server inside the
same container when you have none of your own.
</p>

<p align="center">
  <a href="https://github.com/junkerderprovinz/seafile/issues/new/choose"><img src=".github/assets/in-development.png" alt="In development, testers welcome: report a bug" width="100%"></a>
</p>

<br>

<!-- download-buttons: written by scripts/gen_download_buttons.py -->
<p align="center">
  <img src="https://raw.githubusercontent.com/junkerderprovinz/seafile/main/.github/assets/download-buttons/buttons.svg?v=ef15b0b736a1#svgView(viewBox(0,0,841.9,245.3))" alt="In Unraid&#x27;s Community Applications soon" width="160" height="46.618">
  &nbsp;
  <a href="https://hub.docker.com/r/junkerderprovinz/seafile/"><img src="https://raw.githubusercontent.com/junkerderprovinz/seafile/main/.github/assets/download-buttons/buttons.svg?v=ef15b0b736a1#svgView(viewBox(866,0,841.9,245.3))" alt="Run it with Docker" width="160" height="46.618"></a>
  &nbsp;
  <a href="https://github.com/junkerderprovinz/seafile/releases/latest"><img src="https://raw.githubusercontent.com/junkerderprovinz/seafile/main/.github/assets/download-buttons/buttons.svg?v=ef15b0b736a1#svgView(viewBox(1732,0,841.9,245.3))" alt="Download the source archive" width="160" height="46.618"></a>
</p>
<!-- /download-buttons -->

<br>

<p align="center">
A one-knight job: I build it, keep it running, work through the issues and add what people ask for, until nothing is missing. It is free, with no accounts, no telemetry, no ads and no paid tier. No asterisk anywhere. Nothing readable ever leaves your own walls. Forged on evenings and weekends, with heart and stubbornness.
</p>

<p align="center">
If it has earned a place on your server or computer, toss a coin to your knight: it helps cover the costs and keeps the project alive. It also makes this knight's heart beat a little faster. Three ways below, whichever suits you.
</p>

<!-- give-buttons: written by scripts/gen_download_buttons.py -->
<p align="center">
  <a href="https://buymeacoffee.com/junkerderprovinz"><img src="https://raw.githubusercontent.com/junkerderprovinz/seafile/main/.github/assets/download-buttons/buttons.svg?v=ef15b0b736a1#svgView(viewBox(2598,0,841.9,245.3))" alt="Buy me a coffee" width="160" height="46.618"></a>
  &nbsp;
  <a href="https://www.paypal.com/donate/?hosted_button_id=76FVV52TKXTUS"><img src="https://raw.githubusercontent.com/junkerderprovinz/seafile/main/.github/assets/download-buttons/buttons.svg?v=ef15b0b736a1#svgView(viewBox(3464,0,841.9,245.3))" alt="PayPal" width="160" height="46.618"></a>
  &nbsp;
  <a href="https://junkerderprovinz.github.io/junkerderprovinz/"><img src="https://raw.githubusercontent.com/junkerderprovinz/seafile/main/.github/assets/download-buttons/buttons.svg?v=ef15b0b736a1#svgView(viewBox(4330,0,841.9,245.3))" alt="Donate with crypto" width="160" height="46.618"></a>
</p>
<!-- /give-buttons -->

<br>

## Table of Contents

1. [What it looks like](#1-what-it-looks-like)
2. [What it does](#2-what-it-does)
3. [Getting started](#3-getting-started)
4. [How AI is used here](#4-how-ai-is-used-here)
5. [Support this project](#5-support-this-project)

<br>

## 1. What it looks like

The libraries and files in these pictures are made up.

<p align="center">
  <img src=".github/assets/screenshots/seafile-1.png" alt="Seafile's library list in a browser, five libraries in dark mode" width="100%">
  <br><em>Seafile in any browser on your network, from the container on your server.</em>
</p>

<br>

<p align="center">
  <img src=".github/assets/screenshots/seafile-2.png" alt="Folders and documents inside the Documents library, with the file tree on the left" width="100%">
  <br><em>Inside a library: folders, documents and the file tree.</em>
</p>

<br>

## 2. What it does

[Seafile](https://www.seafile.com) syncs and shares files, with desktop and mobile clients, libraries you can encrypt on the client and built-in wikis. Its official image [`seafileltd/seafile-mc`](https://hub.docker.com/r/seafileltd/seafile-mc) expects MariaDB, Redis and a notification server as containers of their own, plus a JWT key made by hand. This image is the official one with a small layer in front:

- **Secrets on the first start.** It generates the JWT key, the database password and, if you leave it empty, the admin password, and keeps them in `secrets.env` in your appdata folder.
- **MariaDB and Redis built in, if you want them.** Both are off by default, because most Unraid servers already have a MariaDB. Switched on, they run next to Seafile and listen only on `127.0.0.1`.
- **Live updates in the clients.** The notification server is included, so the desktop and mobile clients hear about a change when it happens instead of asking on a timer.
- **A clear stop instead of "Page unavailable".** If the database or Redis host is missing, the container stops with one line saying what to set.
- **The official layout.** The official scripts still run the setup and the upgrades, and `/shared` looks the same, so a setup made with the official image or another Seafile template keeps working.

<br>

## 3. Getting started

1. Install **Seafile** from Community Applications.
2. Set **Server hostname** to the address your clients will use, for example `192.168.1.10:8000` or `seafile.example.com`. Leave out `http://`.
3. Pick your services:
   - **No MariaDB or Redis yet?** Set **Built-in MariaDB** and **Built-in Redis** to `true` and leave their host fields empty.
   - **MariaDB already running?** Enter its host and its root password. The root password is only used once, to create the three Seafile databases and the `seafile` user, and you can remove it afterwards.
4. Enter an **Admin email**. Leave the admin password empty to get a generated one.
5. Start the container and open the log. The first start takes about a minute. It is ready when the log says `Seahub is started`. If the password was generated, the log names it, and it is also in `secrets.env`.
6. Open `http://[IP]:8000` and sign in.

With `docker run`:

```bash
docker run -d --name seafile \
  -p 8000:80 \
  -v /mnt/user/appdata/seafile:/shared \
  -e SEAFILE_SERVER_HOSTNAME=192.168.1.10:8000 \
  -e INIT_SEAFILE_ADMIN_EMAIL=you@example.com \
  -e BUILTIN_MARIADB=true \
  -e BUILTIN_REDIS=true \
  junkerderprovinz/seafile:latest
```

Coming from another Seafile template: point **Data** at the same folder, copy over the hostname, the database and Redis settings and the `JWT_PRIVATE_KEY`, and keep **Built-in MariaDB** off. Back up first: a Seafile 13 database is upgraded on the first start, and there is no way back. Every other variable of the official image works as the [Seafile manual](https://manual.seafile.com/latest/setup/setup_ce_by_docker/) describes it.

<br>

## 4. How AI is used here

One knight builds this, and AI is one of the tools I work with, the same way I work with an editor or a compiler. It helps me write code and documentation and it checks my work, and that saves me a good many evenings. It does not make the decisions, though. I read and understand everything before it ships, and if something here breaks, that is on me and not on the tool.

You do not have to take my word for it. The code is open and every release note is written by hand. The issue tracker shows how problems actually get handled, including the ones I got wrong the first time. If you find something that is not right, open an issue and I will look at it.

<br>

## 5. Support this project

Questions? Check the [support thread](https://forums.unraid.net/topic/200798-support-junkerderprovinz-seafile-14/). Bugs, ideas or feature requests? Please [open a GitHub issue](https://github.com/junkerderprovinz/seafile/issues).

A one-knight job: I build it, keep it running, work through the issues and add what people ask for, until nothing is missing. It is free, with no accounts, no telemetry, no ads and no paid tier. No asterisk anywhere. Nothing readable ever leaves your own walls. Forged on evenings and weekends, with heart and stubbornness.

If it has earned a place on your server or computer, toss a coin to your knight: it helps cover the costs and keeps the project alive. It also makes this knight's heart beat a little faster. Three ways below, whichever suits you.

<!-- give-buttons: written by scripts/gen_download_buttons.py -->
<p align="center">
  <a href="https://buymeacoffee.com/junkerderprovinz"><img src="https://raw.githubusercontent.com/junkerderprovinz/seafile/main/.github/assets/download-buttons/buttons.svg?v=ef15b0b736a1#svgView(viewBox(2598,0,841.9,245.3))" alt="Buy me a coffee" width="160" height="46.618"></a>
  &nbsp;
  <a href="https://www.paypal.com/donate/?hosted_button_id=76FVV52TKXTUS"><img src="https://raw.githubusercontent.com/junkerderprovinz/seafile/main/.github/assets/download-buttons/buttons.svg?v=ef15b0b736a1#svgView(viewBox(3464,0,841.9,245.3))" alt="PayPal" width="160" height="46.618"></a>
  &nbsp;
  <a href="https://junkerderprovinz.github.io/junkerderprovinz/"><img src="https://raw.githubusercontent.com/junkerderprovinz/seafile/main/.github/assets/download-buttons/buttons.svg?v=ef15b0b736a1#svgView(viewBox(4330,0,841.9,245.3))" alt="Donate with crypto" width="160" height="46.618"></a>
</p>
<!-- /give-buttons -->

<br>

<sub>Seafile is released by Seafile Ltd., the Community Edition server under AGPL-3.0. This is an independent packaging for Unraid and is not affiliated with Seafile Ltd.</sub>
