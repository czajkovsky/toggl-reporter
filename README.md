Toggl reporter
==============

This simple script shows summary of [Toggl](https://www.toggl.com/) time entries per project.

## Setup

Create <code>config.yml</code> file and save your e-mail address and API token - you can find it [here](https://www.toggl.com/app/profile).

Config example:
```
email: 'your@email.com'
api_token: 'y0urt0k3n'
cert_path: '/path/to/your/cert'
```

### Setting up SSL certificates
TogglReporter requires a little extra configuration for users who want to use SSL/HTTPS. You need to set <code>cert_path</code> in <code>config.yml</code>. On OSX it should be inside <code>/usr/local/etc/openssl/</code> directory. You can read more about it [here](https://github.com/lostisland/faraday/wiki/Setting-up-SSL-certificates). If you don't provide cert path it will still work but won't verify certificate.

## Usage

Simply run:
```
ruby toggl_reporter.rb
```

and follow the instructions.
