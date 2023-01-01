# [nginx_config](#nginx_config)

Ansible role for configuring NGINX

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-nginx_config/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-nginx_config/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-nginx_config/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-nginx_config)|[![quality](https://img.shields.io/ansible/quality/)](https://galaxy.ansible.com/buluma/nginx_config)|[![downloads](https://img.shields.io/ansible/role/d/)](https://galaxy.ansible.com/buluma/nginx_config)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-nginx_config.svg)](https://github.com/buluma/ansible-role-nginx_config/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-nginx_config.svg)](https://github.com/buluma/ansible-role-nginx_config/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-nginx_config.svg)](https://github.com/buluma/ansible-role-nginx_config/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  tasks:
    - name: Configure NGINX.
      ansible.builtin.include_role:
        name: buluma.nginx_config
      vars:
        nginx_config_debug_output: true

        nginx_config_selinux: true
        nginx_config_selinux_tcp_ports:
          - 80

        nginx_config_upload_ssl_enable: true
        nginx_config_upload_ssl_crt:
          - src: ../common/files/ssl/molecule.crt
            dest: /etc/ssl/certs
            backup: true
        nginx_config_upload_ssl_key:
          - src: ../common/files/ssl/molecule.key
            dest: /etc/ssl/private
            backup: true

        nginx_config_main_template_enable: true
        nginx_config_main_template:
          template_file: nginx.conf.j2
          deployment_location: /etc/nginx/nginx.conf
          backup: true
          config:
            main:
              load_module:
                - modules/ngx_http_js_module.so
              user:
                username: nginx
              worker_cpu_affinity:
                auto: true
              worker_priority: 0
              worker_processes: auto
              worker_rlimit_core: 10000
              worker_rlimit_nofile: 10000
              worker_shutdown_timeout: 30m
              error_log:
                - /var/log/nginx/ansible.log
                - file: /var/log/nginx/molecule.log
                - file: /var/log/nginx/error.log
                  level: notice
              pid: /var/run/nginx.pid
              daemon: true
              debug_points: abort
              env:
                variable: PERL5LIB
                value: /data/site/modules
              lock_file: logs/nginx.lock
              master_process: true
              pcre_jit: false
              thread_pool:
                - name: default
                  threads: 32
                  max_queue: 65536
                - name: molecule
                  threads: 32
              timer_resolution: 1s
              working_directory: /etc/nginx
            events:
              accept_mutex: false
              accept_mutex_delay: 500ms
              multi_accept: false
              use: epoll
              worker_aio_requests: 32
              worker_connections: 512
            http:
              include:
                - /etc/nginx/conf.d/*.conf
                - /etc/nginx/conf.d/backend/*.conf
            stream:
              include:
                - /etc/nginx/conf.d/streams/*.conf

        nginx_config_status_enable: true
        nginx_config_status_backup: true
        nginx_config_status_port: 8080
        nginx_config_status_access_log:
          path: /var/log/nginx/access.log
          format: main

        nginx_config_http_template_enable: true
        nginx_config_http_template:
          - backup: true
            config:
              upstreams:
                - name: frontend_servers
                  zone:
                    name: frontend_mem_zone
                    size: 64k
                  least_conn: true
                  keepalive: 32
                  keepalive_requests: 100
                  keepalive_timeout: 60s
                  servers:
                    - address: 0.0.0.0:8081
                      weight: 1
                      max_conns: 100
                      max_fails: 3
                      fail_timeout: 5s
                      backup: false
                      down: false
                      resolve: false
                - name: backend_servers
                  zone:
                    name: backend_mem_zone
                    size: 64k
                  least_conn: true
                  servers:
                    - address: 0.0.0.0:8082
                      weight: 1
                      max_fails: 3
                      fail_timeout: 5s
                    - address: unix:/var/run/control.unit.sock
                      weight: 1
                      max_fails: 3
                      fail_timeout: 5s
                    - address: 0.0.0.0:8083
                      down: true
                    - address: 0.0.0.0:8084
                      backup: true
              core:
                absolute_redirect: true
                aio:
                  threads: true
                aio_write: false
                auth_delay: 0s
                chunked_transfer_encoding: true
                client_body_buffer_size: 8k
                client_body_in_file_only: false
                client_body_in_single_buffer: false
                client_body_temp_path:
                  path: /var/cache/nginx/client
                  level: 2
                client_body_timeout: 60s
                client_header_buffer_size: 1k
                client_header_timeout: 60s
                client_max_body_size: 1m
                connection_pool_size: 256
                default_type: text/plain
                directio: false
                directio_alignment: 512
                disable_symlinks:
                  check: "on"
                  from: $document_root
                error_page:
                  - code:
                      - 404
                    response: 404
                    uri: /404.html
                etag: true
                if_modified_since: exact
                ignore_invalid_headers: true
                internal: false
                keepalive_disable: msie6
                keepalive_requests: 1000
                keepalive_time: 1h
                keepalive_timeout:
                  timeout: 75s
                  header_timeout: 75s
                large_client_header_buffers:
                  number: 4
                  size: 8k
                limit_rate: 0
                limit_rate_after: 0
                lingering_close: true
                lingering_time: 30s
                lingering_timeout: 5s
                log_not_found: true
                log_subrequest: false
                max_ranges: 0
                merge_slashes: true
                msie_padding: true
                msie_refresh: false
                open_file_cache:
                  max: 10
                  inactive: 60s
                open_file_cache_errors: false
                open_file_cache_min_uses: 1
                open_file_cache_valid: 60s
                output_buffers:
                  number: 2
                  size: 32k
                port_in_redirect: true
                postpone_output: 1460
                read_ahead: 0
                recursive_error_pages: false
                request_pool_size: 4k
                reset_timedout_connection: false
                resolver:
                  address: 127.0.0.1
                  valid: 60s
                  ipv6: false
                resolver_timeout: 30s
                root: html
                satisfy: all
                send_timeout: 60s
                sendfile: false
                sendfile_max_chunk: 0
                server_name_in_redirect: false
                server_names_hash_bucket_size: 32
                server_names_hash_max_size: 512
                server_tokens: true
                subrequest_output_buffer_size: 4k
                tcp_nodelay: true
                tcp_nopush: false
                types:
                  - mime: text/html
                    extensions: html
                  - mime: application/octet-stream
                    extensions:
                      - bin
                      - exe
                      - dll
                types_hash_bucket_size: 64
                types_hash_max_size: 1024
                underscores_in_headers: false
                variables_hash_bucket_size: 64
                variables_hash_max_size: 1024
              ssl:
                buffer_size: 16k
                certificate: /etc/ssl/certs/molecule.crt
                certificate_key: /etc/ssl/private/molecule.key
                ciphers:
                  - HIGH
                  - "!aNull"
                  - "!MD5"
                conf_command: Protocol TLSv1.2
                early_data: false
                ecdh_curve: auto
                ocsp: false
                ocsp_cache:
                  name: cache1
                  size: 1m
                ocsp_responder: false
                prefer_server_ciphers: false
                protocols:
                  - TLSv1
                  - TLSv1.1
                  - TLSv1.2
                reject_handshake: false
                session_cache:
                  builtin:
                    enable: true
                    size: 20480
                session_tickets: true
                session_timeout: 5m
                stapling: false
                stapling_verify: false
                verify_client: false
                verify_depth: 1
              proxy:
                bind: false
                buffer_size: 4k
                buffering: true
                buffers:
                  number: 8
                  size: 4k
                busy_buffers_size: 8k
                cache: false
                cache_background_update: false
                cache_bypass: $cookie_test
                cache_convert_head: true
                cache_key: $scheme$proxy_host$request_uri
                cache_lock: false
                cache_lock_age: 5s
                cache_lock_timeout: 5s
                cache_max_range_offset: 1
                cache_methods:
                  - GET
                  - HEAD
                cache_min_uses: 1
                cache_path:
                  - path: /var/cache/nginx/proxy/frontend
                    levels: "1:1"
                    use_temp_path: false
                    inactive: 10m
                    keys_zone:
                      name: frontend_proxy_cache
                      size: 10m
                    max_size: 2g
                    min_free: 1g
                    manager_files: 100
                    manager_sleep: 500ms
                    manager_threshold: 200ms
                    loader_files: 100
                    loader_sleep: 50ms
                    loader_threshold: 200ms
                  - path: /var/cache/nginx/proxy/backend
                    levels: "1:2"
                    use_temp_path: true
                    keys_zone:
                      name: backend_proxy_cache
                      size: 10m
                    inactive: 60m
                    max_size: 10g
                cache_revalidate: false
                cache_use_stale: false
                cache_valid:
                  - code: 200
                    time: 10m
                  - code:
                      - 201
                      - 202
                    time: 10m
                  - time: 1m
                  - 2m
                connect_timeout: 60s
                cookie_domain:
                  - domain: localhost
                    replacement: example.com
                cookie_flags: false
                cookie_path:
                  path: $uri
                  replacement: $uri
                force_ranges: false
                headers_hash_bucket_size: 64
                headers_hash_max_size: 512
                hide_header:
                  - Date
                  - X-Accel-Redirect
                http_version: 1.1
                ignore_client_abort: false
                ignore_headers:
                  - X-Accel-Redirect
                intercept_errors: false
                limit_rate: 0
                max_temp_file_size: 1024m
                method: GET
                next_upstream:
                  - error
                  - timeout
                next_upstream_timeout: 0
                next_upstream_tries: 0
                no_cache:
                  - $cookie_nocache
                  - $arg_nocache$arg_comment
                pass_header:
                  - Date
                  - X-Accel-Redirect
                pass_request_body: false
                pass_request_headers: true
                read_timeout: 60s
                redirect: false
                request_buffering: false
                send_timeout: 60s
                set_body: body
                set_header:
                  - field: Host
                    value: $proxy_host
                  - field: Connection
                    value: close
                socket_keepalive: false
                ssl_certificate: /etc/ssl/certs/molecule.crt
                ssl_certificate_key: /etc/ssl/private/molecule.key
                ssl_ciphers: HIGH
                ssl_conf_command:
                  - Protocol TLSv1.2
                ssl_name: $proxy_host
                ssl_protocols: TLSv1.2
                ssl_server_name: false
                ssl_session_reuse: true
                ssl_verify: false
                ssl_verify_depth: 1
                store: false
                store_access:
                  user: rw
                  group: rw
                  all: r
                temp_file_write_size: 8k
                temp_path:
                  path: /var/cache/nginx/proxy
                  level: 2
              grpc:
                bind:
                  address: $remote_addr
                  transparent: false
                buffer_size: 4k
                connect_timeout: 60s
                hide_header: X-Accel-Redirect
                ignore_headers: X-Accel-Redirect
                intercept_errors: false
                next_upstream: timeout
                next_upstream_timeout: 0
                next_upstream_tries: 0
                pass_header: X-Accel-Charset
                read_timeout: 60s
                send_timeout: 60s
                set_header:
                  field: Accept-Encoding
                  value: '""'
                socket_keepalive: false
                ssl_certificate: /etc/ssl/certs/molecule.crt
                ssl_certificate_key: /etc/ssl/private/molecule.key
                ssl_ciphers: HIGH
                ssl_conf_command: Protocol TLSv1.2
                ssl_name: $proxy_host
                ssl_protocols: TLSv1.2
                ssl_server_name: false
                ssl_session_reuse: true
                ssl_verify: false
                ssl_verify_depth: 1
              access:
                allow:
                  - all
                deny:
                  - 192.168.1.66
              auth_basic:
                realm: molecule
              auth_request:
                uri: false
                set:
                  variable: $temp
                  value: auth
              autoindex:
                enable: true
                exact_size: true
                format: html
                localtime: true
              gunzip:
                enable: true
                buffers:
                  number: 32
                  size: 4k
              gzip:
                enable: true
                buffers:
                  number: 32
                  size: 4k
                comp_level: 1
                disable:
                  - '"msie6"'
                http_version: 1.1
                min_length: 20
                proxied:
                  - expired
                types:
                  - text/html
                vary: false
              headers:
                add_headers:
                  - name: Strict-Transport-Security
                    value: '"max-age=15768000; includeSubDomains"'
                    always: true
                add_trailers:
                  name: Strict-Transport-Security
                  value: '"max-age=15768000; includeSubDomains"'
                  always: false
                expires:
                  modified: true
                  time: 12h
              limit_req:
                limit_reqs:
                  - zone: one
                    burst: 5
                    delay: false
                dry_run: false
                log_level: info
                status: 503
                zones:
                  - key: $binary_remote_addr
                    name: one
                    size: 1m
                    rate: 10r/s
              log:
                access:
                  - path: /var/log/nginx/access.log
                    format: main
                    buffer: 1m
                    gzip: 5
                    flush: 10h
                    if: $status
                format:
                  - name: main
                    format: |
                      '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"'
                error_log:
                  file: /var/log/nginx/error.log
                  level: notice
                open_log_file_cache:
                  max: 1000
                  inactive: 20s
                  min_uses: 2
                  valid: 1m
              map:
                hash_bucket_size: 128
                hash_max_size: 4096
                mappings:
                  - string: $http_host
                    variable: $name
                    hostnames: true
                    volatile: true
                    content:
                      - value: example.com
                        new_value: 1
                  - string: $http_user_agent
                    variable: $isblockaccess_ua
                    content:
                      - value: default
                        new_value: 0
                      - value: '"~jndi:ldap"'
                        new_value: 1
              realip:
                set_real_ip_from: 0.0.0.0
                real_ip_header: X-Real-IP
                real_ip_recursive: false
              rewrite:
                log: false
                uninitialized_variable_warn: false
              split_clients:
                string: $remote_addr
                variable: $upstream_split
                content:
                  - percentage: 20%
                    value: appv2
                  - percentage: "*"
                    value: app
              sub_filter:
                sub_filters:
                  - string: server_hostname
                    replacement: $hostname
                last_modified: false
                once: false
                types: text/json
              custom_directives:
                - server {}
              servers:
                - core:
                    aio:
                      threads: default
                    keepalive_timeout: 75s
                    listen:
                      - address: 0.0.0.0
                        port: 80
                        default_server: true
                        ssl: false
                        http2: false
                        spdy: false
                        proxy_protocol: false
                        fastopen: 12
                        backlog: 511
                        rcvbuf: 512
                        sndbuf: 512
                        deffered: false
                        bind: false
                        ipv6only: false
                        reuseport: false
                        so_keepalive: false
                      - address: 0.0.0.0
                        port: 443
                        default_server: true
                        ssl: false
                        so_keepalive:
                          keepidle: 30m
                          keepintvl: 5
                          keepcnt: 10
                      - address: "[::]"
                        port: 80
                        default_server: true
                        ssl: false
                    open_file_cache: false
                    server_name: localhost
                    try_files:
                      files: $uri
                      uri: /images/default.gif
                  auth_basic:
                    realm: false
                  log:
                    access:
                      - path: /var/log/nginx/access.log
                        format: main
                  rewrite:
                    break: true
                    rewrites:
                      - regex: (.*).html(.*)
                        replacement: $1$2
                        flag: last
                    log: false
                    set:
                      - variable: $var
                        value: var
                    uninitialized_variable_warn: false
                  locations:
                    - location: /
                      core:
                        alias: /
                        limit_except:
                          method: GET
                          directive: allow all
                      mirror:
                        uri: /mirror
                      proxy:
                        pass: http://frontend_servers/
                    - location: /backend
                      proxy:
                        pass: http://backend_servers/
                    - location: /mirror
                      internal: true
                      proxy:
                        pass: http://127.0.0.1/
          - template_file: http/default.conf.j2
            deployment_location: /etc/nginx/conf.d/frontend_default.conf
            config:
              servers:
                - core:
                    listen:
                      - port: 8081
                    server_name: localhost
                  log:
                    access: false
                  autoindex:
                    enable: false
                  sub_filter:
                    sub_filters:
                      - string: server_hostname
                        replacement: $hostname
                      - string: server_address
                        replacement: $server_addr:$server_port
                      - string: server_url
                        replacement: $request_uri
                      - string: remote_addr
                        replacement: $remote_addr:$remote_port
                      - string: server_date
                        replacement: $time_local
                      - string: client_browser
                        replacement: $http_user_agent
                      - string: request_id
                        replacement: $request_id
                      - string: nginx_version
                        replacement: $nginx_version
                      - string: document_root
                        replacement: $document_root
                      - string: proxied_for_ip
                        replacement: $http_x_forwarded_for
                    last_modified: false
                    once: false
                  locations:
                    - location: /
                      core:
                        index: frontend_index.html
                        root: /usr/share/nginx/html
                    - location: /alias
                      core:
                        alias: /usr/share/nginx/html
                        index: frontend_index.html
                    - location: /return
                      rewrite:
                        return:
                          code: 200
                          text: molecule
          - template_file: http/default.conf.j2
            deployment_location: /etc/nginx/conf.d/backend/backend_default.conf
            config:
              servers:
                - core:
                    listen:
                      - port: 8082
                    server_name: localhost
                  autoindex:
                    enable: false
                  sub_filter:
                    sub_filters:
                      - string: server_hostname
                        replacement: $hostname
                      - string: server_address
                        replacement: $server_addr:$server_port
                      - string: server_url
                        replacement: $request_uri
                      - string: remote_addr
                        replacement: $remote_addr:$remote_port
                      - string: server_date
                        replacement: $time_local
                      - string: client_browser
                        replacement: $http_user_agent
                      - string: request_id
                        replacement: $request_id
                      - string: nginx_version
                        replacement: $nginx_version
                      - string: document_root
                        replacement: $document_root
                      - string: proxied_for_ip
                        replacement: $http_x_forwarded_for
                    last_modified: false
                    once: false
                  locations:
                    - location: /
                      core:
                        index: backend_index.html
                        root: /usr/share/nginx/html
                    - location: /stub_status
                      stub_status: true
                    - location: ~ \.php$
                      core:
                        root: /usr/share/nginx/html
                      custom_directives:
                        - fastcgi_split_path_info ^(.+\.php)(/.+)$;
                        - fastcgi_pass unix:/run/php/php7.2-fpm.sock;
                        - fastcgi_index index.php;
                        - include fastcgi_params;
                        - fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;

        nginx_config_html_demo_template_enable: true
        nginx_config_html_demo_template:
          - template_file: www/index.html.j2
            deployment_location: /usr/share/nginx/html/frontend_index.html
            backup: true
            web_server_name: Frontend
          - template_file: www/index.html.j2
            deployment_location: /usr/share/nginx/html/backend_index.html
            backup: true
            web_server_name: Backend

        nginx_config_stream_template_enable: true
        nginx_config_stream_template:
          - template_file: stream/default.conf.j2
            deployment_location: /etc/nginx/conf.d/streams/stream_default.conf
            config:
              upstreams:
                - name: stream_upstream
                  zone:
                    name: stream_zone
                    size: 64k
                  least_conn: true
                  servers:
                    - address: 0.0.0.0:9091
                      weight: 1
                      max_conns: 100
                      max_fails: 3
                      fail_timeout: 5s
                      backup: false
                      down: false
                      resolve: false
              core:
                preread_buffer_size: 16k
                preread_timeout: 30s
                proxy_protocol_timeout: 30s
                resolver_timeout: 30s
                tcp_nodelay: true
                variables_hash_bucket_size: 64
                variables_hash_max_size: 1024
              ssl:
                alpn: http/1.1
                certificate: /etc/ssl/certs/molecule.crt
                certificate_key: /etc/ssl/private/molecule.key
                ciphers:
                  - HIGH
                  - "!aNull"
                  - "!MD5"
                conf_command: Protocol TLSv1.2
                ecdh_curve: auto
                handshake_timeout: 60s
                prefer_server_ciphers: false
                protocols:
                  - TLSv1
                  - TLSv1.1
                  - TLSv1.2
                session_cache:
                  builtin:
                    enable: true
                    size: 20480
                session_tickets: true
                session_timeout: 5m
                verify_client: false
                verify_depth: 1
              proxy:
                bind: false
                buffer_size: 4k
                connect_timeout: 60s
                download_rate: 0
                half_close: false
                next_upstream: true
                next_upstream_timeout: 0
                next_upstream_tries: 0
                protocol: false
                requests: 0
                responses: 0
                # session_drop: false  # Only NGINX Plus
                ssl: false
                ssl_certificate: /etc/ssl/certs/molecule.crt
                ssl_certificate_key: /etc/ssl/private/molecule.key
                ssl_ciphers: HIGH
                ssl_conf_command:
                  - Protocol TLSv1.2
                ssl_name: $hostname
                ssl_protocols: TLSv1.2
                ssl_server_name: false
                ssl_session_reuse: true
                ssl_verify: false
                ssl_verify_depth: 1
                timeout: 10m
                upload_rate: 0
              log:
                access:
                  - path: /var/log/nginx/access_stream.log
                    format: main
                    buffer: 1m
                    gzip: 5
                    flush: 10h
                    if: $status
                format:
                  - name: main
                    format: |
                      '$remote_addr - [$time_local] $status '
                error_log:
                  file: /var/log/nginx/error_stream.log
                  level: notice
                open_log_file_cache:
                  max: 1000
                  inactive: 20s
                  min_uses: 2
                  valid: 1m
              servers:
                - core:
                    listen:
                      - address: 0.0.0.0
                        port: 9090
                        ssl: false
                        proxy_protocol: false
                        fastopen: 12
                        backlog: 511
                        rcvbuf: 512
                        sndbuf: 512
                        bind: false
                        ipv6only: false
                        reuseport: false
                        so_keepalive: false
                  proxy:
                    pass: stream_upstream
```

The machine needs to be prepared. In CI this is done using `molecule/default/prepare.yml`:
```yaml
---
- name: Prepare
  hosts: all
  tasks:
    - name: Install NGINX
      ansible.builtin.include_role:
        name: nginxinc.nginx
      vars:
        nginx_modules:
          - njs
```



## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-nginx_config/blob/main/requirements.txt).


## [Dependencies](#dependencies)

Most roles require some kind of preparation, this is done in `molecule/default/prepare.yml`. This role has a "hard" dependency on the following roles:

- collections
## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-nginx_config/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|alpine|all|
|amazon|all|
|debian|buster, bullseye|
|el|7, 8|
|ubuntu|all|
|opensuse|all|

The minimum version of Ansible required is 2.11, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-nginx_config/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-nginx_config/blob/master/CHANGELOG.md)

## [License](#license)

Apache License, Version 2.0

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
