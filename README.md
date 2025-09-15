# plone-operaton-playground [![Documentation at GitHub Pages](https://github.com/datakurre/plone-operaton-playground/actions/workflows/pages/pages-build-deployment/badge.svg)](https://datakurre.github.io/plone-operaton-playground)

This repository hosts a playground and documentation for learning [BPMN](https://www.bpmn.org/) and using it for orchestrating CMS related workflows and integrations in the context of [Plone CMS](https://plone.org).

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/datakurre/plone-operaton-playground)

## Getting started

To get started, pick any of the following options:

* Open this repository in [GitHub Codespaces](https://codespaces.new/datakurre/plone-operaton-playground).

* Or clone this repository and open it using [VSCode](https://code.visualstudio.com/) [Dev Containers](https://code.visualstudio.com/docs/devcontainers/containers) [extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers).

* Or clone this repository, and install [GNU Make](https://www.gnu.org/software/make/) and [devenv.sh](https://devenv.sh/).

* Or choose your own adventure by manually installing [uv](https://docs.astral.sh/uv/), [purjo](https://pypi.org/project/purjo/) and [Operaton](https://operaton) or other compatible BPM engine.


## Down the rabbit hole

Activate the playground by starting its built-in Operaton build with

```console
$ make start
• Using Cachix caches: devenv, datakurre
✓ Building processes in 26.6s
✓ Building shell in 67.4ms
⠙ Starting processes
```

Next, check if `pur`(jo) is already available

```console
$ pur
```

If not, run `make shell` to manually activate the playground `devenv`shell with `uv` and `pur`(jo) pre-installed, and defauld Python virtualenv activated.


## Hello World

Once you have entered the shell with either `make start shell` or separately `make start` and `make shell`, you should be able to try out the following example:

1. Create directory for your bot

   ```console
   $ mkdir hello-world
   $ cd hello-world
   $ pur init --python
   Adding README.md
   Adding .python-version
   Adding tasks.py
   Adding pyproject.toml
   Adding uv.lock
   Adding hello.bpmn
   ```

2. Deploy and start the example process

   ```console
   $ pur run hello.bpmn
   Started: http://localhost:8800/operaton/app/cockpit/default/#/process-instance
   ```

3. Serve the example bot

   ```console
   $ pur serve .
   15-09-2025 19:21:51 | INFO | purjo.runner:112 | Topic | My Topic in BPMN | {'name': 'tasks.main', 'on-fail': 'ERROR', 'process-variables': True}
   15-09-2025 19:21:51 | INFO | operaton.tasks.worker:263 | External task worker started.
   15-09-2025 19:21:51 | DEBUG | operaton.tasks.worker:206 | Waiting for 0 pending asyncio task: [].
   15-09-2025 19:21:51 | INFO | operaton.tasks.worker:241 | Scheduling My Topic in BPMN:2698937b-9269-11f0-858b-6045bd88de3d.
   ```

![Screenshot of GitHub Codespaces](./docs/operaton.png)


## Troubleshooting

### VSCode & Podman

Local VSCode with Podman, might require the following `.devcontainer.json`:

```json
{
  "containerUser": "vscode",
  "customizations": {
    "vscode": {
      "extensions": [
        "bbenoist.Nix",
        "be5invis.toml",
        "charliermarsh.ruff",
        "ms-vscode.makefile-tools",
        "miragon-gmbh.vs-code-bpmn-modeler"
      ]
    }
  },
  "image": "ghcr.io/cachix/devenv:latest",
  "containerEnv": {
    "HOME": "/home/vscode",
    "UV_LINK_MODE": "copy",
    "UV_PYTHON_DOWNLOADS": "never"
  },
  "overrideCommand": false,
  "runArgs": [
    "--userns=keep-id"
  ],
  "updateContentCommand": "devenv test"
}
```

### Curious `devenv` errors

Very occasional and rare errors like the following have been seen:

```console
plone-operaton-playground) vscode ➜ /workspaces/plone-operaton-playground (main) $ make start
devenv processes up -d
• Building processes ...
• Using Cachix: devenv, datakurre
don't know how to build these paths:
  /nix/store/4g8f25hp2yblrhnwd8frmcjfscklb1cc-devenv-up
error:
       error: build of '/nix/store/4g8f25hp2yblrhnwd8frmcjfscklb1cc-devenv-up'
```

This should be fixed by running the following cleanup command

```console
$ make clean
```

and trying again. For example, rebuilding the local devcontainer.
