#compdef uv

autoload -U is-at-least

_uv() {
    typeset -A opt_args
    typeset -a _arguments_options
    local ret=1

    if is-at-least 5.2; then
        _arguments_options=(-s -S -C)
    else
        _arguments_options=(-s -C)
    fi

    local context curcontext="$curcontext" state line
    _arguments "${_arguments_options[@]}" : \
'--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' \
'--python-preference=[Whether to prefer uv-managed or system Python installations]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' \
'--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' \
'(--no-color)--color=[Control colors in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' \
'--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' \
'--project=[Run the command within the given project directory]:PROJECT:_files' \
'--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' \
'-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' \
'--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' \
'(-v --verbose)-q[Do not print any output]' \
'(-v --verbose)--quiet[Do not print any output]' \
'(-q --quiet)*-v[Use verbose output]' \
'(-q --quiet)*--verbose[Use verbose output]' \
'(--color)--no-color[Disable colors]' \
'--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' \
'--no-native-tls[]' \
'--offline[Disable network access]' \
'--no-offline[]' \
'--preview[Whether to enable experimental, preview features]' \
'--no-preview[]' \
'--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' \
'--show-settings[Show the resolved settings for the current command]' \
'--no-progress[Hide all progress outputs]' \
'--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' \
'-h[Display the concise help for this command]' \
'--help[Display the concise help for this command]' \
'-V[Display the uv version]' \
'--version[Display the uv version]' \
":: :_uv_commands" \
"*::: :->uv" \
&& ret=0
    case $state in
    (uv)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:uv-command-$line[1]:"
        case $line[1] in
            (run)
_arguments "${_arguments_options[@]}" : \
'(--all-extras)*--extra=[Include optional dependencies from the extra group name]:EXTRA: ' \
'*--with=[Run with the given packages installed]:WITH: ' \
'*--with-editable=[Run with the given packages installed as editables]:WITH_EDITABLE: ' \
'*--with-requirements=[Run with all packages listed in the given \`requirements.txt\` files]:WITH_REQUIREMENTS: ' \
'-i+[The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL: ' \
'--index-url=[The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL: ' \
'*--extra-index-url=[Extra URLs of package indexes to use, in addition to \`--index-url\`]:EXTRA_INDEX_URL: ' \
'*-f+[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS: ' \
'*--find-links=[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS: ' \
'*-P+[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE: ' \
'*--upgrade-package=[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE: ' \
'*--reinstall-package=[Reinstall a specific package, regardless of whether it'\''s already installed. Implies \`--refresh-package\`]:REINSTALL_PACKAGE: ' \
'--index-strategy=[The strategy to use when resolving against multiple index URLs]:INDEX_STRATEGY:((first-index\:"Only use results from the first index that returns a match for a given package name"
unsafe-first-match\:"Search for every package name across all indexes, exhausting the versions from the first index before moving on to the next"
unsafe-best-match\:"Search for every package name across all indexes, preferring the "best" version found. If a package version is in multiple indexes, only look at the entry for the first index"))' \
'--keyring-provider=[Attempt to use \`keyring\` for authentication for index URLs]:KEYRING_PROVIDER:((disabled\:"Do not use keyring for credential lookup"
subprocess\:"Use the \`keyring\` command for credential lookup"))' \
'*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST: ' \
'--resolution=[The strategy to use when selecting between the different compatible versions for a given package requirement]:RESOLUTION:((highest\:"Resolve the highest compatible version of each package"
lowest\:"Resolve the lowest compatible version of each package"
lowest-direct\:"Resolve the lowest compatible version of any direct dependencies, and the highest compatible version of any transitive dependencies"))' \
'--prerelease=[The strategy to use when considering pre-release versions]:PRERELEASE:((disallow\:"Disallow all pre-release versions"
allow\:"Allow all pre-release versions"
if-necessary\:"Allow pre-release versions if all versions of a package are pre-release"
explicit\:"Allow pre-release versions for first-party packages with explicit pre-release markers in their version requirements"
if-necessary-or-explicit\:"Allow pre-release versions if all versions of a package are pre-release, or if the package has an explicit pre-release marker in its version requirements"))' \
'*-C+[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING: ' \
'*--config-setting=[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING: ' \
'*--no-build-isolation-package=[Disable isolation when building source distributions for a specific package]:NO_BUILD_ISOLATION_PACKAGE: ' \
'--exclude-newer=[Limit candidate packages to those that were uploaded prior to the given date]:EXCLUDE_NEWER: ' \
'--link-mode=[The method to use when installing packages from the global cache]:LINK_MODE:((clone\:"Clone (i.e., copy-on-write) packages from the wheel into the \`site-packages\` directory"
copy\:"Copy packages from the wheel into the \`site-packages\` directory"
hardlink\:"Hard link packages from the wheel into the \`site-packages\` directory"
symlink\:"Symbolically link packages from the wheel into the \`site-packages\` directory"))' \
'*--no-build-package=[Don'\''t build source distributions for a specific package]:NO_BUILD_PACKAGE: ' \
'*--no-binary-package=[Don'\''t install pre-built wheels for a specific package]:NO_BINARY_PACKAGE: ' \
'*--refresh-package=[Refresh cached data for a specific package]:REFRESH_PACKAGE: ' \
'--package=[Run the command in a specific package in the workspace]:PACKAGE: ' \
'-p+[The Python interpreter to use for the run environment.]:PYTHON: ' \
'--python=[The Python interpreter to use for the run environment.]:PYTHON: ' \
'--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' \
'--python-preference=[Whether to prefer uv-managed or system Python installations]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' \
'--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' \
'(--no-color)--color=[Control colors in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' \
'--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' \
'--project=[Run the command within the given project directory]:PROJECT:_files' \
'--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' \
'(--extra)--all-extras[Include all optional dependencies]' \
'--no-all-extras[]' \
'--dev[Include development dependencies]' \
'--no-dev[Omit development dependencies]' \
'-m[Run a Python module]' \
'--module[Run a Python module]' \
'(--no-dev)--only-dev[Omit non-development dependencies]' \
'--no-editable[Install any editable dependencies, including the project and any workspace members, as non-editable]' \
'--isolated[Run the command in an isolated virtual environment]' \
'(--frozen)--no-sync[Avoid syncing the virtual environment]' \
'(--frozen)--locked[Assert that the \`uv.lock\` will remain unchanged]' \
'(--locked)--frozen[Run without updating the \`uv.lock\` file]' \
'--no-index[Ignore the registry index (e.g., PyPI), instead relying on direct URL dependencies and those provided via \`--find-links\`]' \
'-U[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' \
'--upgrade[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' \
'--no-upgrade[]' \
'--reinstall[Reinstall all packages, regardless of whether they'\''re already installed. Implies \`--refresh\`]' \
'--no-reinstall[]' \
'--pre[]' \
'--no-build-isolation[Disable isolation when building source distributions]' \
'--build-isolation[]' \
'--compile-bytecode[Compile Python files to bytecode after installation]' \
'--no-compile-bytecode[]' \
'--no-sources[Ignore the \`tool.uv.sources\` table when resolving dependencies. Used to lock against the standards-compliant, publishable package metadata, as opposed to using any local or Git sources]' \
'--no-build[Don'\''t build source distributions]' \
'--build[]' \
'--no-binary[Don'\''t install pre-built wheels]' \
'--binary[]' \
'(--offline)--refresh[Refresh all cached data]' \
'(--offline)--no-refresh[]' \
'(--package)--no-project[Avoid discovering the project or workspace]' \
'--show-resolution[Whether to show resolver and installer output from any environment modifications]' \
'-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' \
'--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' \
'(-v --verbose)-q[Do not print any output]' \
'(-v --verbose)--quiet[Do not print any output]' \
'(-q --quiet)*-v[Use verbose output]' \
'(-q --quiet)*--verbose[Use verbose output]' \
'(--color)--no-color[Disable colors]' \
'--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' \
'--no-native-tls[]' \
'--offline[Disable network access]' \
'--no-offline[]' \
'--preview[Whether to enable experimental, preview features]' \
'--no-preview[]' \
'--show-settings[Show the resolved settings for the current command]' \
'--no-progress[Hide all progress outputs]' \
'--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' \
'-h[Display the concise help for this command]' \
'--help[Display the concise help for this command]' \
'-V[Display the uv version]' \
'--version[Display the uv version]' \
&& ret=0
;;
(init)
_arguments "${_arguments_options[@]}" : \
'(--script)--name=[The name of the project]:NAME: ' \
'(--script)--vcs=[Initialize a version control system for the project]:VCS:((git\:"Use Git for version control"
none\:"Do not use any version control system"))' \
'-p+[The Python interpreter to use to determine the minimum supported Python version.]:PYTHON: ' \
'--python=[The Python interpreter to use to determine the minimum supported Python version.]:PYTHON: ' \
'--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' \
'--python-preference=[Whether to prefer uv-managed or system Python installations]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' \
'--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' \
'(--no-color)--color=[Control colors in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' \
'--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' \
'--project=[Run the command within the given project directory]:PROJECT:_files' \
'--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' \
'(--package)--virtual[Create a virtual project, rather than a package]' \
'--package[Set up the project to be built as a Python package]' \
'(--lib)--no-package[Do not set up the project to be built as a Python package]' \
'(--lib --script)--app[Create a project for an application]' \
'(--app --script)--lib[Create a project for a library]' \
'(--app --lib --package)--script[Create a script]' \
'--no-readme[Do not create a \`README.md\` file]' \
'--no-pin-python[Do not create a \`.python-version\` file for the project]' \
'--no-workspace[Avoid discovering a workspace and create a standalone project]' \
'-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' \
'--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' \
'(-v --verbose)-q[Do not print any output]' \
'(-v --verbose)--quiet[Do not print any output]' \
'(-q --quiet)*-v[Use verbose output]' \
'(-q --quiet)*--verbose[Use verbose output]' \
'(--color)--no-color[Disable colors]' \
'--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' \
'--no-native-tls[]' \
'--offline[Disable network access]' \
'--no-offline[]' \
'--preview[Whether to enable experimental, preview features]' \
'--no-preview[]' \
'--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' \
'--show-settings[Show the resolved settings for the current command]' \
'--no-progress[Hide all progress outputs]' \
'--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' \
'-h[Display the concise help for this command]' \
'--help[Display the concise help for this command]' \
'-V[Display the uv version]' \
'--version[Display the uv version]' \
'::path -- The path to use for the project/script:_files' \
&& ret=0
;;
(add)
_arguments "${_arguments_options[@]}" : \
'*-r+[Add all packages listed in the given \`requirements.txt\` files]:REQUIREMENTS:_files' \
'*--requirements=[Add all packages listed in the given \`requirements.txt\` files]:REQUIREMENTS:_files' \
'(--dev)--optional=[Add the requirements to the specified optional dependency group]:OPTIONAL: ' \
'--rev=[Commit to use when adding a dependency from Git]:REV: ' \
'--tag=[Tag to use when adding a dependency from Git]:TAG: ' \
'--branch=[Branch to use when adding a dependency from Git]:BRANCH: ' \
'*--extra=[Extras to enable for the dependency]:EXTRA: ' \
'-i+[The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL: ' \
'--index-url=[The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL: ' \
'*--extra-index-url=[Extra URLs of package indexes to use, in addition to \`--index-url\`]:EXTRA_INDEX_URL: ' \
'*-f+[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS: ' \
'*--find-links=[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS: ' \
'*-P+[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE: ' \
'*--upgrade-package=[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE: ' \
'*--reinstall-package=[Reinstall a specific package, regardless of whether it'\''s already installed. Implies \`--refresh-package\`]:REINSTALL_PACKAGE: ' \
'--index-strategy=[The strategy to use when resolving against multiple index URLs]:INDEX_STRATEGY:((first-index\:"Only use results from the first index that returns a match for a given package name"
unsafe-first-match\:"Search for every package name across all indexes, exhausting the versions from the first index before moving on to the next"
unsafe-best-match\:"Search for every package name across all indexes, preferring the "best" version found. If a package version is in multiple indexes, only look at the entry for the first index"))' \
'--keyring-provider=[Attempt to use \`keyring\` for authentication for index URLs]:KEYRING_PROVIDER:((disabled\:"Do not use keyring for credential lookup"
subprocess\:"Use the \`keyring\` command for credential lookup"))' \
'*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST: ' \
'--resolution=[The strategy to use when selecting between the different compatible versions for a given package requirement]:RESOLUTION:((highest\:"Resolve the highest compatible version of each package"
lowest\:"Resolve the lowest compatible version of each package"
lowest-direct\:"Resolve the lowest compatible version of any direct dependencies, and the highest compatible version of any transitive dependencies"))' \
'--prerelease=[The strategy to use when considering pre-release versions]:PRERELEASE:((disallow\:"Disallow all pre-release versions"
allow\:"Allow all pre-release versions"
if-necessary\:"Allow pre-release versions if all versions of a package are pre-release"
explicit\:"Allow pre-release versions for first-party packages with explicit pre-release markers in their version requirements"
if-necessary-or-explicit\:"Allow pre-release versions if all versions of a package are pre-release, or if the package has an explicit pre-release marker in its version requirements"))' \
'*-C+[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING: ' \
'*--config-setting=[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING: ' \
'*--no-build-isolation-package=[Disable isolation when building source distributions for a specific package]:NO_BUILD_ISOLATION_PACKAGE: ' \
'--exclude-newer=[Limit candidate packages to those that were uploaded prior to the given date]:EXCLUDE_NEWER: ' \
'--link-mode=[The method to use when installing packages from the global cache]:LINK_MODE:((clone\:"Clone (i.e., copy-on-write) packages from the wheel into the \`site-packages\` directory"
copy\:"Copy packages from the wheel into the \`site-packages\` directory"
hardlink\:"Hard link packages from the wheel into the \`site-packages\` directory"
symlink\:"Symbolically link packages from the wheel into the \`site-packages\` directory"))' \
'*--no-build-package=[Don'\''t build source distributions for a specific package]:NO_BUILD_PACKAGE: ' \
'*--no-binary-package=[Don'\''t install pre-built wheels for a specific package]:NO_BINARY_PACKAGE: ' \
'*--refresh-package=[Refresh cached data for a specific package]:REFRESH_PACKAGE: ' \
'(--isolated)--package=[Add the dependency to a specific package in the workspace]:PACKAGE: ' \
'(--dev --optional)--script=[Add the dependency to the specified Python script, rather than to a project]:SCRIPT:_files' \
'-p+[The Python interpreter to use for resolving and syncing.]:PYTHON: ' \
'--python=[The Python interpreter to use for resolving and syncing.]:PYTHON: ' \
'--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' \
'--python-preference=[Whether to prefer uv-managed or system Python installations]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' \
'--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' \
'(--no-color)--color=[Control colors in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' \
'--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' \
'--project=[Run the command within the given project directory]:PROJECT:_files' \
'--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' \
'(--optional)--dev[Add the requirements as development dependencies]' \
'--editable[Add the requirements as editable]' \
'--no-editable[]' \
'(--editable --no-editable --rev --tag --branch)--raw-sources[Add source requirements to \`project.dependencies\`, rather than \`tool.uv.sources\`]' \
'(--frozen)--no-sync[Avoid syncing the virtual environment]' \
'(--frozen)--locked[Assert that the \`uv.lock\` will remain unchanged]' \
'(--locked)--frozen[Add dependencies without re-locking the project]' \
'--no-index[Ignore the registry index (e.g., PyPI), instead relying on direct URL dependencies and those provided via \`--find-links\`]' \
'-U[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' \
'--upgrade[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' \
'--no-upgrade[]' \
'--reinstall[Reinstall all packages, regardless of whether they'\''re already installed. Implies \`--refresh\`]' \
'--no-reinstall[]' \
'--pre[]' \
'--no-build-isolation[Disable isolation when building source distributions]' \
'--build-isolation[]' \
'--compile-bytecode[Compile Python files to bytecode after installation]' \
'--no-compile-bytecode[]' \
'--no-sources[Ignore the \`tool.uv.sources\` table when resolving dependencies. Used to lock against the standards-compliant, publishable package metadata, as opposed to using any local or Git sources]' \
'--no-build[Don'\''t build source distributions]' \
'--build[]' \
'--no-binary[Don'\''t install pre-built wheels]' \
'--binary[]' \
'(--offline)--refresh[Refresh all cached data]' \
'(--offline)--no-refresh[]' \
'-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' \
'--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' \
'(-v --verbose)-q[Do not print any output]' \
'(-v --verbose)--quiet[Do not print any output]' \
'(-q --quiet)*-v[Use verbose output]' \
'(-q --quiet)*--verbose[Use verbose output]' \
'(--color)--no-color[Disable colors]' \
'--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' \
'--no-native-tls[]' \
'--offline[Disable network access]' \
'--no-offline[]' \
'--preview[Whether to enable experimental, preview features]' \
'--no-preview[]' \
'--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' \
'--show-settings[Show the resolved settings for the current command]' \
'--no-progress[Hide all progress outputs]' \
'--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' \
'-h[Display the concise help for this command]' \
'--help[Display the concise help for this command]' \
'-V[Display the uv version]' \
'--version[Display the uv version]' \
'*::packages -- The packages to add, as PEP 508 requirements (e.g., `ruff==0.5.0`):' \
&& ret=0
;;
(remove)
_arguments "${_arguments_options[@]}" : \
'(--dev)--optional=[Remove the packages from the specified optional dependency group]:OPTIONAL: ' \
'-i+[The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL: ' \
'--index-url=[The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL: ' \
'*--extra-index-url=[Extra URLs of package indexes to use, in addition to \`--index-url\`]:EXTRA_INDEX_URL: ' \
'*-f+[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS: ' \
'*--find-links=[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS: ' \
'*-P+[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE: ' \
'*--upgrade-package=[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE: ' \
'*--reinstall-package=[Reinstall a specific package, regardless of whether it'\''s already installed. Implies \`--refresh-package\`]:REINSTALL_PACKAGE: ' \
'--index-strategy=[The strategy to use when resolving against multiple index URLs]:INDEX_STRATEGY:((first-index\:"Only use results from the first index that returns a match for a given package name"
unsafe-first-match\:"Search for every package name across all indexes, exhausting the versions from the first index before moving on to the next"
unsafe-best-match\:"Search for every package name across all indexes, preferring the "best" version found. If a package version is in multiple indexes, only look at the entry for the first index"))' \
'--keyring-provider=[Attempt to use \`keyring\` for authentication for index URLs]:KEYRING_PROVIDER:((disabled\:"Do not use keyring for credential lookup"
subprocess\:"Use the \`keyring\` command for credential lookup"))' \
'*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST: ' \
'--resolution=[The strategy to use when selecting between the different compatible versions for a given package requirement]:RESOLUTION:((highest\:"Resolve the highest compatible version of each package"
lowest\:"Resolve the lowest compatible version of each package"
lowest-direct\:"Resolve the lowest compatible version of any direct dependencies, and the highest compatible version of any transitive dependencies"))' \
'--prerelease=[The strategy to use when considering pre-release versions]:PRERELEASE:((disallow\:"Disallow all pre-release versions"
allow\:"Allow all pre-release versions"
if-necessary\:"Allow pre-release versions if all versions of a package are pre-release"
explicit\:"Allow pre-release versions for first-party packages with explicit pre-release markers in their version requirements"
if-necessary-or-explicit\:"Allow pre-release versions if all versions of a package are pre-release, or if the package has an explicit pre-release marker in its version requirements"))' \
'*-C+[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING: ' \
'*--config-setting=[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING: ' \
'*--no-build-isolation-package=[Disable isolation when building source distributions for a specific package]:NO_BUILD_ISOLATION_PACKAGE: ' \
'--exclude-newer=[Limit candidate packages to those that were uploaded prior to the given date]:EXCLUDE_NEWER: ' \
'--link-mode=[The method to use when installing packages from the global cache]:LINK_MODE:((clone\:"Clone (i.e., copy-on-write) packages from the wheel into the \`site-packages\` directory"
copy\:"Copy packages from the wheel into the \`site-packages\` directory"
hardlink\:"Hard link packages from the wheel into the \`site-packages\` directory"
symlink\:"Symbolically link packages from the wheel into the \`site-packages\` directory"))' \
'*--no-build-package=[Don'\''t build source distributions for a specific package]:NO_BUILD_PACKAGE: ' \
'*--no-binary-package=[Don'\''t install pre-built wheels for a specific package]:NO_BINARY_PACKAGE: ' \
'*--refresh-package=[Refresh cached data for a specific package]:REFRESH_PACKAGE: ' \
'(--isolated)--package=[Remove the dependencies from a specific package in the workspace]:PACKAGE: ' \
'--script=[Remove the dependency from the specified Python script, rather than from a project]:SCRIPT:_files' \
'-p+[The Python interpreter to use for resolving and syncing.]:PYTHON: ' \
'--python=[The Python interpreter to use for resolving and syncing.]:PYTHON: ' \
'--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' \
'--python-preference=[Whether to prefer uv-managed or system Python installations]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' \
'--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' \
'(--no-color)--color=[Control colors in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' \
'--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' \
'--project=[Run the command within the given project directory]:PROJECT:_files' \
'--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' \
'(--optional)--dev[Remove the packages from the development dependencies]' \
'(--frozen)--no-sync[Avoid syncing the virtual environment after re-locking the project]' \
'(--frozen)--locked[Assert that the \`uv.lock\` will remain unchanged]' \
'(--locked)--frozen[Remove dependencies without re-locking the project]' \
'--no-index[Ignore the registry index (e.g., PyPI), instead relying on direct URL dependencies and those provided via \`--find-links\`]' \
'-U[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' \
'--upgrade[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' \
'--no-upgrade[]' \
'--reinstall[Reinstall all packages, regardless of whether they'\''re already installed. Implies \`--refresh\`]' \
'--no-reinstall[]' \
'--pre[]' \
'--no-build-isolation[Disable isolation when building source distributions]' \
'--build-isolation[]' \
'--compile-bytecode[Compile Python files to bytecode after installation]' \
'--no-compile-bytecode[]' \
'--no-sources[Ignore the \`tool.uv.sources\` table when resolving dependencies. Used to lock against the standards-compliant, publishable package metadata, as opposed to using any local or Git sources]' \
'--no-build[Don'\''t build source distributions]' \
'--build[]' \
'--no-binary[Don'\''t install pre-built wheels]' \
'--binary[]' \
'(--offline)--refresh[Refresh all cached data]' \
'(--offline)--no-refresh[]' \
'-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' \
'--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' \
'(-v --verbose)-q[Do not print any output]' \
'(-v --verbose)--quiet[Do not print any output]' \
'(-q --quiet)*-v[Use verbose output]' \
'(-q --quiet)*--verbose[Use verbose output]' \
'(--color)--no-color[Disable colors]' \
'--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' \
'--no-native-tls[]' \
'--offline[Disable network access]' \
'--no-offline[]' \
'--preview[Whether to enable experimental, preview features]' \
'--no-preview[]' \
'--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' \
'--show-settings[Show the resolved settings for the current command]' \
'--no-progress[Hide all progress outputs]' \
'--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' \
'-h[Display the concise help for this command]' \
'--help[Display the concise help for this command]' \
'-V[Display the uv version]' \
'--version[Display the uv version]' \
'*::packages -- The names of the dependencies to remove (e.g., `ruff`):' \
&& ret=0
;;
(sync)
_arguments "${_arguments_options[@]}" : \
'(--all-extras)*--extra=[Include optional dependencies from the extra group name]:EXTRA: ' \
'*--no-install-package=[Do not install the given package(s)]:NO_INSTALL_PACKAGE: ' \
'-i+[The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL: ' \
'--index-url=[The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL: ' \
'*--extra-index-url=[Extra URLs of package indexes to use, in addition to \`--index-url\`]:EXTRA_INDEX_URL: ' \
'*-f+[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS: ' \
'*--find-links=[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS: ' \
'*-P+[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE: ' \
'*--upgrade-package=[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE: ' \
'*--reinstall-package=[Reinstall a specific package, regardless of whether it'\''s already installed. Implies \`--refresh-package\`]:REINSTALL_PACKAGE: ' \
'--index-strategy=[The strategy to use when resolving against multiple index URLs]:INDEX_STRATEGY:((first-index\:"Only use results from the first index that returns a match for a given package name"
unsafe-first-match\:"Search for every package name across all indexes, exhausting the versions from the first index before moving on to the next"
unsafe-best-match\:"Search for every package name across all indexes, preferring the "best" version found. If a package version is in multiple indexes, only look at the entry for the first index"))' \
'--keyring-provider=[Attempt to use \`keyring\` for authentication for index URLs]:KEYRING_PROVIDER:((disabled\:"Do not use keyring for credential lookup"
subprocess\:"Use the \`keyring\` command for credential lookup"))' \
'*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST: ' \
'--resolution=[The strategy to use when selecting between the different compatible versions for a given package requirement]:RESOLUTION:((highest\:"Resolve the highest compatible version of each package"
lowest\:"Resolve the lowest compatible version of each package"
lowest-direct\:"Resolve the lowest compatible version of any direct dependencies, and the highest compatible version of any transitive dependencies"))' \
'--prerelease=[The strategy to use when considering pre-release versions]:PRERELEASE:((disallow\:"Disallow all pre-release versions"
allow\:"Allow all pre-release versions"
if-necessary\:"Allow pre-release versions if all versions of a package are pre-release"
explicit\:"Allow pre-release versions for first-party packages with explicit pre-release markers in their version requirements"
if-necessary-or-explicit\:"Allow pre-release versions if all versions of a package are pre-release, or if the package has an explicit pre-release marker in its version requirements"))' \
'*-C+[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING: ' \
'*--config-setting=[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING: ' \
'*--no-build-isolation-package=[Disable isolation when building source distributions for a specific package]:NO_BUILD_ISOLATION_PACKAGE: ' \
'--exclude-newer=[Limit candidate packages to those that were uploaded prior to the given date]:EXCLUDE_NEWER: ' \
'--link-mode=[The method to use when installing packages from the global cache]:LINK_MODE:((clone\:"Clone (i.e., copy-on-write) packages from the wheel into the \`site-packages\` directory"
copy\:"Copy packages from the wheel into the \`site-packages\` directory"
hardlink\:"Hard link packages from the wheel into the \`site-packages\` directory"
symlink\:"Symbolically link packages from the wheel into the \`site-packages\` directory"))' \
'*--no-build-package=[Don'\''t build source distributions for a specific package]:NO_BUILD_PACKAGE: ' \
'*--no-binary-package=[Don'\''t install pre-built wheels for a specific package]:NO_BINARY_PACKAGE: ' \
'*--refresh-package=[Refresh cached data for a specific package]:REFRESH_PACKAGE: ' \
'--package=[Sync for a specific package in the workspace]:PACKAGE: ' \
'-p+[The Python interpreter to use for the project environment.]:PYTHON: ' \
'--python=[The Python interpreter to use for the project environment.]:PYTHON: ' \
'--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' \
'--python-preference=[Whether to prefer uv-managed or system Python installations]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' \
'--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' \
'(--no-color)--color=[Control colors in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' \
'--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' \
'--project=[Run the command within the given project directory]:PROJECT:_files' \
'--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' \
'(--extra)--all-extras[Include all optional dependencies]' \
'--no-all-extras[]' \
'--dev[Include development dependencies]' \
'--no-dev[Omit development dependencies]' \
'(--no-dev)--only-dev[Omit non-development dependencies]' \
'--no-editable[Install any editable dependencies, including the project and any workspace members, as non-editable]' \
'--inexact[Do not remove extraneous packages present in the environment]' \
'--exact[Perform an exact sync, removing extraneous packages]' \
'--no-install-project[Do not install the current project]' \
'--no-install-workspace[Do not install any workspace members, including the root project]' \
'(--frozen)--locked[Assert that the \`uv.lock\` will remain unchanged]' \
'(--locked)--frozen[Sync without updating the \`uv.lock\` file]' \
'--no-index[Ignore the registry index (e.g., PyPI), instead relying on direct URL dependencies and those provided via \`--find-links\`]' \
'-U[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' \
'--upgrade[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' \
'--no-upgrade[]' \
'--reinstall[Reinstall all packages, regardless of whether they'\''re already installed. Implies \`--refresh\`]' \
'--no-reinstall[]' \
'--pre[]' \
'--no-build-isolation[Disable isolation when building source distributions]' \
'--build-isolation[]' \
'--compile-bytecode[Compile Python files to bytecode after installation]' \
'--no-compile-bytecode[]' \
'--no-sources[Ignore the \`tool.uv.sources\` table when resolving dependencies. Used to lock against the standards-compliant, publishable package metadata, as opposed to using any local or Git sources]' \
'--no-build[Don'\''t build source distributions]' \
'--build[]' \
'--no-binary[Don'\''t install pre-built wheels]' \
'--binary[]' \
'(--offline)--refresh[Refresh all cached data]' \
'(--offline)--no-refresh[]' \
'-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' \
'--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' \
'(-v --verbose)-q[Do not print any output]' \
'(-v --verbose)--quiet[Do not print any output]' \
'(-q --quiet)*-v[Use verbose output]' \
'(-q --quiet)*--verbose[Use verbose output]' \
'(--color)--no-color[Disable colors]' \
'--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' \
'--no-native-tls[]' \
'--offline[Disable network access]' \
'--no-offline[]' \
'--preview[Whether to enable experimental, preview features]' \
'--no-preview[]' \
'--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' \
'--show-settings[Show the resolved settings for the current command]' \
'--no-progress[Hide all progress outputs]' \
'--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' \
'-h[Display the concise help for this command]' \
'--help[Display the concise help for this command]' \
'-V[Display the uv version]' \
'--version[Display the uv version]' \
&& ret=0
;;
(lock)
_arguments "${_arguments_options[@]}" : \
'-i+[The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL: ' \
'--index-url=[The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL: ' \
'*--extra-index-url=[Extra URLs of package indexes to use, in addition to \`--index-url\`]:EXTRA_INDEX_URL: ' \
'*-f+[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS: ' \
'*--find-links=[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS: ' \
'*-P+[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE: ' \
'*--upgrade-package=[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE: ' \
'--index-strategy=[The strategy to use when resolving against multiple index URLs]:INDEX_STRATEGY:((first-index\:"Only use results from the first index that returns a match for a given package name"
unsafe-first-match\:"Search for every package name across all indexes, exhausting the versions from the first index before moving on to the next"
unsafe-best-match\:"Search for every package name across all indexes, preferring the "best" version found. If a package version is in multiple indexes, only look at the entry for the first index"))' \
'--keyring-provider=[Attempt to use \`keyring\` for authentication for index URLs]:KEYRING_PROVIDER:((disabled\:"Do not use keyring for credential lookup"
subprocess\:"Use the \`keyring\` command for credential lookup"))' \
'*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST: ' \
'--resolution=[The strategy to use when selecting between the different compatible versions for a given package requirement]:RESOLUTION:((highest\:"Resolve the highest compatible version of each package"
lowest\:"Resolve the lowest compatible version of each package"
lowest-direct\:"Resolve the lowest compatible version of any direct dependencies, and the highest compatible version of any transitive dependencies"))' \
'--prerelease=[The strategy to use when considering pre-release versions]:PRERELEASE:((disallow\:"Disallow all pre-release versions"
allow\:"Allow all pre-release versions"
if-necessary\:"Allow pre-release versions if all versions of a package are pre-release"
explicit\:"Allow pre-release versions for first-party packages with explicit pre-release markers in their version requirements"
if-necessary-or-explicit\:"Allow pre-release versions if all versions of a package are pre-release, or if the package has an explicit pre-release marker in its version requirements"))' \
'*-C+[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING: ' \
'*--config-setting=[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING: ' \
'*--no-build-isolation-package=[Disable isolation when building source distributions for a specific package]:NO_BUILD_ISOLATION_PACKAGE: ' \
'--exclude-newer=[Limit candidate packages to those that were uploaded prior to the given date]:EXCLUDE_NEWER: ' \
'--link-mode=[The method to use when installing packages from the global cache]:LINK_MODE:((clone\:"Clone (i.e., copy-on-write) packages from the wheel into the \`site-packages\` directory"
copy\:"Copy packages from the wheel into the \`site-packages\` directory"
hardlink\:"Hard link packages from the wheel into the \`site-packages\` directory"
symlink\:"Symbolically link packages from the wheel into the \`site-packages\` directory"))' \
'*--no-build-package=[Don'\''t build source distributions for a specific package]:NO_BUILD_PACKAGE: ' \
'*--no-binary-package=[Don'\''t install pre-built wheels for a specific package]:NO_BINARY_PACKAGE: ' \
'*--refresh-package=[Refresh cached data for a specific package]:REFRESH_PACKAGE: ' \
'-p+[The Python interpreter to use during resolution.]:PYTHON: ' \
'--python=[The Python interpreter to use during resolution.]:PYTHON: ' \
'--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' \
'--python-preference=[Whether to prefer uv-managed or system Python installations]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' \
'--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' \
'(--no-color)--color=[Control colors in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' \
'--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' \
'--project=[Run the command within the given project directory]:PROJECT:_files' \
'--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' \
'(--frozen)--locked[Assert that the \`uv.lock\` will remain unchanged]' \
'(--locked)--frozen[Assert that a \`uv.lock\` exists, without updating it]' \
'--no-index[Ignore the registry index (e.g., PyPI), instead relying on direct URL dependencies and those provided via \`--find-links\`]' \
'-U[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' \
'--upgrade[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' \
'--no-upgrade[]' \
'--pre[]' \
'--no-build-isolation[Disable isolation when building source distributions]' \
'--build-isolation[]' \
'--no-sources[Ignore the \`tool.uv.sources\` table when resolving dependencies. Used to lock against the standards-compliant, publishable package metadata, as opposed to using any local or Git sources]' \
'--no-build[Don'\''t build source distributions]' \
'--build[]' \
'--no-binary[Don'\''t install pre-built wheels]' \
'--binary[]' \
'(--offline)--refresh[Refresh all cached data]' \
'(--offline)--no-refresh[]' \
'-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' \
'--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' \
'(-v --verbose)-q[Do not print any output]' \
'(-v --verbose)--quiet[Do not print any output]' \
'(-q --quiet)*-v[Use verbose output]' \
'(-q --quiet)*--verbose[Use verbose output]' \
'(--color)--no-color[Disable colors]' \
'--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' \
'--no-native-tls[]' \
'--offline[Disable network access]' \
'--no-offline[]' \
'--preview[Whether to enable experimental, preview features]' \
'--no-preview[]' \
'--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' \
'--show-settings[Show the resolved settings for the current command]' \
'--no-progress[Hide all progress outputs]' \
'--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' \
'-h[Display the concise help for this command]' \
'--help[Display the concise help for this command]' \
'-V[Display the uv version]' \
'--version[Display the uv version]' \
&& ret=0
;;
(export)
_arguments "${_arguments_options[@]}" : \
'--format=[The format to which \`uv.lock\` should be exported]:FORMAT:((requirements-txt\:"Export in \`requirements.txt\` format"))' \
'--package=[Export the dependencies for a specific package in the workspace]:PACKAGE: ' \
'(--all-extras)*--extra=[Include optional dependencies from the extra group name]:EXTRA: ' \
'-o+[Write the exported requirements to the given file]:OUTPUT_FILE:_files' \
'--output-file=[Write the exported requirements to the given file]:OUTPUT_FILE:_files' \
'*--no-emit-package=[Do not emit the given package(s)]:NO_EMIT_PACKAGE: ' \
'-i+[The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL: ' \
'--index-url=[The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL: ' \
'*--extra-index-url=[Extra URLs of package indexes to use, in addition to \`--index-url\`]:EXTRA_INDEX_URL: ' \
'*-f+[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS: ' \
'*--find-links=[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS: ' \
'*-P+[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE: ' \
'*--upgrade-package=[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE: ' \
'--index-strategy=[The strategy to use when resolving against multiple index URLs]:INDEX_STRATEGY:((first-index\:"Only use results from the first index that returns a match for a given package name"
unsafe-first-match\:"Search for every package name across all indexes, exhausting the versions from the first index before moving on to the next"
unsafe-best-match\:"Search for every package name across all indexes, preferring the "best" version found. If a package version is in multiple indexes, only look at the entry for the first index"))' \
'--keyring-provider=[Attempt to use \`keyring\` for authentication for index URLs]:KEYRING_PROVIDER:((disabled\:"Do not use keyring for credential lookup"
subprocess\:"Use the \`keyring\` command for credential lookup"))' \
'*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST: ' \
'--resolution=[The strategy to use when selecting between the different compatible versions for a given package requirement]:RESOLUTION:((highest\:"Resolve the highest compatible version of each package"
lowest\:"Resolve the lowest compatible version of each package"
lowest-direct\:"Resolve the lowest compatible version of any direct dependencies, and the highest compatible version of any transitive dependencies"))' \
'--prerelease=[The strategy to use when considering pre-release versions]:PRERELEASE:((disallow\:"Disallow all pre-release versions"
allow\:"Allow all pre-release versions"
if-necessary\:"Allow pre-release versions if all versions of a package are pre-release"
explicit\:"Allow pre-release versions for first-party packages with explicit pre-release markers in their version requirements"
if-necessary-or-explicit\:"Allow pre-release versions if all versions of a package are pre-release, or if the package has an explicit pre-release marker in its version requirements"))' \
'*-C+[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING: ' \
'*--config-setting=[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING: ' \
'*--no-build-isolation-package=[Disable isolation when building source distributions for a specific package]:NO_BUILD_ISOLATION_PACKAGE: ' \
'--exclude-newer=[Limit candidate packages to those that were uploaded prior to the given date]:EXCLUDE_NEWER: ' \
'--link-mode=[The method to use when installing packages from the global cache]:LINK_MODE:((clone\:"Clone (i.e., copy-on-write) packages from the wheel into the \`site-packages\` directory"
copy\:"Copy packages from the wheel into the \`site-packages\` directory"
hardlink\:"Hard link packages from the wheel into the \`site-packages\` directory"
symlink\:"Symbolically link packages from the wheel into the \`site-packages\` directory"))' \
'*--no-build-package=[Don'\''t build source distributions for a specific package]:NO_BUILD_PACKAGE: ' \
'*--no-binary-package=[Don'\''t install pre-built wheels for a specific package]:NO_BINARY_PACKAGE: ' \
'*--refresh-package=[Refresh cached data for a specific package]:REFRESH_PACKAGE: ' \
'-p+[The Python interpreter to use during resolution.]:PYTHON: ' \
'--python=[The Python interpreter to use during resolution.]:PYTHON: ' \
'--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' \
'--python-preference=[Whether to prefer uv-managed or system Python installations]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' \
'--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' \
'(--no-color)--color=[Control colors in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' \
'--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' \
'--project=[Run the command within the given project directory]:PROJECT:_files' \
'--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' \
'(--extra)--all-extras[Include all optional dependencies]' \
'--no-all-extras[]' \
'--dev[Include development dependencies]' \
'--no-dev[Omit development dependencies]' \
'(--no-dev)--only-dev[Omit non-development dependencies]' \
'--no-editable[Install any editable dependencies, including the project and any workspace members, as non-editable]' \
'--hashes[Include hashes for all dependencies]' \
'--no-hashes[Omit hashes in the generated output]' \
'--no-emit-project[Do not emit the current project]' \
'--no-emit-workspace[Do not emit any workspace members, including the root project]' \
'(--frozen)--locked[Assert that the \`uv.lock\` will remain unchanged]' \
'(--locked)--frozen[Do not update the \`uv.lock\` before exporting]' \
'--no-index[Ignore the registry index (e.g., PyPI), instead relying on direct URL dependencies and those provided via \`--find-links\`]' \
'-U[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' \
'--upgrade[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' \
'--no-upgrade[]' \
'--pre[]' \
'--no-build-isolation[Disable isolation when building source distributions]' \
'--build-isolation[]' \
'--no-sources[Ignore the \`tool.uv.sources\` table when resolving dependencies. Used to lock against the standards-compliant, publishable package metadata, as opposed to using any local or Git sources]' \
'--no-build[Don'\''t build source distributions]' \
'--build[]' \
'--no-binary[Don'\''t install pre-built wheels]' \
'--binary[]' \
'(--offline)--refresh[Refresh all cached data]' \
'(--offline)--no-refresh[]' \
'-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' \
'--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' \
'(-v --verbose)-q[Do not print any output]' \
'(-v --verbose)--quiet[Do not print any output]' \
'(-q --quiet)*-v[Use verbose output]' \
'(-q --quiet)*--verbose[Use verbose output]' \
'(--color)--no-color[Disable colors]' \
'--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' \
'--no-native-tls[]' \
'--offline[Disable network access]' \
'--no-offline[]' \
'--preview[Whether to enable experimental, preview features]' \
'--no-preview[]' \
'--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' \
'--show-settings[Show the resolved settings for the current command]' \
'--no-progress[Hide all progress outputs]' \
'--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' \
'-h[Display the concise help for this command]' \
'--help[Display the concise help for this command]' \
'-V[Display the uv version]' \
'--version[Display the uv version]' \
&& ret=0
;;
(tree)
_arguments "${_arguments_options[@]}" : \
'-d+[Maximum display depth of the dependency tree]:DEPTH: ' \
'--depth=[Maximum display depth of the dependency tree]:DEPTH: ' \
'*--prune=[Prune the given package from the display of the dependency tree]:PRUNE: ' \
'*--package=[Display only the specified packages]:PACKAGE: ' \
'*--no-build-package=[Don'\''t build source distributions for a specific package]:NO_BUILD_PACKAGE: ' \
'*--no-binary-package=[Don'\''t install pre-built wheels for a specific package]:NO_BINARY_PACKAGE: ' \
'-i+[The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL: ' \
'--index-url=[The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL: ' \
'*--extra-index-url=[Extra URLs of package indexes to use, in addition to \`--index-url\`]:EXTRA_INDEX_URL: ' \
'*-f+[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS: ' \
'*--find-links=[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS: ' \
'*-P+[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE: ' \
'*--upgrade-package=[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE: ' \
'--index-strategy=[The strategy to use when resolving against multiple index URLs]:INDEX_STRATEGY:((first-index\:"Only use results from the first index that returns a match for a given package name"
unsafe-first-match\:"Search for every package name across all indexes, exhausting the versions from the first index before moving on to the next"
unsafe-best-match\:"Search for every package name across all indexes, preferring the "best" version found. If a package version is in multiple indexes, only look at the entry for the first index"))' \
'--keyring-provider=[Attempt to use \`keyring\` for authentication for index URLs]:KEYRING_PROVIDER:((disabled\:"Do not use keyring for credential lookup"
subprocess\:"Use the \`keyring\` command for credential lookup"))' \
'*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST: ' \
'--resolution=[The strategy to use when selecting between the different compatible versions for a given package requirement]:RESOLUTION:((highest\:"Resolve the highest compatible version of each package"
lowest\:"Resolve the lowest compatible version of each package"
lowest-direct\:"Resolve the lowest compatible version of any direct dependencies, and the highest compatible version of any transitive dependencies"))' \
'--prerelease=[The strategy to use when considering pre-release versions]:PRERELEASE:((disallow\:"Disallow all pre-release versions"
allow\:"Allow all pre-release versions"
if-necessary\:"Allow pre-release versions if all versions of a package are pre-release"
explicit\:"Allow pre-release versions for first-party packages with explicit pre-release markers in their version requirements"
if-necessary-or-explicit\:"Allow pre-release versions if all versions of a package are pre-release, or if the package has an explicit pre-release marker in its version requirements"))' \
'*-C+[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING: ' \
'*--config-setting=[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING: ' \
'*--no-build-isolation-package=[Disable isolation when building source distributions for a specific package]:NO_BUILD_ISOLATION_PACKAGE: ' \
'--exclude-newer=[Limit candidate packages to those that were uploaded prior to the given date]:EXCLUDE_NEWER: ' \
'--link-mode=[The method to use when installing packages from the global cache]:LINK_MODE:((clone\:"Clone (i.e., copy-on-write) packages from the wheel into the \`site-packages\` directory"
copy\:"Copy packages from the wheel into the \`site-packages\` directory"
hardlink\:"Hard link packages from the wheel into the \`site-packages\` directory"
symlink\:"Symbolically link packages from the wheel into the \`site-packages\` directory"))' \
'(--universal)--python-version=[The Python version to use when filtering the tree]:PYTHON_VERSION: ' \
'(--universal)--python-platform=[The platform to use when filtering the tree]:PYTHON_PLATFORM:((windows\:"An alias for \`x86_64-pc-windows-msvc\`, the default target for Windows"
linux\:"An alias for \`x86_64-unknown-linux-gnu\`, the default target for Linux"
macos\:"An alias for \`aarch64-apple-darwin\`, the default target for macOS"
x86_64-pc-windows-msvc\:"A 64-bit x86 Windows target"
i686-pc-windows-msvc\:"A 32-bit x86 Windows target"
x86_64-unknown-linux-gnu\:"An x86 Linux target. Equivalent to \`x86_64-manylinux_2_17\`"
aarch64-apple-darwin\:"An ARM-based macOS target, as seen on Apple Silicon devices"
x86_64-apple-darwin\:"An x86 macOS target"
aarch64-unknown-linux-gnu\:"An ARM64 Linux target. Equivalent to \`aarch64-manylinux_2_17\`"
aarch64-unknown-linux-musl\:"An ARM64 Linux target"
x86_64-unknown-linux-musl\:"An \`x86_64\` Linux target"
x86_64-manylinux_2_17\:"An \`x86_64\` target for the \`manylinux_2_17\` platform"
x86_64-manylinux_2_28\:"An \`x86_64\` target for the \`manylinux_2_28\` platform"
x86_64-manylinux_2_31\:"An \`x86_64\` target for the \`manylinux_2_31\` platform"
aarch64-manylinux_2_17\:"An ARM64 target for the \`manylinux_2_17\` platform"
aarch64-manylinux_2_28\:"An ARM64 target for the \`manylinux_2_28\` platform"
aarch64-manylinux_2_31\:"An ARM64 target for the \`manylinux_2_31\` platform"))' \
'-p+[The Python interpreter to use for locking and filtering.]:PYTHON: ' \
'--python=[The Python interpreter to use for locking and filtering.]:PYTHON: ' \
'--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' \
'--python-preference=[Whether to prefer uv-managed or system Python installations]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' \
'--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' \
'(--no-color)--color=[Control colors in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' \
'--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' \
'--project=[Run the command within the given project directory]:PROJECT:_files' \
'--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' \
'--universal[Show a platform-independent dependency tree]' \
'--no-dedupe[Do not de-duplicate repeated dependencies. Usually, when a package has already displayed its dependencies, further occurrences will not re-display its dependencies, and will include a (*) to indicate it has already been shown. This flag will cause those duplicates to be repeated]' \
'--invert[Show the reverse dependencies for the given package. This flag will invert the tree and display the packages that depend on the given package]' \
'(--frozen)--locked[Assert that the \`uv.lock\` will remain unchanged]' \
'(--locked)--frozen[Display the requirements without locking the project]' \
'--no-build[Don'\''t build source distributions]' \
'--build[]' \
'--no-binary[Don'\''t install pre-built wheels]' \
'--binary[]' \
'--no-index[Ignore the registry index (e.g., PyPI), instead relying on direct URL dependencies and those provided via \`--find-links\`]' \
'-U[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' \
'--upgrade[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' \
'--no-upgrade[]' \
'--pre[]' \
'--no-build-isolation[Disable isolation when building source distributions]' \
'--build-isolation[]' \
'--no-sources[Ignore the \`tool.uv.sources\` table when resolving dependencies. Used to lock against the standards-compliant, publishable package metadata, as opposed to using any local or Git sources]' \
'-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' \
'--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' \
'(-v --verbose)-q[Do not print any output]' \
'(-v --verbose)--quiet[Do not print any output]' \
'(-q --quiet)*-v[Use verbose output]' \
'(-q --quiet)*--verbose[Use verbose output]' \
'(--color)--no-color[Disable colors]' \
'--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' \
'--no-native-tls[]' \
'--offline[Disable network access]' \
'--no-offline[]' \
'--preview[Whether to enable experimental, preview features]' \
'--no-preview[]' \
'--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' \
'--show-settings[Show the resolved settings for the current command]' \
'--no-progress[Hide all progress outputs]' \
'--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' \
'-h[Display the concise help for this command]' \
'--help[Display the concise help for this command]' \
'-V[Display the uv version]' \
'--version[Display the uv version]' \
&& ret=0
;;
(tool)
_arguments "${_arguments_options[@]}" : \
'--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' \
'--python-preference=[Whether to prefer uv-managed or system Python installations]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' \
'--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' \
'(--no-color)--color=[Control colors in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' \
'--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' \
'--project=[Run the command within the given project directory]:PROJECT:_files' \
'--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' \
'-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' \
'--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' \
'(-v --verbose)-q[Do not print any output]' \
'(-v --verbose)--quiet[Do not print any output]' \
'(-q --quiet)*-v[Use verbose output]' \
'(-q --quiet)*--verbose[Use verbose output]' \
'(--color)--no-color[Disable colors]' \
'--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' \
'--no-native-tls[]' \
'--offline[Disable network access]' \
'--no-offline[]' \
'--preview[Whether to enable experimental, preview features]' \
'--no-preview[]' \
'--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' \
'--show-settings[Show the resolved settings for the current command]' \
'--no-progress[Hide all progress outputs]' \
'--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' \
'-h[Display the concise help for this command]' \
'--help[Display the concise help for this command]' \
'-V[Display the uv version]' \
'--version[Display the uv version]' \
":: :_uv__tool_commands" \
"*::: :->tool" \
&& ret=0

    case $state in
    (tool)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:uv-tool-command-$line[1]:"
        case $line[1] in
            (run)
_arguments "${_arguments_options[@]}" : \
'--from=[Use the given package to provide the command]:FROM: ' \
'*--with=[Run with the given packages installed]:WITH: ' \
'*--with-editable=[Run with the given packages installed as editables]:WITH_EDITABLE: ' \
'*--with-requirements=[Run with all packages listed in the given \`requirements.txt\` files]:WITH_REQUIREMENTS: ' \
'-i+[The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL: ' \
'--index-url=[The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL: ' \
'*--extra-index-url=[Extra URLs of package indexes to use, in addition to \`--index-url\`]:EXTRA_INDEX_URL: ' \
'*-f+[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS: ' \
'*--find-links=[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS: ' \
'*-P+[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE: ' \
'*--upgrade-package=[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE: ' \
'*--reinstall-package=[Reinstall a specific package, regardless of whether it'\''s already installed. Implies \`--refresh-package\`]:REINSTALL_PACKAGE: ' \
'--index-strategy=[The strategy to use when resolving against multiple index URLs]:INDEX_STRATEGY:((first-index\:"Only use results from the first index that returns a match for a given package name"
unsafe-first-match\:"Search for every package name across all indexes, exhausting the versions from the first index before moving on to the next"
unsafe-best-match\:"Search for every package name across all indexes, preferring the "best" version found. If a package version is in multiple indexes, only look at the entry for the first index"))' \
'--keyring-provider=[Attempt to use \`keyring\` for authentication for index URLs]:KEYRING_PROVIDER:((disabled\:"Do not use keyring for credential lookup"
subprocess\:"Use the \`keyring\` command for credential lookup"))' \
'*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST: ' \
'--resolution=[The strategy to use when selecting between the different compatible versions for a given package requirement]:RESOLUTION:((highest\:"Resolve the highest compatible version of each package"
lowest\:"Resolve the lowest compatible version of each package"
lowest-direct\:"Resolve the lowest compatible version of any direct dependencies, and the highest compatible version of any transitive dependencies"))' \
'--prerelease=[The strategy to use when considering pre-release versions]:PRERELEASE:((disallow\:"Disallow all pre-release versions"
allow\:"Allow all pre-release versions"
if-necessary\:"Allow pre-release versions if all versions of a package are pre-release"
explicit\:"Allow pre-release versions for first-party packages with explicit pre-release markers in their version requirements"
if-necessary-or-explicit\:"Allow pre-release versions if all versions of a package are pre-release, or if the package has an explicit pre-release marker in its version requirements"))' \
'*-C+[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING: ' \
'*--config-setting=[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING: ' \
'*--no-build-isolation-package=[Disable isolation when building source distributions for a specific package]:NO_BUILD_ISOLATION_PACKAGE: ' \
'--exclude-newer=[Limit candidate packages to those that were uploaded prior to the given date]:EXCLUDE_NEWER: ' \
'--link-mode=[The method to use when installing packages from the global cache]:LINK_MODE:((clone\:"Clone (i.e., copy-on-write) packages from the wheel into the \`site-packages\` directory"
copy\:"Copy packages from the wheel into the \`site-packages\` directory"
hardlink\:"Hard link packages from the wheel into the \`site-packages\` directory"
symlink\:"Symbolically link packages from the wheel into the \`site-packages\` directory"))' \
'*--no-build-package=[Don'\''t build source distributions for a specific package]:NO_BUILD_PACKAGE: ' \
'*--no-binary-package=[Don'\''t install pre-built wheels for a specific package]:NO_BINARY_PACKAGE: ' \
'*--refresh-package=[Refresh cached data for a specific package]:REFRESH_PACKAGE: ' \
'-p+[The Python interpreter to use to build the run environment.]:PYTHON: ' \
'--python=[The Python interpreter to use to build the run environment.]:PYTHON: ' \
'--generate-shell-completion=[]:GENERATE_SHELL_COMPLETION:(bash elvish fish nushell powershell zsh)' \
'--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' \
'--python-preference=[Whether to prefer uv-managed or system Python installations]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' \
'--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' \
'(--no-color)--color=[Control colors in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' \
'--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' \
'--project=[Run the command within the given project directory]:PROJECT:_files' \
'--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' \
'--isolated[Run the tool in an isolated virtual environment, ignoring any already-installed tools]' \
'--no-index[Ignore the registry index (e.g., PyPI), instead relying on direct URL dependencies and those provided via \`--find-links\`]' \
'-U[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' \
'--upgrade[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' \
'--no-upgrade[]' \
'--reinstall[Reinstall all packages, regardless of whether they'\''re already installed. Implies \`--refresh\`]' \
'--no-reinstall[]' \
'--pre[]' \
'--no-build-isolation[Disable isolation when building source distributions]' \
'--build-isolation[]' \
'--compile-bytecode[Compile Python files to bytecode after installation]' \
'--no-compile-bytecode[]' \
'--no-sources[Ignore the \`tool.uv.sources\` table when resolving dependencies. Used to lock against the standards-compliant, publishable package metadata, as opposed to using any local or Git sources]' \
'--no-build[Don'\''t build source distributions]' \
'--build[]' \
'--no-binary[Don'\''t install pre-built wheels]' \
'--binary[]' \
'(--offline)--refresh[Refresh all cached data]' \
'(--offline)--no-refresh[]' \
'--show-resolution[Whether to show resolver and installer output from any environment modifications]' \
'-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' \
'--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' \
'(-v --verbose)-q[Do not print any output]' \
'(-v --verbose)--quiet[Do not print any output]' \
'(-q --quiet)*-v[Use verbose output]' \
'(-q --quiet)*--verbose[Use verbose output]' \
'(--color)--no-color[Disable colors]' \
'--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' \
'--no-native-tls[]' \
'--offline[Disable network access]' \
'--no-offline[]' \
'--preview[Whether to enable experimental, preview features]' \
'--no-preview[]' \
'--show-settings[Show the resolved settings for the current command]' \
'--no-progress[Hide all progress outputs]' \
'--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' \
'-h[Display the concise help for this command]' \
'--help[Display the concise help for this command]' \
'-V[Display the uv version]' \
'--version[Display the uv version]' \
&& ret=0
;;
(uvx)
_arguments "${_arguments_options[@]}" : \
'--from=[Use the given package to provide the command]:FROM: ' \
'*--with=[Run with the given packages installed]:WITH: ' \
'*--with-editable=[Run with the given packages installed as editables]:WITH_EDITABLE: ' \
'*--with-requirements=[Run with all packages listed in the given \`requirements.txt\` files]:WITH_REQUIREMENTS: ' \
'-i+[The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL: ' \
'--index-url=[The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL: ' \
'*--extra-index-url=[Extra URLs of package indexes to use, in addition to \`--index-url\`]:EXTRA_INDEX_URL: ' \
'*-f+[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS: ' \
'*--find-links=[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS: ' \
'*-P+[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE: ' \
'*--upgrade-package=[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE: ' \
'*--reinstall-package=[Reinstall a specific package, regardless of whether it'\''s already installed. Implies \`--refresh-package\`]:REINSTALL_PACKAGE: ' \
'--index-strategy=[The strategy to use when resolving against multiple index URLs]:INDEX_STRATEGY:((first-index\:"Only use results from the first index that returns a match for a given package name"
unsafe-first-match\:"Search for every package name across all indexes, exhausting the versions from the first index before moving on to the next"
unsafe-best-match\:"Search for every package name across all indexes, preferring the "best" version found. If a package version is in multiple indexes, only look at the entry for the first index"))' \
'--keyring-provider=[Attempt to use \`keyring\` for authentication for index URLs]:KEYRING_PROVIDER:((disabled\:"Do not use keyring for credential lookup"
subprocess\:"Use the \`keyring\` command for credential lookup"))' \
'*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST: ' \
'--resolution=[The strategy to use when selecting between the different compatible versions for a given package requirement]:RESOLUTION:((highest\:"Resolve the highest compatible version of each package"
lowest\:"Resolve the lowest compatible version of each package"
lowest-direct\:"Resolve the lowest compatible version of any direct dependencies, and the highest compatible version of any transitive dependencies"))' \
'--prerelease=[The strategy to use when considering pre-release versions]:PRERELEASE:((disallow\:"Disallow all pre-release versions"
allow\:"Allow all pre-release versions"
if-necessary\:"Allow pre-release versions if all versions of a package are pre-release"
explicit\:"Allow pre-release versions for first-party packages with explicit pre-release markers in their version requirements"
if-necessary-or-explicit\:"Allow pre-release versions if all versions of a package are pre-release, or if the package has an explicit pre-release marker in its version requirements"))' \
'*-C+[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING: ' \
'*--config-setting=[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING: ' \
'*--no-build-isolation-package=[Disable isolation when building source distributions for a specific package]:NO_BUILD_ISOLATION_PACKAGE: ' \
'--exclude-newer=[Limit candidate packages to those that were uploaded prior to the given date]:EXCLUDE_NEWER: ' \
'--link-mode=[The method to use when installing packages from the global cache]:LINK_MODE:((clone\:"Clone (i.e., copy-on-write) packages from the wheel into the \`site-packages\` directory"
copy\:"Copy packages from the wheel into the \`site-packages\` directory"
hardlink\:"Hard link packages from the wheel into the \`site-packages\` directory"
symlink\:"Symbolically link packages from the wheel into the \`site-packages\` directory"))' \
'*--no-build-package=[Don'\''t build source distributions for a specific package]:NO_BUILD_PACKAGE: ' \
'*--no-binary-package=[Don'\''t install pre-built wheels for a specific package]:NO_BINARY_PACKAGE: ' \
'*--refresh-package=[Refresh cached data for a specific package]:REFRESH_PACKAGE: ' \
'-p+[The Python interpreter to use to build the run environment.]:PYTHON: ' \
'--python=[The Python interpreter to use to build the run environment.]:PYTHON: ' \
'--generate-shell-completion=[]:GENERATE_SHELL_COMPLETION:(bash elvish fish nushell powershell zsh)' \
'--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' \
'--python-preference=[Whether to prefer uv-managed or system Python installations]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' \
'--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' \
'(--no-color)--color=[Control colors in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' \
'--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' \
'--project=[Run the command within the given project directory]:PROJECT:_files' \
'--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' \
'--isolated[Run the tool in an isolated virtual environment, ignoring any already-installed tools]' \
'--no-index[Ignore the registry index (e.g., PyPI), instead relying on direct URL dependencies and those provided via \`--find-links\`]' \
'-U[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' \
'--upgrade[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' \
'--no-upgrade[]' \
'--reinstall[Reinstall all packages, regardless of whether they'\''re already installed. Implies \`--refresh\`]' \
'--no-reinstall[]' \
'--pre[]' \
'--no-build-isolation[Disable isolation when building source distributions]' \
'--build-isolation[]' \
'--compile-bytecode[Compile Python files to bytecode after installation]' \
'--no-compile-bytecode[]' \
'--no-sources[Ignore the \`tool.uv.sources\` table when resolving dependencies. Used to lock against the standards-compliant, publishable package metadata, as opposed to using any local or Git sources]' \
'--no-build[Don'\''t build source distributions]' \
'--build[]' \
'--no-binary[Don'\''t install pre-built wheels]' \
'--binary[]' \
'(--offline)--refresh[Refresh all cached data]' \
'(--offline)--no-refresh[]' \
'--show-resolution[Whether to show resolver and installer output from any environment modifications]' \
'-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' \
'--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' \
'(-v --verbose)-q[Do not print any output]' \
'(-v --verbose)--quiet[Do not print any output]' \
'(-q --quiet)*-v[Use verbose output]' \
'(-q --quiet)*--verbose[Use verbose output]' \
'(--color)--no-color[Disable colors]' \
'--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' \
'--no-native-tls[]' \
'--offline[Disable network access]' \
'--no-offline[]' \
'--preview[Whether to enable experimental, preview features]' \
'--no-preview[]' \
'--show-settings[Show the resolved settings for the current command]' \
'--no-progress[Hide all progress outputs]' \
'--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' \
'-h[Display the concise help for this command]' \
'--help[Display the concise help for this command]' \
'-V[Display the uv version]' \
'--version[Display the uv version]' \
&& ret=0
;;
(install)
_arguments "${_arguments_options[@]}" : \
'--from=[The package to install commands from]:FROM: ' \
'*--with=[Include the following extra requirements]:WITH: ' \
'*--with-requirements=[Run all requirements listed in the given \`requirements.txt\` files]:WITH_REQUIREMENTS: ' \
'-i+[The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL: ' \
'--index-url=[The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL: ' \
'*--extra-index-url=[Extra URLs of package indexes to use, in addition to \`--index-url\`]:EXTRA_INDEX_URL: ' \
'*-f+[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS: ' \
'*--find-links=[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS: ' \
'*-P+[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE: ' \
'*--upgrade-package=[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE: ' \
'*--reinstall-package=[Reinstall a specific package, regardless of whether it'\''s already installed. Implies \`--refresh-package\`]:REINSTALL_PACKAGE: ' \
'--index-strategy=[The strategy to use when resolving against multiple index URLs]:INDEX_STRATEGY:((first-index\:"Only use results from the first index that returns a match for a given package name"
unsafe-first-match\:"Search for every package name across all indexes, exhausting the versions from the first index before moving on to the next"
unsafe-best-match\:"Search for every package name across all indexes, preferring the "best" version found. If a package version is in multiple indexes, only look at the entry for the first index"))' \
'--keyring-provider=[Attempt to use \`keyring\` for authentication for index URLs]:KEYRING_PROVIDER:((disabled\:"Do not use keyring for credential lookup"
subprocess\:"Use the \`keyring\` command for credential lookup"))' \
'*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST: ' \
'--resolution=[The strategy to use when selecting between the different compatible versions for a given package requirement]:RESOLUTION:((highest\:"Resolve the highest compatible version of each package"
lowest\:"Resolve the lowest compatible version of each package"
lowest-direct\:"Resolve the lowest compatible version of any direct dependencies, and the highest compatible version of any transitive dependencies"))' \
'--prerelease=[The strategy to use when considering pre-release versions]:PRERELEASE:((disallow\:"Disallow all pre-release versions"
allow\:"Allow all pre-release versions"
if-necessary\:"Allow pre-release versions if all versions of a package are pre-release"
explicit\:"Allow pre-release versions for first-party packages with explicit pre-release markers in their version requirements"
if-necessary-or-explicit\:"Allow pre-release versions if all versions of a package are pre-release, or if the package has an explicit pre-release marker in its version requirements"))' \
'*-C+[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING: ' \
'*--config-setting=[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING: ' \
'*--no-build-isolation-package=[Disable isolation when building source distributions for a specific package]:NO_BUILD_ISOLATION_PACKAGE: ' \
'--exclude-newer=[Limit candidate packages to those that were uploaded prior to the given date]:EXCLUDE_NEWER: ' \
'--link-mode=[The method to use when installing packages from the global cache]:LINK_MODE:((clone\:"Clone (i.e., copy-on-write) packages from the wheel into the \`site-packages\` directory"
copy\:"Copy packages from the wheel into the \`site-packages\` directory"
hardlink\:"Hard link packages from the wheel into the \`site-packages\` directory"
symlink\:"Symbolically link packages from the wheel into the \`site-packages\` directory"))' \
'*--no-build-package=[Don'\''t build source distributions for a specific package]:NO_BUILD_PACKAGE: ' \
'*--no-binary-package=[Don'\''t install pre-built wheels for a specific package]:NO_BINARY_PACKAGE: ' \
'*--refresh-package=[Refresh cached data for a specific package]:REFRESH_PACKAGE: ' \
'-p+[The Python interpreter to use to build the tool environment.]:PYTHON: ' \
'--python=[The Python interpreter to use to build the tool environment.]:PYTHON: ' \
'--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' \
'--python-preference=[Whether to prefer uv-managed or system Python installations]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' \
'--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' \
'(--no-color)--color=[Control colors in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' \
'--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' \
'--project=[Run the command within the given project directory]:PROJECT:_files' \
'--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' \
'-e[]' \
'--editable[]' \
'--no-index[Ignore the registry index (e.g., PyPI), instead relying on direct URL dependencies and those provided via \`--find-links\`]' \
'-U[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' \
'--upgrade[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' \
'--no-upgrade[]' \
'--reinstall[Reinstall all packages, regardless of whether they'\''re already installed. Implies \`--refresh\`]' \
'--no-reinstall[]' \
'--pre[]' \
'--no-build-isolation[Disable isolation when building source distributions]' \
'--build-isolation[]' \
'--compile-bytecode[Compile Python files to bytecode after installation]' \
'--no-compile-bytecode[]' \
'--no-sources[Ignore the \`tool.uv.sources\` table when resolving dependencies. Used to lock against the standards-compliant, publishable package metadata, as opposed to using any local or Git sources]' \
'--no-build[Don'\''t build source distributions]' \
'--build[]' \
'--no-binary[Don'\''t install pre-built wheels]' \
'--binary[]' \
'(--offline)--refresh[Refresh all cached data]' \
'(--offline)--no-refresh[]' \
'--force[Force installation of the tool]' \
'-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' \
'--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' \
'(-v --verbose)-q[Do not print any output]' \
'(-v --verbose)--quiet[Do not print any output]' \
'(-q --quiet)*-v[Use verbose output]' \
'(-q --quiet)*--verbose[Use verbose output]' \
'(--color)--no-color[Disable colors]' \
'--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' \
'--no-native-tls[]' \
'--offline[Disable network access]' \
'--no-offline[]' \
'--preview[Whether to enable experimental, preview features]' \
'--no-preview[]' \
'--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' \
'--show-settings[Show the resolved settings for the current command]' \
'--no-progress[Hide all progress outputs]' \
'--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' \
'-h[Display the concise help for this command]' \
'--help[Display the concise help for this command]' \
'-V[Display the uv version]' \
'--version[Display the uv version]' \
':package -- The package to install commands from:' \
&& ret=0
;;
(upgrade)
_arguments "${_arguments_options[@]}" : \
'-p+[Upgrade a tool, and specify it to use the given Python interpreter to build its environment. Use with \`--all\` to apply to all tools.]:PYTHON: ' \
'--python=[Upgrade a tool, and specify it to use the given Python interpreter to build its environment. Use with \`--all\` to apply to all tools.]:PYTHON: ' \
'-i+[The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL: ' \
'--index-url=[The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL: ' \
'*--extra-index-url=[Extra URLs of package indexes to use, in addition to \`--index-url\`]:EXTRA_INDEX_URL: ' \
'*-f+[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS: ' \
'*--find-links=[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS: ' \
'*-P+[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE: ' \
'*--upgrade-package=[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE: ' \
'*--reinstall-package=[Reinstall a specific package, regardless of whether it'\''s already installed. Implies \`--refresh-package\`]:REINSTALL_PACKAGE: ' \
'--index-strategy=[The strategy to use when resolving against multiple index URLs]:INDEX_STRATEGY:((first-index\:"Only use results from the first index that returns a match for a given package name"
unsafe-first-match\:"Search for every package name across all indexes, exhausting the versions from the first index before moving on to the next"
unsafe-best-match\:"Search for every package name across all indexes, preferring the "best" version found. If a package version is in multiple indexes, only look at the entry for the first index"))' \
'--keyring-provider=[Attempt to use \`keyring\` for authentication for index URLs]:KEYRING_PROVIDER:((disabled\:"Do not use keyring for credential lookup"
subprocess\:"Use the \`keyring\` command for credential lookup"))' \
'*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST: ' \
'--resolution=[The strategy to use when selecting between the different compatible versions for a given package requirement]:RESOLUTION:((highest\:"Resolve the highest compatible version of each package"
lowest\:"Resolve the lowest compatible version of each package"
lowest-direct\:"Resolve the lowest compatible version of any direct dependencies, and the highest compatible version of any transitive dependencies"))' \
'--prerelease=[The strategy to use when considering pre-release versions]:PRERELEASE:((disallow\:"Disallow all pre-release versions"
allow\:"Allow all pre-release versions"
if-necessary\:"Allow pre-release versions if all versions of a package are pre-release"
explicit\:"Allow pre-release versions for first-party packages with explicit pre-release markers in their version requirements"
if-necessary-or-explicit\:"Allow pre-release versions if all versions of a package are pre-release, or if the package has an explicit pre-release marker in its version requirements"))' \
'*-C+[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING: ' \
'*--config-setting=[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING: ' \
'*--no-build-isolation-package=[Disable isolation when building source distributions for a specific package]:NO_BUILD_ISOLATION_PACKAGE: ' \
'--exclude-newer=[Limit candidate packages to those that were uploaded prior to the given date]:EXCLUDE_NEWER: ' \
'--link-mode=[The method to use when installing packages from the global cache]:LINK_MODE:((clone\:"Clone (i.e., copy-on-write) packages from the wheel into the \`site-packages\` directory"
copy\:"Copy packages from the wheel into the \`site-packages\` directory"
hardlink\:"Hard link packages from the wheel into the \`site-packages\` directory"
symlink\:"Symbolically link packages from the wheel into the \`site-packages\` directory"))' \
'*--no-build-package=[Don'\''t build source distributions for a specific package]:NO_BUILD_PACKAGE: ' \
'*--no-binary-package=[Don'\''t install pre-built wheels for a specific package]:NO_BINARY_PACKAGE: ' \
'--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' \
'--python-preference=[Whether to prefer uv-managed or system Python installations]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' \
'--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' \
'(--no-color)--color=[Control colors in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' \
'--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' \
'--project=[Run the command within the given project directory]:PROJECT:_files' \
'--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' \
'()--all[Upgrade all tools]' \
'--no-index[Ignore the registry index (e.g., PyPI), instead relying on direct URL dependencies and those provided via \`--find-links\`]' \
'-U[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' \
'--upgrade[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' \
'--no-upgrade[]' \
'--reinstall[Reinstall all packages, regardless of whether they'\''re already installed. Implies \`--refresh\`]' \
'--no-reinstall[]' \
'--pre[]' \
'--no-build-isolation[Disable isolation when building source distributions]' \
'--build-isolation[]' \
'--compile-bytecode[Compile Python files to bytecode after installation]' \
'--no-compile-bytecode[]' \
'--no-sources[Ignore the \`tool.uv.sources\` table when resolving dependencies. Used to lock against the standards-compliant, publishable package metadata, as opposed to using any local or Git sources]' \
'--no-build[Don'\''t build source distributions]' \
'--build[]' \
'--no-binary[Don'\''t install pre-built wheels]' \
'--binary[]' \
'-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' \
'--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' \
'(-v --verbose)-q[Do not print any output]' \
'(-v --verbose)--quiet[Do not print any output]' \
'(-q --quiet)*-v[Use verbose output]' \
'(-q --quiet)*--verbose[Use verbose output]' \
'(--color)--no-color[Disable colors]' \
'--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' \
'--no-native-tls[]' \
'--offline[Disable network access]' \
'--no-offline[]' \
'--preview[Whether to enable experimental, preview features]' \
'--no-preview[]' \
'--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' \
'--show-settings[Show the resolved settings for the current command]' \
'--no-progress[Hide all progress outputs]' \
'--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' \
'-h[Display the concise help for this command]' \
'--help[Display the concise help for this command]' \
'-V[Display the uv version]' \
'--version[Display the uv version]' \
'*::name -- The name of the tool to upgrade:' \
&& ret=0
;;
(list)
_arguments "${_arguments_options[@]}" : \
'--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' \
'--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' \
'--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' \
'(--no-color)--color=[Control colors in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' \
'--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' \
'--project=[Run the command within the given project directory]:PROJECT:_files' \
'--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' \
'--show-paths[Whether to display the path to each tool environment and installed executable]' \
'--show-version-specifiers[Whether to display the version specifier(s) used to install each tool]' \
'--no-python-downloads[]' \
'-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' \
'(-v --verbose)-q[Do not print any output]' \
'(-v --verbose)--quiet[Do not print any output]' \
'(-q --quiet)*-v[Use verbose output]' \
'(-q --quiet)*--verbose[Use verbose output]' \
'(--color)--no-color[Disable colors]' \
'--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' \
'--no-native-tls[]' \
'--offline[Disable network access]' \
'--no-offline[]' \
'--preview[Whether to enable experimental, preview features]' \
'--no-preview[]' \
'--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' \
'--show-settings[Show the resolved settings for the current command]' \
'--no-progress[Hide all progress outputs]' \
'--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' \
'-h[Display the concise help for this command]' \
'--help[Display the concise help for this command]' \
'-V[Display the uv version]' \
'--version[Display the uv version]' \
&& ret=0
;;
(uninstall)
_arguments "${_arguments_options[@]}" : \
'--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' \
'--python-preference=[Whether to prefer uv-managed or system Python installations]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' \
'--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' \
'(--no-color)--color=[Control colors in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' \
'--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' \
'--project=[Run the command within the given project directory]:PROJECT:_files' \
'--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' \
'()--all[Uninstall all tools]' \
'-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' \
'--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' \
'(-v --verbose)-q[Do not print any output]' \
'(-v --verbose)--quiet[Do not print any output]' \
'(-q --quiet)*-v[Use verbose output]' \
'(-q --quiet)*--verbose[Use verbose output]' \
'(--color)--no-color[Disable colors]' \
'--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' \
'--no-native-tls[]' \
'--offline[Disable network access]' \
'--no-offline[]' \
'--preview[Whether to enable experimental, preview features]' \
'--no-preview[]' \
'--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' \
'--show-settings[Show the resolved settings for the current command]' \
'--no-progress[Hide all progress outputs]' \
'--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' \
'-h[Display the concise help for this command]' \
'--help[Display the concise help for this command]' \
'-V[Display the uv version]' \
'--version[Display the uv version]' \
'*::name -- The name of the tool to uninstall:' \
&& ret=0
;;
(update-shell)
_arguments "${_arguments_options[@]}" : \
'--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' \
'--python-preference=[Whether to prefer uv-managed or system Python installations]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' \
'--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' \
'(--no-color)--color=[Control colors in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' \
'--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' \
'--project=[Run the command within the given project directory]:PROJECT:_files' \
'--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' \
'-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' \
'--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' \
'(-v --verbose)-q[Do not print any output]' \
'(-v --verbose)--quiet[Do not print any output]' \
'(-q --quiet)*-v[Use verbose output]' \
'(-q --quiet)*--verbose[Use verbose output]' \
'(--color)--no-color[Disable colors]' \
'--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' \
'--no-native-tls[]' \
'--offline[Disable network access]' \
'--no-offline[]' \
'--preview[Whether to enable experimental, preview features]' \
'--no-preview[]' \
'--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' \
'--show-settings[Show the resolved settings for the current command]' \
'--no-progress[Hide all progress outputs]' \
'--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' \
'-h[Display the concise help for this command]' \
'--help[Display the concise help for this command]' \
'-V[Display the uv version]' \
'--version[Display the uv version]' \
&& ret=0
;;
(dir)
_arguments "${_arguments_options[@]}" : \
'--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' \
'--python-preference=[Whether to prefer uv-managed or system Python installations]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' \
'--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' \
'(--no-color)--color=[Control colors in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' \
'--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' \
'--project=[Run the command within the given project directory]:PROJECT:_files' \
'--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' \
'--bin[Show the directory into which \`uv tool\` will install executables.]' \
'-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' \
'--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' \
'(-v --verbose)-q[Do not print any output]' \
'(-v --verbose)--quiet[Do not print any output]' \
'(-q --quiet)*-v[Use verbose output]' \
'(-q --quiet)*--verbose[Use verbose output]' \
'(--color)--no-color[Disable colors]' \
'--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' \
'--no-native-tls[]' \
'--offline[Disable network access]' \
'--no-offline[]' \
'--preview[Whether to enable experimental, preview features]' \
'--no-preview[]' \
'--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' \
'--show-settings[Show the resolved settings for the current command]' \
'--no-progress[Hide all progress outputs]' \
'--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' \
'-h[Display the concise help for this command]' \
'--help[Display the concise help for this command]' \
'-V[Display the uv version]' \
'--version[Display the uv version]' \
&& ret=0
;;
        esac
    ;;
esac
;;
(python)
_arguments "${_arguments_options[@]}" : \
'--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' \
'--python-preference=[Whether to prefer uv-managed or system Python installations]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' \
'--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' \
'(--no-color)--color=[Control colors in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' \
'--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' \
'--project=[Run the command within the given project directory]:PROJECT:_files' \
'--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' \
'-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' \
'--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' \
'(-v --verbose)-q[Do not print any output]' \
'(-v --verbose)--quiet[Do not print any output]' \
'(-q --quiet)*-v[Use verbose output]' \
'(-q --quiet)*--verbose[Use verbose output]' \
'(--color)--no-color[Disable colors]' \
'--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' \
'--no-native-tls[]' \
'--offline[Disable network access]' \
'--no-offline[]' \
'--preview[Whether to enable experimental, preview features]' \
'--no-preview[]' \
'--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' \
'--show-settings[Show the resolved settings for the current command]' \
'--no-progress[Hide all progress outputs]' \
'--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' \
'-h[Display the concise help for this command]' \
'--help[Display the concise help for this command]' \
'-V[Display the uv version]' \
'--version[Display the uv version]' \
":: :_uv__python_commands" \
"*::: :->python" \
&& ret=0

    case $state in
    (python)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:uv-python-command-$line[1]:"
        case $line[1] in
            (list)
_arguments "${_arguments_options[@]}" : \
'--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' \
'--python-preference=[Whether to prefer uv-managed or system Python installations]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' \
'--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' \
'(--no-color)--color=[Control colors in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' \
'--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' \
'--project=[Run the command within the given project directory]:PROJECT:_files' \
'--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' \
'--all-versions[List all Python versions, including old patch versions]' \
'--all-platforms[List Python downloads for all platforms]' \
'--only-installed[Only show installed Python versions, exclude available downloads]' \
'-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' \
'--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' \
'(-v --verbose)-q[Do not print any output]' \
'(-v --verbose)--quiet[Do not print any output]' \
'(-q --quiet)*-v[Use verbose output]' \
'(-q --quiet)*--verbose[Use verbose output]' \
'(--color)--no-color[Disable colors]' \
'--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' \
'--no-native-tls[]' \
'--offline[Disable network access]' \
'--no-offline[]' \
'--preview[Whether to enable experimental, preview features]' \
'--no-preview[]' \
'--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' \
'--show-settings[Show the resolved settings for the current command]' \
'--no-progress[Hide all progress outputs]' \
'--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' \
'-h[Display the concise help for this command]' \
'--help[Display the concise help for this command]' \
'-V[Display the uv version]' \
'--version[Display the uv version]' \
&& ret=0
;;
(install)
_arguments "${_arguments_options[@]}" : \
'--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' \
'--python-preference=[Whether to prefer uv-managed or system Python installations]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' \
'--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' \
'(--no-color)--color=[Control colors in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' \
'--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' \
'--project=[Run the command within the given project directory]:PROJECT:_files' \
'--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' \
'-r[Reinstall the requested Python version, if it'\''s already installed]' \
'--reinstall[Reinstall the requested Python version, if it'\''s already installed]' \
'-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' \
'--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' \
'(-v --verbose)-q[Do not print any output]' \
'(-v --verbose)--quiet[Do not print any output]' \
'(-q --quiet)*-v[Use verbose output]' \
'(-q --quiet)*--verbose[Use verbose output]' \
'(--color)--no-color[Disable colors]' \
'--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' \
'--no-native-tls[]' \
'--offline[Disable network access]' \
'--no-offline[]' \
'--preview[Whether to enable experimental, preview features]' \
'--no-preview[]' \
'--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' \
'--show-settings[Show the resolved settings for the current command]' \
'--no-progress[Hide all progress outputs]' \
'--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' \
'-h[Display the concise help for this command]' \
'--help[Display the concise help for this command]' \
'-V[Display the uv version]' \
'--version[Display the uv version]' \
'*::targets -- The Python version(s) to install:' \
&& ret=0
;;
(find)
_arguments "${_arguments_options[@]}" : \
'--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' \
'--python-preference=[Whether to prefer uv-managed or system Python installations]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' \
'--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' \
'(--no-color)--color=[Control colors in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' \
'--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' \
'--project=[Run the command within the given project directory]:PROJECT:_files' \
'--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' \
'--no-project[Avoid discovering a project or workspace]' \
'--system[Only find system Python interpreters]' \
'--no-system[]' \
'-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' \
'--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' \
'(-v --verbose)-q[Do not print any output]' \
'(-v --verbose)--quiet[Do not print any output]' \
'(-q --quiet)*-v[Use verbose output]' \
'(-q --quiet)*--verbose[Use verbose output]' \
'(--color)--no-color[Disable colors]' \
'--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' \
'--no-native-tls[]' \
'--offline[Disable network access]' \
'--no-offline[]' \
'--preview[Whether to enable experimental, preview features]' \
'--no-preview[]' \
'--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' \
'--show-settings[Show the resolved settings for the current command]' \
'--no-progress[Hide all progress outputs]' \
'--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' \
'-h[Display the concise help for this command]' \
'--help[Display the concise help for this command]' \
'-V[Display the uv version]' \
'--version[Display the uv version]' \
'::request -- The Python request:' \
&& ret=0
;;
(pin)
_arguments "${_arguments_options[@]}" : \
'--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' \
'--python-preference=[Whether to prefer uv-managed or system Python installations]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' \
'--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' \
'(--no-color)--color=[Control colors in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' \
'--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' \
'--project=[Run the command within the given project directory]:PROJECT:_files' \
'--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' \
'--resolved[Write the resolved Python interpreter path instead of the request]' \
'--no-resolved[]' \
'--no-project[Avoid validating the Python pin is compatible with the project or workspace]' \
'-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' \
'--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' \
'(-v --verbose)-q[Do not print any output]' \
'(-v --verbose)--quiet[Do not print any output]' \
'(-q --quiet)*-v[Use verbose output]' \
'(-q --quiet)*--verbose[Use verbose output]' \
'(--color)--no-color[Disable colors]' \
'--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' \
'--no-native-tls[]' \
'--offline[Disable network access]' \
'--no-offline[]' \
'--preview[Whether to enable experimental, preview features]' \
'--no-preview[]' \
'--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' \
'--show-settings[Show the resolved settings for the current command]' \
'--no-progress[Hide all progress outputs]' \
'--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' \
'-h[Display the concise help for this command]' \
'--help[Display the concise help for this command]' \
'-V[Display the uv version]' \
'--version[Display the uv version]' \
'::request -- The Python version request:' \
&& ret=0
;;
(dir)
_arguments "${_arguments_options[@]}" : \
'--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' \
'--python-preference=[Whether to prefer uv-managed or system Python installations]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' \
'--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' \
'(--no-color)--color=[Control colors in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' \
'--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' \
'--project=[Run the command within the given project directory]:PROJECT:_files' \
'--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' \
'-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' \
'--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' \
'(-v --verbose)-q[Do not print any output]' \
'(-v --verbose)--quiet[Do not print any output]' \
'(-q --quiet)*-v[Use verbose output]' \
'(-q --quiet)*--verbose[Use verbose output]' \
'(--color)--no-color[Disable colors]' \
'--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' \
'--no-native-tls[]' \
'--offline[Disable network access]' \
'--no-offline[]' \
'--preview[Whether to enable experimental, preview features]' \
'--no-preview[]' \
'--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' \
'--show-settings[Show the resolved settings for the current command]' \
'--no-progress[Hide all progress outputs]' \
'--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' \
'-h[Display the concise help for this command]' \
'--help[Display the concise help for this command]' \
'-V[Display the uv version]' \
'--version[Display the uv version]' \
&& ret=0
;;
(uninstall)
_arguments "${_arguments_options[@]}" : \
'--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' \
'--python-preference=[Whether to prefer uv-managed or system Python installations]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' \
'--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' \
'(--no-color)--color=[Control colors in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' \
'--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' \
'--project=[Run the command within the given project directory]:PROJECT:_files' \
'--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' \
'()--all[Uninstall all managed Python versions]' \
'-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' \
'--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' \
'(-v --verbose)-q[Do not print any output]' \
'(-v --verbose)--quiet[Do not print any output]' \
'(-q --quiet)*-v[Use verbose output]' \
'(-q --quiet)*--verbose[Use verbose output]' \
'(--color)--no-color[Disable colors]' \
'--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' \
'--no-native-tls[]' \
'--offline[Disable network access]' \
'--no-offline[]' \
'--preview[Whether to enable experimental, preview features]' \
'--no-preview[]' \
'--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' \
'--show-settings[Show the resolved settings for the current command]' \
'--no-progress[Hide all progress outputs]' \
'--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' \
'-h[Display the concise help for this command]' \
'--help[Display the concise help for this command]' \
'-V[Display the uv version]' \
'--version[Display the uv version]' \
'*::targets -- The Python version(s) to uninstall:' \
&& ret=0
;;
        esac
    ;;
esac
;;
(pip)
_arguments "${_arguments_options[@]}" : \
'--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' \
'--python-preference=[Whether to prefer uv-managed or system Python installations]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' \
'--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' \
'(--no-color)--color=[Control colors in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' \
'--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' \
'--project=[Run the command within the given project directory]:PROJECT:_files' \
'--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' \
'-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' \
'--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' \
'(-v --verbose)-q[Do not print any output]' \
'(-v --verbose)--quiet[Do not print any output]' \
'(-q --quiet)*-v[Use verbose output]' \
'(-q --quiet)*--verbose[Use verbose output]' \
'(--color)--no-color[Disable colors]' \
'--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' \
'--no-native-tls[]' \
'--offline[Disable network access]' \
'--no-offline[]' \
'--preview[Whether to enable experimental, preview features]' \
'--no-preview[]' \
'--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' \
'--show-settings[Show the resolved settings for the current command]' \
'--no-progress[Hide all progress outputs]' \
'--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' \
'-h[Display the concise help for this command]' \
'--help[Display the concise help for this command]' \
'-V[Display the uv version]' \
'--version[Display the uv version]' \
":: :_uv__pip_commands" \
"*::: :->pip" \
&& ret=0

    case $state in
    (pip)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:uv-pip-command-$line[1]:"
        case $line[1] in
            (compile)
_arguments "${_arguments_options[@]}" : \
'*-c+[Constrain versions using the given requirements files]:CONSTRAINT: ' \
'*--constraint=[Constrain versions using the given requirements files]:CONSTRAINT: ' \
'*--override=[Override versions using the given requirements files]:OVERRIDE: ' \
'*-b+[Constrain build dependencies using the given requirements files when building source distributions]:BUILD_CONSTRAINT: ' \
'*--build-constraint=[Constrain build dependencies using the given requirements files when building source distributions]:BUILD_CONSTRAINT: ' \
'(--all-extras)*--extra=[Include optional dependencies from the extra group name; may be provided more than once]:EXTRA: ' \
'-i+[The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL: ' \
'--index-url=[The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL: ' \
'*--extra-index-url=[Extra URLs of package indexes to use, in addition to \`--index-url\`]:EXTRA_INDEX_URL: ' \
'*-f+[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS: ' \
'*--find-links=[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS: ' \
'*-P+[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE: ' \
'*--upgrade-package=[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE: ' \
'--index-strategy=[The strategy to use when resolving against multiple index URLs]:INDEX_STRATEGY:((first-index\:"Only use results from the first index that returns a match for a given package name"
unsafe-first-match\:"Search for every package name across all indexes, exhausting the versions from the first index before moving on to the next"
unsafe-best-match\:"Search for every package name across all indexes, preferring the "best" version found. If a package version is in multiple indexes, only look at the entry for the first index"))' \
'--keyring-provider=[Attempt to use \`keyring\` for authentication for index URLs]:KEYRING_PROVIDER:((disabled\:"Do not use keyring for credential lookup"
subprocess\:"Use the \`keyring\` command for credential lookup"))' \
'*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST: ' \
'--resolution=[The strategy to use when selecting between the different compatible versions for a given package requirement]:RESOLUTION:((highest\:"Resolve the highest compatible version of each package"
lowest\:"Resolve the lowest compatible version of each package"
lowest-direct\:"Resolve the lowest compatible version of any direct dependencies, and the highest compatible version of any transitive dependencies"))' \
'--prerelease=[The strategy to use when considering pre-release versions]:PRERELEASE:((disallow\:"Disallow all pre-release versions"
allow\:"Allow all pre-release versions"
if-necessary\:"Allow pre-release versions if all versions of a package are pre-release"
explicit\:"Allow pre-release versions for first-party packages with explicit pre-release markers in their version requirements"
if-necessary-or-explicit\:"Allow pre-release versions if all versions of a package are pre-release, or if the package has an explicit pre-release marker in its version requirements"))' \
'*-C+[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING: ' \
'*--config-setting=[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING: ' \
'*--no-build-isolation-package=[Disable isolation when building source distributions for a specific package]:NO_BUILD_ISOLATION_PACKAGE: ' \
'--exclude-newer=[Limit candidate packages to those that were uploaded prior to the given date]:EXCLUDE_NEWER: ' \
'--link-mode=[The method to use when installing packages from the global cache]:LINK_MODE:((clone\:"Clone (i.e., copy-on-write) packages from the wheel into the \`site-packages\` directory"
copy\:"Copy packages from the wheel into the \`site-packages\` directory"
hardlink\:"Hard link packages from the wheel into the \`site-packages\` directory"
symlink\:"Symbolically link packages from the wheel into the \`site-packages\` directory"))' \
'*--refresh-package=[Refresh cached data for a specific package]:REFRESH_PACKAGE: ' \
'-o+[Write the compiled requirements to the given \`requirements.txt\` file]:OUTPUT_FILE:_files' \
'--output-file=[Write the compiled requirements to the given \`requirements.txt\` file]:OUTPUT_FILE:_files' \
'--annotation-style=[The style of the annotation comments included in the output file, used to indicate the source of each package]:ANNOTATION_STYLE:((line\:"Render the annotations on a single, comma-separated line"
split\:"Render each annotation on its own line"))' \
'--custom-compile-command=[The header comment to include at the top of the output file generated by \`uv pip compile\`]:CUSTOM_COMPILE_COMMAND: ' \
'--python=[The Python interpreter to use during resolution.]:PYTHON: ' \
'(--no-build)*--no-binary=[Don'\''t install pre-built wheels]:NO_BINARY: ' \
'(--no-build)*--only-binary=[Only use pre-built wheels; don'\''t build source distributions]:ONLY_BINARY: ' \
'-p+[The Python version to use for resolution]:PYTHON_VERSION: ' \
'--python-version=[The Python version to use for resolution]:PYTHON_VERSION: ' \
'--python-platform=[The platform for which requirements should be resolved]:PYTHON_PLATFORM:((windows\:"An alias for \`x86_64-pc-windows-msvc\`, the default target for Windows"
linux\:"An alias for \`x86_64-unknown-linux-gnu\`, the default target for Linux"
macos\:"An alias for \`aarch64-apple-darwin\`, the default target for macOS"
x86_64-pc-windows-msvc\:"A 64-bit x86 Windows target"
i686-pc-windows-msvc\:"A 32-bit x86 Windows target"
x86_64-unknown-linux-gnu\:"An x86 Linux target. Equivalent to \`x86_64-manylinux_2_17\`"
aarch64-apple-darwin\:"An ARM-based macOS target, as seen on Apple Silicon devices"
x86_64-apple-darwin\:"An x86 macOS target"
aarch64-unknown-linux-gnu\:"An ARM64 Linux target. Equivalent to \`aarch64-manylinux_2_17\`"
aarch64-unknown-linux-musl\:"An ARM64 Linux target"
x86_64-unknown-linux-musl\:"An \`x86_64\` Linux target"
x86_64-manylinux_2_17\:"An \`x86_64\` target for the \`manylinux_2_17\` platform"
x86_64-manylinux_2_28\:"An \`x86_64\` target for the \`manylinux_2_28\` platform"
x86_64-manylinux_2_31\:"An \`x86_64\` target for the \`manylinux_2_31\` platform"
aarch64-manylinux_2_17\:"An ARM64 target for the \`manylinux_2_17\` platform"
aarch64-manylinux_2_28\:"An ARM64 target for the \`manylinux_2_28\` platform"
aarch64-manylinux_2_31\:"An ARM64 target for the \`manylinux_2_31\` platform"))' \
'*--no-emit-package=[Specify a package to omit from the output resolution. Its dependencies will still be included in the resolution. Equivalent to pip-compile'\''s \`--unsafe-package\` option]:NO_EMIT_PACKAGE: ' \
'--resolver=[]:RESOLVER:(backtracking legacy)' \
'--max-rounds=[]:MAX_ROUNDS: ' \
'--cert=[]:CERT: ' \
'--client-cert=[]:CLIENT_CERT: ' \
'--config=[]:CONFIG: ' \
'--pip-args=[]:PIP_ARGS: ' \
'--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' \
'--python-preference=[Whether to prefer uv-managed or system Python installations]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' \
'--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' \
'(--no-color)--color=[Control colors in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' \
'--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' \
'--project=[Run the command within the given project directory]:PROJECT:_files' \
'--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' \
'(--extra)--all-extras[Include all optional dependencies]' \
'--no-all-extras[]' \
'--no-index[Ignore the registry index (e.g., PyPI), instead relying on direct URL dependencies and those provided via \`--find-links\`]' \
'-U[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' \
'--upgrade[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' \
'--no-upgrade[]' \
'--pre[]' \
'--no-build-isolation[Disable isolation when building source distributions]' \
'--build-isolation[]' \
'--no-sources[Ignore the \`tool.uv.sources\` table when resolving dependencies. Used to lock against the standards-compliant, publishable package metadata, as opposed to using any local or Git sources]' \
'(--offline)--refresh[Refresh all cached data]' \
'(--offline)--no-refresh[]' \
'--no-deps[Ignore package dependencies, instead only add those packages explicitly listed on the command line to the resulting the requirements file]' \
'--deps[]' \
'--no-strip-extras[Include extras in the output file]' \
'--strip-extras[]' \
'--no-strip-markers[Include environment markers in the output file]' \
'--strip-markers[]' \
'--no-annotate[Exclude comment annotations indicating the source of each package]' \
'--annotate[]' \
'--no-header[Exclude the comment header at the top of the generated output file]' \
'--header[]' \
'--system[Install packages into the system Python environment]' \
'--no-system[]' \
'--generate-hashes[Include distribution hashes in the output file]' \
'--no-generate-hashes[]' \
'(--no-binary --only-binary)--no-build[Don'\''t build source distributions]' \
'(--no-binary --only-binary)--build[]' \
'(--python-platform --strip-markers)--universal[Perform a universal resolution, attempting to generate a single \`requirements.txt\` output file that is compatible with all operating systems, architectures, and Python implementations]' \
'--no-universal[]' \
'--emit-index-url[Include \`--index-url\` and \`--extra-index-url\` entries in the generated output file]' \
'--no-emit-index-url[]' \
'--emit-find-links[Include \`--find-links\` entries in the generated output file]' \
'--no-emit-find-links[]' \
'--emit-build-options[Include \`--no-binary\` and \`--only-binary\` entries in the generated output file]' \
'--no-emit-build-options[]' \
'--emit-marker-expression[Whether to emit a marker string indicating when it is known that the resulting set of pinned dependencies is valid]' \
'--no-emit-marker-expression[]' \
'--emit-index-annotation[Include comment annotations indicating the index used to resolve each package (e.g., \`# from https\://pypi.org/simple\`)]' \
'--no-emit-index-annotation[]' \
'--allow-unsafe[]' \
'--no-allow-unsafe[]' \
'--reuse-hashes[]' \
'--no-reuse-hashes[]' \
'--emit-trusted-host[]' \
'--no-emit-trusted-host[]' \
'--no-config[]' \
'--emit-options[]' \
'--no-emit-options[]' \
'-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' \
'--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' \
'(-v --verbose)-q[Do not print any output]' \
'(-v --verbose)--quiet[Do not print any output]' \
'(-q --quiet)*-v[Use verbose output]' \
'(-q --quiet)*--verbose[Use verbose output]' \
'(--color)--no-color[Disable colors]' \
'--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' \
'--no-native-tls[]' \
'--offline[Disable network access]' \
'--no-offline[]' \
'--preview[Whether to enable experimental, preview features]' \
'--no-preview[]' \
'--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' \
'--show-settings[Show the resolved settings for the current command]' \
'--no-progress[Hide all progress outputs]' \
'-h[Display the concise help for this command]' \
'--help[Display the concise help for this command]' \
'-V[Display the uv version]' \
'--version[Display the uv version]' \
'*::src_file -- Include all packages listed in the given `requirements.in` files:_files' \
&& ret=0
;;
(sync)
_arguments "${_arguments_options[@]}" : \
'*-c+[Constrain versions using the given requirements files]:CONSTRAINT: ' \
'*--constraint=[Constrain versions using the given requirements files]:CONSTRAINT: ' \
'*-b+[Constrain build dependencies using the given requirements files when building source distributions]:BUILD_CONSTRAINT: ' \
'*--build-constraint=[Constrain build dependencies using the given requirements files when building source distributions]:BUILD_CONSTRAINT: ' \
'-i+[The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL: ' \
'--index-url=[The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL: ' \
'*--extra-index-url=[Extra URLs of package indexes to use, in addition to \`--index-url\`]:EXTRA_INDEX_URL: ' \
'*-f+[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS: ' \
'*--find-links=[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS: ' \
'*--reinstall-package=[Reinstall a specific package, regardless of whether it'\''s already installed. Implies \`--refresh-package\`]:REINSTALL_PACKAGE: ' \
'--index-strategy=[The strategy to use when resolving against multiple index URLs]:INDEX_STRATEGY:((first-index\:"Only use results from the first index that returns a match for a given package name"
unsafe-first-match\:"Search for every package name across all indexes, exhausting the versions from the first index before moving on to the next"
unsafe-best-match\:"Search for every package name across all indexes, preferring the "best" version found. If a package version is in multiple indexes, only look at the entry for the first index"))' \
'--keyring-provider=[Attempt to use \`keyring\` for authentication for index URLs]:KEYRING_PROVIDER:((disabled\:"Do not use keyring for credential lookup"
subprocess\:"Use the \`keyring\` command for credential lookup"))' \
'*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST: ' \
'*-C+[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING: ' \
'*--config-setting=[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING: ' \
'--exclude-newer=[Limit candidate packages to those that were uploaded prior to the given date]:EXCLUDE_NEWER: ' \
'--link-mode=[The method to use when installing packages from the global cache]:LINK_MODE:((clone\:"Clone (i.e., copy-on-write) packages from the wheel into the \`site-packages\` directory"
copy\:"Copy packages from the wheel into the \`site-packages\` directory"
hardlink\:"Hard link packages from the wheel into the \`site-packages\` directory"
symlink\:"Symbolically link packages from the wheel into the \`site-packages\` directory"))' \
'*--refresh-package=[Refresh cached data for a specific package]:REFRESH_PACKAGE: ' \
'-p+[The Python interpreter into which packages should be installed.]:PYTHON: ' \
'--python=[The Python interpreter into which packages should be installed.]:PYTHON: ' \
'(--prefix)--target=[Install packages into the specified directory, rather than into the virtual or system Python environment. The packages will be installed at the top-level of the directory]:TARGET:_files' \
'(--target)--prefix=[Install packages into \`lib\`, \`bin\`, and other top-level folders under the specified directory, as if a virtual environment were present at that location]:PREFIX:_files' \
'(--no-build)*--no-binary=[Don'\''t install pre-built wheels]:NO_BINARY: ' \
'(--no-build)*--only-binary=[Only use pre-built wheels; don'\''t build source distributions]:ONLY_BINARY: ' \
'--python-version=[The minimum Python version that should be supported by the requirements (e.g., \`3.7\` or \`3.7.9\`)]:PYTHON_VERSION: ' \
'--python-platform=[The platform for which requirements should be installed]:PYTHON_PLATFORM:((windows\:"An alias for \`x86_64-pc-windows-msvc\`, the default target for Windows"
linux\:"An alias for \`x86_64-unknown-linux-gnu\`, the default target for Linux"
macos\:"An alias for \`aarch64-apple-darwin\`, the default target for macOS"
x86_64-pc-windows-msvc\:"A 64-bit x86 Windows target"
i686-pc-windows-msvc\:"A 32-bit x86 Windows target"
x86_64-unknown-linux-gnu\:"An x86 Linux target. Equivalent to \`x86_64-manylinux_2_17\`"
aarch64-apple-darwin\:"An ARM-based macOS target, as seen on Apple Silicon devices"
x86_64-apple-darwin\:"An x86 macOS target"
aarch64-unknown-linux-gnu\:"An ARM64 Linux target. Equivalent to \`aarch64-manylinux_2_17\`"
aarch64-unknown-linux-musl\:"An ARM64 Linux target"
x86_64-unknown-linux-musl\:"An \`x86_64\` Linux target"
x86_64-manylinux_2_17\:"An \`x86_64\` target for the \`manylinux_2_17\` platform"
x86_64-manylinux_2_28\:"An \`x86_64\` target for the \`manylinux_2_28\` platform"
x86_64-manylinux_2_31\:"An \`x86_64\` target for the \`manylinux_2_31\` platform"
aarch64-manylinux_2_17\:"An ARM64 target for the \`manylinux_2_17\` platform"
aarch64-manylinux_2_28\:"An ARM64 target for the \`manylinux_2_28\` platform"
aarch64-manylinux_2_31\:"An ARM64 target for the \`manylinux_2_31\` platform"))' \
'--python-executable=[]:PYTHON_EXECUTABLE: ' \
'--cert=[]:CERT: ' \
'--client-cert=[]:CLIENT_CERT: ' \
'--config=[]:CONFIG: ' \
'--pip-args=[]:PIP_ARGS: ' \
'--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' \
'--python-preference=[Whether to prefer uv-managed or system Python installations]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' \
'--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' \
'(--no-color)--color=[Control colors in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' \
'--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' \
'--project=[Run the command within the given project directory]:PROJECT:_files' \
'--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' \
'--no-index[Ignore the registry index (e.g., PyPI), instead relying on direct URL dependencies and those provided via \`--find-links\`]' \
'--reinstall[Reinstall all packages, regardless of whether they'\''re already installed. Implies \`--refresh\`]' \
'--no-reinstall[]' \
'--no-build-isolation[Disable isolation when building source distributions]' \
'--build-isolation[]' \
'--compile-bytecode[Compile Python files to bytecode after installation]' \
'--no-compile-bytecode[]' \
'--no-sources[Ignore the \`tool.uv.sources\` table when resolving dependencies. Used to lock against the standards-compliant, publishable package metadata, as opposed to using any local or Git sources]' \
'(--offline)--refresh[Refresh all cached data]' \
'(--offline)--no-refresh[]' \
'--require-hashes[Require a matching hash for each requirement]' \
'--no-require-hashes[]' \
'--verify-hashes[Validate any hashes provided in the requirements file]' \
'--no-verify-hashes[]' \
'--system[Install packages into the system Python environment]' \
'--no-system[]' \
'--break-system-packages[Allow uv to modify an \`EXTERNALLY-MANAGED\` Python installation]' \
'--no-break-system-packages[]' \
'(--no-binary --only-binary)--no-build[Don'\''t build source distributions]' \
'(--no-binary --only-binary)--build[]' \
'--allow-empty-requirements[Allow sync of empty requirements, which will clear the environment of all packages]' \
'--no-allow-empty-requirements[]' \
'--strict[Validate the Python environment after completing the installation, to detect and with missing dependencies or other issues]' \
'--no-strict[]' \
'--dry-run[Perform a dry run, i.e., don'\''t actually install anything but resolve the dependencies and print the resulting plan]' \
'-a[]' \
'--ask[]' \
'--user[]' \
'--no-config[]' \
'-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' \
'--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' \
'(-v --verbose)-q[Do not print any output]' \
'(-v --verbose)--quiet[Do not print any output]' \
'(-q --quiet)*-v[Use verbose output]' \
'(-q --quiet)*--verbose[Use verbose output]' \
'(--color)--no-color[Disable colors]' \
'--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' \
'--no-native-tls[]' \
'--offline[Disable network access]' \
'--no-offline[]' \
'--preview[Whether to enable experimental, preview features]' \
'--no-preview[]' \
'--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' \
'--show-settings[Show the resolved settings for the current command]' \
'--no-progress[Hide all progress outputs]' \
'-h[Display the concise help for this command]' \
'--help[Display the concise help for this command]' \
'-V[Display the uv version]' \
'--version[Display the uv version]' \
'*::src_file -- Include all packages listed in the given `requirements.txt` files:_files' \
&& ret=0
;;
(install)
_arguments "${_arguments_options[@]}" : \
'*-r+[Install all packages listed in the given \`requirements.txt\` files]:REQUIREMENT:_files' \
'*--requirement=[Install all packages listed in the given \`requirements.txt\` files]:REQUIREMENT:_files' \
'*-e+[Install the editable package based on the provided local file path]:EDITABLE: ' \
'*--editable=[Install the editable package based on the provided local file path]:EDITABLE: ' \
'*-c+[Constrain versions using the given requirements files]:CONSTRAINT: ' \
'*--constraint=[Constrain versions using the given requirements files]:CONSTRAINT: ' \
'*--override=[Override versions using the given requirements files]:OVERRIDE: ' \
'*-b+[Constrain build dependencies using the given requirements files when building source distributions]:BUILD_CONSTRAINT: ' \
'*--build-constraint=[Constrain build dependencies using the given requirements files when building source distributions]:BUILD_CONSTRAINT: ' \
'(--all-extras)*--extra=[Include optional dependencies from the extra group name; may be provided more than once]:EXTRA: ' \
'-i+[The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL: ' \
'--index-url=[The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL: ' \
'*--extra-index-url=[Extra URLs of package indexes to use, in addition to \`--index-url\`]:EXTRA_INDEX_URL: ' \
'*-f+[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS: ' \
'*--find-links=[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS: ' \
'*-P+[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE: ' \
'*--upgrade-package=[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE: ' \
'*--reinstall-package=[Reinstall a specific package, regardless of whether it'\''s already installed. Implies \`--refresh-package\`]:REINSTALL_PACKAGE: ' \
'--index-strategy=[The strategy to use when resolving against multiple index URLs]:INDEX_STRATEGY:((first-index\:"Only use results from the first index that returns a match for a given package name"
unsafe-first-match\:"Search for every package name across all indexes, exhausting the versions from the first index before moving on to the next"
unsafe-best-match\:"Search for every package name across all indexes, preferring the "best" version found. If a package version is in multiple indexes, only look at the entry for the first index"))' \
'--keyring-provider=[Attempt to use \`keyring\` for authentication for index URLs]:KEYRING_PROVIDER:((disabled\:"Do not use keyring for credential lookup"
subprocess\:"Use the \`keyring\` command for credential lookup"))' \
'*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST: ' \
'--resolution=[The strategy to use when selecting between the different compatible versions for a given package requirement]:RESOLUTION:((highest\:"Resolve the highest compatible version of each package"
lowest\:"Resolve the lowest compatible version of each package"
lowest-direct\:"Resolve the lowest compatible version of any direct dependencies, and the highest compatible version of any transitive dependencies"))' \
'--prerelease=[The strategy to use when considering pre-release versions]:PRERELEASE:((disallow\:"Disallow all pre-release versions"
allow\:"Allow all pre-release versions"
if-necessary\:"Allow pre-release versions if all versions of a package are pre-release"
explicit\:"Allow pre-release versions for first-party packages with explicit pre-release markers in their version requirements"
if-necessary-or-explicit\:"Allow pre-release versions if all versions of a package are pre-release, or if the package has an explicit pre-release marker in its version requirements"))' \
'*-C+[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING: ' \
'*--config-setting=[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING: ' \
'*--no-build-isolation-package=[Disable isolation when building source distributions for a specific package]:NO_BUILD_ISOLATION_PACKAGE: ' \
'--exclude-newer=[Limit candidate packages to those that were uploaded prior to the given date]:EXCLUDE_NEWER: ' \
'--link-mode=[The method to use when installing packages from the global cache]:LINK_MODE:((clone\:"Clone (i.e., copy-on-write) packages from the wheel into the \`site-packages\` directory"
copy\:"Copy packages from the wheel into the \`site-packages\` directory"
hardlink\:"Hard link packages from the wheel into the \`site-packages\` directory"
symlink\:"Symbolically link packages from the wheel into the \`site-packages\` directory"))' \
'*--refresh-package=[Refresh cached data for a specific package]:REFRESH_PACKAGE: ' \
'-p+[The Python interpreter into which packages should be installed.]:PYTHON: ' \
'--python=[The Python interpreter into which packages should be installed.]:PYTHON: ' \
'(--prefix)--target=[Install packages into the specified directory, rather than into the virtual or system Python environment. The packages will be installed at the top-level of the directory]:TARGET:_files' \
'(--target)--prefix=[Install packages into \`lib\`, \`bin\`, and other top-level folders under the specified directory, as if a virtual environment were present at that location]:PREFIX:_files' \
'(--no-build)*--no-binary=[Don'\''t install pre-built wheels]:NO_BINARY: ' \
'(--no-build)*--only-binary=[Only use pre-built wheels; don'\''t build source distributions]:ONLY_BINARY: ' \
'--python-version=[The minimum Python version that should be supported by the requirements (e.g., \`3.7\` or \`3.7.9\`)]:PYTHON_VERSION: ' \
'--python-platform=[The platform for which requirements should be installed]:PYTHON_PLATFORM:((windows\:"An alias for \`x86_64-pc-windows-msvc\`, the default target for Windows"
linux\:"An alias for \`x86_64-unknown-linux-gnu\`, the default target for Linux"
macos\:"An alias for \`aarch64-apple-darwin\`, the default target for macOS"
x86_64-pc-windows-msvc\:"A 64-bit x86 Windows target"
i686-pc-windows-msvc\:"A 32-bit x86 Windows target"
x86_64-unknown-linux-gnu\:"An x86 Linux target. Equivalent to \`x86_64-manylinux_2_17\`"
aarch64-apple-darwin\:"An ARM-based macOS target, as seen on Apple Silicon devices"
x86_64-apple-darwin\:"An x86 macOS target"
aarch64-unknown-linux-gnu\:"An ARM64 Linux target. Equivalent to \`aarch64-manylinux_2_17\`"
aarch64-unknown-linux-musl\:"An ARM64 Linux target"
x86_64-unknown-linux-musl\:"An \`x86_64\` Linux target"
x86_64-manylinux_2_17\:"An \`x86_64\` target for the \`manylinux_2_17\` platform"
x86_64-manylinux_2_28\:"An \`x86_64\` target for the \`manylinux_2_28\` platform"
x86_64-manylinux_2_31\:"An \`x86_64\` target for the \`manylinux_2_31\` platform"
aarch64-manylinux_2_17\:"An ARM64 target for the \`manylinux_2_17\` platform"
aarch64-manylinux_2_28\:"An ARM64 target for the \`manylinux_2_28\` platform"
aarch64-manylinux_2_31\:"An ARM64 target for the \`manylinux_2_31\` platform"))' \
'--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' \
'--python-preference=[Whether to prefer uv-managed or system Python installations]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' \
'--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' \
'(--no-color)--color=[Control colors in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' \
'--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' \
'--project=[Run the command within the given project directory]:PROJECT:_files' \
'--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' \
'(--extra)--all-extras[Include all optional dependencies]' \
'--no-all-extras[]' \
'--no-index[Ignore the registry index (e.g., PyPI), instead relying on direct URL dependencies and those provided via \`--find-links\`]' \
'-U[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' \
'--upgrade[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' \
'--no-upgrade[]' \
'--reinstall[Reinstall all packages, regardless of whether they'\''re already installed. Implies \`--refresh\`]' \
'--no-reinstall[]' \
'--pre[]' \
'--no-build-isolation[Disable isolation when building source distributions]' \
'--build-isolation[]' \
'--compile-bytecode[Compile Python files to bytecode after installation]' \
'--no-compile-bytecode[]' \
'--no-sources[Ignore the \`tool.uv.sources\` table when resolving dependencies. Used to lock against the standards-compliant, publishable package metadata, as opposed to using any local or Git sources]' \
'(--offline)--refresh[Refresh all cached data]' \
'(--offline)--no-refresh[]' \
'--no-deps[Ignore package dependencies, instead only installing those packages explicitly listed on the command line or in the requirements files]' \
'--deps[]' \
'--require-hashes[Require a matching hash for each requirement]' \
'--no-require-hashes[]' \
'--verify-hashes[Validate any hashes provided in the requirements file]' \
'--no-verify-hashes[]' \
'--system[Install packages into the system Python environment]' \
'--no-system[]' \
'--break-system-packages[Allow uv to modify an \`EXTERNALLY-MANAGED\` Python installation]' \
'--no-break-system-packages[]' \
'(--no-binary --only-binary)--no-build[Don'\''t build source distributions]' \
'(--no-binary --only-binary)--build[]' \
'--strict[Validate the Python environment after completing the installation, to detect and with missing dependencies or other issues]' \
'--no-strict[]' \
'--dry-run[Perform a dry run, i.e., don'\''t actually install anything but resolve the dependencies and print the resulting plan]' \
'--disable-pip-version-check[]' \
'--user[]' \
'-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' \
'--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' \
'(-v --verbose)-q[Do not print any output]' \
'(-v --verbose)--quiet[Do not print any output]' \
'(-q --quiet)*-v[Use verbose output]' \
'(-q --quiet)*--verbose[Use verbose output]' \
'(--color)--no-color[Disable colors]' \
'--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' \
'--no-native-tls[]' \
'--offline[Disable network access]' \
'--no-offline[]' \
'--preview[Whether to enable experimental, preview features]' \
'--no-preview[]' \
'--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' \
'--show-settings[Show the resolved settings for the current command]' \
'--no-progress[Hide all progress outputs]' \
'--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' \
'-h[Display the concise help for this command]' \
'--help[Display the concise help for this command]' \
'-V[Display the uv version]' \
'--version[Display the uv version]' \
'*::package -- Install all listed packages:' \
&& ret=0
;;
(uninstall)
_arguments "${_arguments_options[@]}" : \
'*-r+[Uninstall all packages listed in the given requirements files]:REQUIREMENT:_files' \
'*--requirement=[Uninstall all packages listed in the given requirements files]:REQUIREMENT:_files' \
'-p+[The Python interpreter from which packages should be uninstalled.]:PYTHON: ' \
'--python=[The Python interpreter from which packages should be uninstalled.]:PYTHON: ' \
'--keyring-provider=[Attempt to use \`keyring\` for authentication for remote requirements files]:KEYRING_PROVIDER:((disabled\:"Do not use keyring for credential lookup"
subprocess\:"Use the \`keyring\` command for credential lookup"))' \
'*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST: ' \
'(--prefix)--target=[Uninstall packages from the specified \`--target\` directory]:TARGET:_files' \
'(--target)--prefix=[Uninstall packages from the specified \`--prefix\` directory]:PREFIX:_files' \
'--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' \
'--python-preference=[Whether to prefer uv-managed or system Python installations]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' \
'--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' \
'(--no-color)--color=[Control colors in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' \
'--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' \
'--project=[Run the command within the given project directory]:PROJECT:_files' \
'--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' \
'--system[Use the system Python to uninstall packages]' \
'--no-system[]' \
'--break-system-packages[Allow uv to modify an \`EXTERNALLY-MANAGED\` Python installation]' \
'--no-break-system-packages[]' \
'--disable-pip-version-check[]' \
'-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' \
'--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' \
'(-v --verbose)-q[Do not print any output]' \
'(-v --verbose)--quiet[Do not print any output]' \
'(-q --quiet)*-v[Use verbose output]' \
'(-q --quiet)*--verbose[Use verbose output]' \
'(--color)--no-color[Disable colors]' \
'--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' \
'--no-native-tls[]' \
'--offline[Disable network access]' \
'--no-offline[]' \
'--preview[Whether to enable experimental, preview features]' \
'--no-preview[]' \
'--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' \
'--show-settings[Show the resolved settings for the current command]' \
'--no-progress[Hide all progress outputs]' \
'--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' \
'-h[Display the concise help for this command]' \
'--help[Display the concise help for this command]' \
'-V[Display the uv version]' \
'--version[Display the uv version]' \
'*::package -- Uninstall all listed packages:' \
&& ret=0
;;
(freeze)
_arguments "${_arguments_options[@]}" : \
'-p+[The Python interpreter for which packages should be listed.]:PYTHON: ' \
'--python=[The Python interpreter for which packages should be listed.]:PYTHON: ' \
'--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' \
'--python-preference=[Whether to prefer uv-managed or system Python installations]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' \
'--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' \
'(--no-color)--color=[Control colors in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' \
'--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' \
'--project=[Run the command within the given project directory]:PROJECT:_files' \
'--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' \
'--exclude-editable[Exclude any editable packages from output]' \
'--strict[Validate the Python environment, to detect packages with missing dependencies and other issues]' \
'--no-strict[]' \
'--system[List packages in the system Python environment]' \
'--no-system[]' \
'--disable-pip-version-check[]' \
'-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' \
'--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' \
'(-v --verbose)-q[Do not print any output]' \
'(-v --verbose)--quiet[Do not print any output]' \
'(-q --quiet)*-v[Use verbose output]' \
'(-q --quiet)*--verbose[Use verbose output]' \
'(--color)--no-color[Disable colors]' \
'--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' \
'--no-native-tls[]' \
'--offline[Disable network access]' \
'--no-offline[]' \
'--preview[Whether to enable experimental, preview features]' \
'--no-preview[]' \
'--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' \
'--show-settings[Show the resolved settings for the current command]' \
'--no-progress[Hide all progress outputs]' \
'--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' \
'-h[Display the concise help for this command]' \
'--help[Display the concise help for this command]' \
'-V[Display the uv version]' \
'--version[Display the uv version]' \
&& ret=0
;;
(list)
_arguments "${_arguments_options[@]}" : \
'*--exclude=[Exclude the specified package(s) from the output]:EXCLUDE: ' \
'--format=[Select the output format between\: \`columns\` (default), \`freeze\`, or \`json\`]:FORMAT:((columns\:"Display the list of packages in a human-readable table"
freeze\:"Display the list of packages in a \`pip freeze\`-like format, with one package per line alongside its version"
json\:"Display the list of packages in a machine-readable JSON format"))' \
'-p+[The Python interpreter for which packages should be listed.]:PYTHON: ' \
'--python=[The Python interpreter for which packages should be listed.]:PYTHON: ' \
'--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' \
'--python-preference=[Whether to prefer uv-managed or system Python installations]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' \
'--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' \
'(--no-color)--color=[Control colors in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' \
'--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' \
'--project=[Run the command within the given project directory]:PROJECT:_files' \
'--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' \
'-e[Only include editable projects]' \
'--editable[Only include editable projects]' \
'(-e --editable)--exclude-editable[Exclude any editable packages from output]' \
'--strict[Validate the Python environment, to detect packages with missing dependencies and other issues]' \
'--no-strict[]' \
'--system[List packages in the system Python environment]' \
'--no-system[]' \
'--disable-pip-version-check[]' \
'--outdated[]' \
'-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' \
'--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' \
'(-v --verbose)-q[Do not print any output]' \
'(-v --verbose)--quiet[Do not print any output]' \
'(-q --quiet)*-v[Use verbose output]' \
'(-q --quiet)*--verbose[Use verbose output]' \
'(--color)--no-color[Disable colors]' \
'--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' \
'--no-native-tls[]' \
'--offline[Disable network access]' \
'--no-offline[]' \
'--preview[Whether to enable experimental, preview features]' \
'--no-preview[]' \
'--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' \
'--show-settings[Show the resolved settings for the current command]' \
'--no-progress[Hide all progress outputs]' \
'--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' \
'-h[Display the concise help for this command]' \
'--help[Display the concise help for this command]' \
'-V[Display the uv version]' \
'--version[Display the uv version]' \
&& ret=0
;;
(show)
_arguments "${_arguments_options[@]}" : \
'-p+[The Python interpreter to find the package in.]:PYTHON: ' \
'--python=[The Python interpreter to find the package in.]:PYTHON: ' \
'--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' \
'--python-preference=[Whether to prefer uv-managed or system Python installations]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' \
'--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' \
'(--no-color)--color=[Control colors in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' \
'--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' \
'--project=[Run the command within the given project directory]:PROJECT:_files' \
'--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' \
'--strict[Validate the Python environment, to detect packages with missing dependencies and other issues]' \
'--no-strict[]' \
'--system[Show a package in the system Python environment]' \
'--no-system[]' \
'--disable-pip-version-check[]' \
'-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' \
'--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' \
'(-v --verbose)-q[Do not print any output]' \
'(-v --verbose)--quiet[Do not print any output]' \
'(-q --quiet)*-v[Use verbose output]' \
'(-q --quiet)*--verbose[Use verbose output]' \
'(--color)--no-color[Disable colors]' \
'--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' \
'--no-native-tls[]' \
'--offline[Disable network access]' \
'--no-offline[]' \
'--preview[Whether to enable experimental, preview features]' \
'--no-preview[]' \
'--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' \
'--show-settings[Show the resolved settings for the current command]' \
'--no-progress[Hide all progress outputs]' \
'--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' \
'-h[Display the concise help for this command]' \
'--help[Display the concise help for this command]' \
'-V[Display the uv version]' \
'--version[Display the uv version]' \
'*::package -- The package(s) to display:' \
&& ret=0
;;
(tree)
_arguments "${_arguments_options[@]}" : \
'-d+[Maximum display depth of the dependency tree]:DEPTH: ' \
'--depth=[Maximum display depth of the dependency tree]:DEPTH: ' \
'*--prune=[Prune the given package from the display of the dependency tree]:PRUNE: ' \
'*--package=[Display only the specified packages]:PACKAGE: ' \
'-p+[The Python interpreter for which packages should be listed.]:PYTHON: ' \
'--python=[The Python interpreter for which packages should be listed.]:PYTHON: ' \
'--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' \
'--python-preference=[Whether to prefer uv-managed or system Python installations]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' \
'--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' \
'(--no-color)--color=[Control colors in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' \
'--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' \
'--project=[Run the command within the given project directory]:PROJECT:_files' \
'--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' \
'--show-version-specifiers[Show the version constraint(s) imposed on each package]' \
'--no-dedupe[Do not de-duplicate repeated dependencies. Usually, when a package has already displayed its dependencies, further occurrences will not re-display its dependencies, and will include a (*) to indicate it has already been shown. This flag will cause those duplicates to be repeated]' \
'--invert[Show the reverse dependencies for the given package. This flag will invert the tree and display the packages that depend on the given package]' \
'--strict[Validate the Python environment, to detect packages with missing dependencies and other issues]' \
'--no-strict[]' \
'--system[List packages in the system Python environment]' \
'--no-system[]' \
'--disable-pip-version-check[]' \
'-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' \
'--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' \
'(-v --verbose)-q[Do not print any output]' \
'(-v --verbose)--quiet[Do not print any output]' \
'(-q --quiet)*-v[Use verbose output]' \
'(-q --quiet)*--verbose[Use verbose output]' \
'(--color)--no-color[Disable colors]' \
'--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' \
'--no-native-tls[]' \
'--offline[Disable network access]' \
'--no-offline[]' \
'--preview[Whether to enable experimental, preview features]' \
'--no-preview[]' \
'--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' \
'--show-settings[Show the resolved settings for the current command]' \
'--no-progress[Hide all progress outputs]' \
'--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' \
'-h[Display the concise help for this command]' \
'--help[Display the concise help for this command]' \
'-V[Display the uv version]' \
'--version[Display the uv version]' \
&& ret=0
;;
(check)
_arguments "${_arguments_options[@]}" : \
'-p+[The Python interpreter for which packages should be checked.]:PYTHON: ' \
'--python=[The Python interpreter for which packages should be checked.]:PYTHON: ' \
'--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' \
'--python-preference=[Whether to prefer uv-managed or system Python installations]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' \
'--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' \
'(--no-color)--color=[Control colors in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' \
'--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' \
'--project=[Run the command within the given project directory]:PROJECT:_files' \
'--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' \
'--system[Check packages in the system Python environment]' \
'--no-system[]' \
'-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' \
'--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' \
'(-v --verbose)-q[Do not print any output]' \
'(-v --verbose)--quiet[Do not print any output]' \
'(-q --quiet)*-v[Use verbose output]' \
'(-q --quiet)*--verbose[Use verbose output]' \
'(--color)--no-color[Disable colors]' \
'--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' \
'--no-native-tls[]' \
'--offline[Disable network access]' \
'--no-offline[]' \
'--preview[Whether to enable experimental, preview features]' \
'--no-preview[]' \
'--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' \
'--show-settings[Show the resolved settings for the current command]' \
'--no-progress[Hide all progress outputs]' \
'--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' \
'-h[Display the concise help for this command]' \
'--help[Display the concise help for this command]' \
'-V[Display the uv version]' \
'--version[Display the uv version]' \
&& ret=0
;;
        esac
    ;;
esac
;;
(venv)
_arguments "${_arguments_options[@]}" : \
'-p+[The Python interpreter to use for the virtual environment.]:PYTHON: ' \
'--python=[The Python interpreter to use for the virtual environment.]:PYTHON: ' \
'--prompt=[Provide an alternative prompt prefix for the virtual environment.]:PROMPT: ' \
'-i+[The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL: ' \
'--index-url=[The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL: ' \
'*--extra-index-url=[Extra URLs of package indexes to use, in addition to \`--index-url\`]:EXTRA_INDEX_URL: ' \
'*-f+[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS: ' \
'*--find-links=[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS: ' \
'--index-strategy=[The strategy to use when resolving against multiple index URLs]:INDEX_STRATEGY:((first-index\:"Only use results from the first index that returns a match for a given package name"
unsafe-first-match\:"Search for every package name across all indexes, exhausting the versions from the first index before moving on to the next"
unsafe-best-match\:"Search for every package name across all indexes, preferring the "best" version found. If a package version is in multiple indexes, only look at the entry for the first index"))' \
'--keyring-provider=[Attempt to use \`keyring\` for authentication for index URLs]:KEYRING_PROVIDER:((disabled\:"Do not use keyring for credential lookup"
subprocess\:"Use the \`keyring\` command for credential lookup"))' \
'*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST: ' \
'--exclude-newer=[Limit candidate packages to those that were uploaded prior to the given date]:EXCLUDE_NEWER: ' \
'--link-mode=[The method to use when installing packages from the global cache]:LINK_MODE:((clone\:"Clone (i.e., copy-on-write) packages from the wheel into the \`site-packages\` directory"
copy\:"Copy packages from the wheel into the \`site-packages\` directory"
hardlink\:"Hard link packages from the wheel into the \`site-packages\` directory"
symlink\:"Symbolically link packages from the wheel into the \`site-packages\` directory"))' \
'--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' \
'--python-preference=[Whether to prefer uv-managed or system Python installations]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' \
'--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' \
'(--no-color)--color=[Control colors in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' \
'--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' \
'--project=[Run the command within the given project directory]:PROJECT:_files' \
'--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' \
'--system[Ignore virtual environments when searching for the Python interpreter]' \
'--no-system[This flag is included for compatibility only, it has no effect]' \
'--no-project[Avoid discovering a project or workspace]' \
'--seed[Install seed packages (one or more of\: \`pip\`, \`setuptools\`, and \`wheel\`) into the virtual environment]' \
'--allow-existing[Preserve any existing files or directories at the target path]' \
'--system-site-packages[Give the virtual environment access to the system site packages directory]' \
'--relocatable[Make the virtual environment relocatable]' \
'--no-index[Ignore the registry index (e.g., PyPI), instead relying on direct URL dependencies and those provided via \`--find-links\`]' \
'--clear[]' \
'--no-seed[]' \
'--no-pip[]' \
'--no-setuptools[]' \
'--no-wheel[]' \
'-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' \
'--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' \
'(-v --verbose)-q[Do not print any output]' \
'(-v --verbose)--quiet[Do not print any output]' \
'(-q --quiet)*-v[Use verbose output]' \
'(-q --quiet)*--verbose[Use verbose output]' \
'(--color)--no-color[Disable colors]' \
'--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' \
'--no-native-tls[]' \
'--offline[Disable network access]' \
'--no-offline[]' \
'--preview[Whether to enable experimental, preview features]' \
'--no-preview[]' \
'--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' \
'--show-settings[Show the resolved settings for the current command]' \
'--no-progress[Hide all progress outputs]' \
'--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' \
'-h[Display the concise help for this command]' \
'--help[Display the concise help for this command]' \
'-V[Display the uv version]' \
'--version[Display the uv version]' \
'::path -- The path to the virtual environment to create:_files' \
&& ret=0
;;
(build)
_arguments "${_arguments_options[@]}" : \
'(--all)--package=[Build a specific package in the workspace]:PACKAGE: ' \
'-o+[The output directory to which distributions should be written]:OUT_DIR:_files' \
'--out-dir=[The output directory to which distributions should be written]:OUT_DIR:_files' \
'*-b+[Constrain build dependencies using the given requirements files when building distributions]:BUILD_CONSTRAINT: ' \
'*--build-constraint=[Constrain build dependencies using the given requirements files when building distributions]:BUILD_CONSTRAINT: ' \
'-p+[The Python interpreter to use for the build environment.]:PYTHON: ' \
'--python=[The Python interpreter to use for the build environment.]:PYTHON: ' \
'-i+[The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL: ' \
'--index-url=[The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL: ' \
'*--extra-index-url=[Extra URLs of package indexes to use, in addition to \`--index-url\`]:EXTRA_INDEX_URL: ' \
'*-f+[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS: ' \
'*--find-links=[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS: ' \
'*-P+[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE: ' \
'*--upgrade-package=[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE: ' \
'--index-strategy=[The strategy to use when resolving against multiple index URLs]:INDEX_STRATEGY:((first-index\:"Only use results from the first index that returns a match for a given package name"
unsafe-first-match\:"Search for every package name across all indexes, exhausting the versions from the first index before moving on to the next"
unsafe-best-match\:"Search for every package name across all indexes, preferring the "best" version found. If a package version is in multiple indexes, only look at the entry for the first index"))' \
'--keyring-provider=[Attempt to use \`keyring\` for authentication for index URLs]:KEYRING_PROVIDER:((disabled\:"Do not use keyring for credential lookup"
subprocess\:"Use the \`keyring\` command for credential lookup"))' \
'*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST: ' \
'--resolution=[The strategy to use when selecting between the different compatible versions for a given package requirement]:RESOLUTION:((highest\:"Resolve the highest compatible version of each package"
lowest\:"Resolve the lowest compatible version of each package"
lowest-direct\:"Resolve the lowest compatible version of any direct dependencies, and the highest compatible version of any transitive dependencies"))' \
'--prerelease=[The strategy to use when considering pre-release versions]:PRERELEASE:((disallow\:"Disallow all pre-release versions"
allow\:"Allow all pre-release versions"
if-necessary\:"Allow pre-release versions if all versions of a package are pre-release"
explicit\:"Allow pre-release versions for first-party packages with explicit pre-release markers in their version requirements"
if-necessary-or-explicit\:"Allow pre-release versions if all versions of a package are pre-release, or if the package has an explicit pre-release marker in its version requirements"))' \
'*-C+[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING: ' \
'*--config-setting=[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING: ' \
'*--no-build-isolation-package=[Disable isolation when building source distributions for a specific package]:NO_BUILD_ISOLATION_PACKAGE: ' \
'--exclude-newer=[Limit candidate packages to those that were uploaded prior to the given date]:EXCLUDE_NEWER: ' \
'--link-mode=[The method to use when installing packages from the global cache]:LINK_MODE:((clone\:"Clone (i.e., copy-on-write) packages from the wheel into the \`site-packages\` directory"
copy\:"Copy packages from the wheel into the \`site-packages\` directory"
hardlink\:"Hard link packages from the wheel into the \`site-packages\` directory"
symlink\:"Symbolically link packages from the wheel into the \`site-packages\` directory"))' \
'*--no-build-package=[Don'\''t build source distributions for a specific package]:NO_BUILD_PACKAGE: ' \
'*--no-binary-package=[Don'\''t install pre-built wheels for a specific package]:NO_BINARY_PACKAGE: ' \
'*--refresh-package=[Refresh cached data for a specific package]:REFRESH_PACKAGE: ' \
'--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' \
'--python-preference=[Whether to prefer uv-managed or system Python installations]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' \
'--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' \
'(--no-color)--color=[Control colors in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' \
'--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' \
'--project=[Run the command within the given project directory]:PROJECT:_files' \
'--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' \
'(--package)--all[Builds all packages in the workspace]' \
'--sdist[Build a source distribution ("sdist") from the given directory]' \
'--wheel[Build a binary distribution ("wheel") from the given directory]' \
'--build-logs[]' \
'--no-build-logs[Hide logs from the build backend]' \
'--require-hashes[Require a matching hash for each build requirement]' \
'--no-require-hashes[]' \
'--verify-hashes[Validate any hashes provided in the build constraints file]' \
'--no-verify-hashes[]' \
'--no-index[Ignore the registry index (e.g., PyPI), instead relying on direct URL dependencies and those provided via \`--find-links\`]' \
'-U[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' \
'--upgrade[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' \
'--no-upgrade[]' \
'--pre[]' \
'--no-build-isolation[Disable isolation when building source distributions]' \
'--build-isolation[]' \
'--no-sources[Ignore the \`tool.uv.sources\` table when resolving dependencies. Used to lock against the standards-compliant, publishable package metadata, as opposed to using any local or Git sources]' \
'--no-build[Don'\''t build source distributions]' \
'--build[]' \
'--no-binary[Don'\''t install pre-built wheels]' \
'--binary[]' \
'(--offline)--refresh[Refresh all cached data]' \
'(--offline)--no-refresh[]' \
'-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' \
'--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' \
'(-v --verbose)-q[Do not print any output]' \
'(-v --verbose)--quiet[Do not print any output]' \
'(-q --quiet)*-v[Use verbose output]' \
'(-q --quiet)*--verbose[Use verbose output]' \
'(--color)--no-color[Disable colors]' \
'--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' \
'--no-native-tls[]' \
'--offline[Disable network access]' \
'--no-offline[]' \
'--preview[Whether to enable experimental, preview features]' \
'--no-preview[]' \
'--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' \
'--show-settings[Show the resolved settings for the current command]' \
'--no-progress[Hide all progress outputs]' \
'--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' \
'-h[Display the concise help for this command]' \
'--help[Display the concise help for this command]' \
'-V[Display the uv version]' \
'--version[Display the uv version]' \
'::src -- The directory from which distributions should be built, or a source distribution archive to build into a wheel:_files' \
&& ret=0
;;
(publish)
_arguments "${_arguments_options[@]}" : \
'--publish-url=[The URL of the upload endpoint]:PUBLISH_URL: ' \
'-u+[The username for the upload]:USERNAME: ' \
'--username=[The username for the upload]:USERNAME: ' \
'-p+[The password for the upload]:PASSWORD: ' \
'--password=[The password for the upload]:PASSWORD: ' \
'(-u --username -p --password)-t+[The token for the upload]:TOKEN: ' \
'(-u --username -p --password)--token=[The token for the upload]:TOKEN: ' \
'--trusted-publishing=[Configure using trusted publishing through GitHub Actions]:TRUSTED_PUBLISHING:((automatic\:"Try trusted publishing when we'\''re already in GitHub Actions, continue if that fails"
always\:""
never\:""))' \
'--keyring-provider=[Attempt to use \`keyring\` for authentication for remote requirements files]:KEYRING_PROVIDER:((disabled\:"Do not use keyring for credential lookup"
subprocess\:"Use the \`keyring\` command for credential lookup"))' \
'*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST: ' \
'--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' \
'--python-preference=[Whether to prefer uv-managed or system Python installations]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' \
'--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' \
'(--no-color)--color=[Control colors in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' \
'--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' \
'--project=[Run the command within the given project directory]:PROJECT:_files' \
'--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' \
'-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' \
'--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' \
'(-v --verbose)-q[Do not print any output]' \
'(-v --verbose)--quiet[Do not print any output]' \
'(-q --quiet)*-v[Use verbose output]' \
'(-q --quiet)*--verbose[Use verbose output]' \
'(--color)--no-color[Disable colors]' \
'--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' \
'--no-native-tls[]' \
'--offline[Disable network access]' \
'--no-offline[]' \
'--preview[Whether to enable experimental, preview features]' \
'--no-preview[]' \
'--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' \
'--show-settings[Show the resolved settings for the current command]' \
'--no-progress[Hide all progress outputs]' \
'--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' \
'-h[Display the concise help for this command]' \
'--help[Display the concise help for this command]' \
'-V[Display the uv version]' \
'--version[Display the uv version]' \
'*::files -- Paths to the files to upload. Accepts glob expressions:' \
&& ret=0
;;
(build-backend)
_arguments "${_arguments_options[@]}" : \
'--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' \
'--python-preference=[Whether to prefer uv-managed or system Python installations]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' \
'--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' \
'(--no-color)--color=[Control colors in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' \
'--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' \
'--project=[Run the command within the given project directory]:PROJECT:_files' \
'--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' \
'-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' \
'--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' \
'(-v --verbose)-q[Do not print any output]' \
'(-v --verbose)--quiet[Do not print any output]' \
'(-q --quiet)*-v[Use verbose output]' \
'(-q --quiet)*--verbose[Use verbose output]' \
'(--color)--no-color[Disable colors]' \
'--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' \
'--no-native-tls[]' \
'--offline[Disable network access]' \
'--no-offline[]' \
'--preview[Whether to enable experimental, preview features]' \
'--no-preview[]' \
'--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' \
'--show-settings[Show the resolved settings for the current command]' \
'--no-progress[Hide all progress outputs]' \
'--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' \
'-h[Display the concise help for this command]' \
'--help[Display the concise help for this command]' \
'-V[Display the uv version]' \
'--version[Display the uv version]' \
":: :_uv__build-backend_commands" \
"*::: :->build-backend" \
&& ret=0

    case $state in
    (build-backend)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:uv-build-backend-command-$line[1]:"
        case $line[1] in
            (build-sdist)
_arguments "${_arguments_options[@]}" : \
'--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' \
'--python-preference=[Whether to prefer uv-managed or system Python installations]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' \
'--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' \
'(--no-color)--color=[Control colors in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' \
'--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' \
'--project=[Run the command within the given project directory]:PROJECT:_files' \
'--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' \
'-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' \
'--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' \
'(-v --verbose)-q[Do not print any output]' \
'(-v --verbose)--quiet[Do not print any output]' \
'(-q --quiet)*-v[Use verbose output]' \
'(-q --quiet)*--verbose[Use verbose output]' \
'(--color)--no-color[Disable colors]' \
'--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' \
'--no-native-tls[]' \
'--offline[Disable network access]' \
'--no-offline[]' \
'--preview[Whether to enable experimental, preview features]' \
'--no-preview[]' \
'--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' \
'--show-settings[Show the resolved settings for the current command]' \
'--no-progress[Hide all progress outputs]' \
'--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' \
'-h[Display the concise help for this command]' \
'--help[Display the concise help for this command]' \
'-V[Display the uv version]' \
'--version[Display the uv version]' \
':sdist_directory:_files' \
&& ret=0
;;
(build-wheel)
_arguments "${_arguments_options[@]}" : \
'--metadata-directory=[]:METADATA_DIRECTORY:_files' \
'--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' \
'--python-preference=[Whether to prefer uv-managed or system Python installations]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' \
'--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' \
'(--no-color)--color=[Control colors in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' \
'--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' \
'--project=[Run the command within the given project directory]:PROJECT:_files' \
'--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' \
'-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' \
'--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' \
'(-v --verbose)-q[Do not print any output]' \
'(-v --verbose)--quiet[Do not print any output]' \
'(-q --quiet)*-v[Use verbose output]' \
'(-q --quiet)*--verbose[Use verbose output]' \
'(--color)--no-color[Disable colors]' \
'--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' \
'--no-native-tls[]' \
'--offline[Disable network access]' \
'--no-offline[]' \
'--preview[Whether to enable experimental, preview features]' \
'--no-preview[]' \
'--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' \
'--show-settings[Show the resolved settings for the current command]' \
'--no-progress[Hide all progress outputs]' \
'--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' \
'-h[Display the concise help for this command]' \
'--help[Display the concise help for this command]' \
'-V[Display the uv version]' \
'--version[Display the uv version]' \
':wheel_directory:_files' \
&& ret=0
;;
(build-editable)
_arguments "${_arguments_options[@]}" : \
'--metadata-directory=[]:METADATA_DIRECTORY:_files' \
'--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' \
'--python-preference=[Whether to prefer uv-managed or system Python installations]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' \
'--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' \
'(--no-color)--color=[Control colors in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' \
'--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' \
'--project=[Run the command within the given project directory]:PROJECT:_files' \
'--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' \
'-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' \
'--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' \
'(-v --verbose)-q[Do not print any output]' \
'(-v --verbose)--quiet[Do not print any output]' \
'(-q --quiet)*-v[Use verbose output]' \
'(-q --quiet)*--verbose[Use verbose output]' \
'(--color)--no-color[Disable colors]' \
'--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' \
'--no-native-tls[]' \
'--offline[Disable network access]' \
'--no-offline[]' \
'--preview[Whether to enable experimental, preview features]' \
'--no-preview[]' \
'--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' \
'--show-settings[Show the resolved settings for the current command]' \
'--no-progress[Hide all progress outputs]' \
'--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' \
'-h[Display the concise help for this command]' \
'--help[Display the concise help for this command]' \
'-V[Display the uv version]' \
'--version[Display the uv version]' \
':wheel_directory:_files' \
&& ret=0
;;
(get-requires-for-build-sdist)
_arguments "${_arguments_options[@]}" : \
'--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' \
'--python-preference=[Whether to prefer uv-managed or system Python installations]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' \
'--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' \
'(--no-color)--color=[Control colors in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' \
'--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' \
'--project=[Run the command within the given project directory]:PROJECT:_files' \
'--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' \
'-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' \
'--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' \
'(-v --verbose)-q[Do not print any output]' \
'(-v --verbose)--quiet[Do not print any output]' \
'(-q --quiet)*-v[Use verbose output]' \
'(-q --quiet)*--verbose[Use verbose output]' \
'(--color)--no-color[Disable colors]' \
'--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' \
'--no-native-tls[]' \
'--offline[Disable network access]' \
'--no-offline[]' \
'--preview[Whether to enable experimental, preview features]' \
'--no-preview[]' \
'--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' \
'--show-settings[Show the resolved settings for the current command]' \
'--no-progress[Hide all progress outputs]' \
'--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' \
'-h[Display the concise help for this command]' \
'--help[Display the concise help for this command]' \
'-V[Display the uv version]' \
'--version[Display the uv version]' \
&& ret=0
;;
(get-requires-for-build-wheel)
_arguments "${_arguments_options[@]}" : \
'--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' \
'--python-preference=[Whether to prefer uv-managed or system Python installations]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' \
'--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' \
'(--no-color)--color=[Control colors in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' \
'--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' \
'--project=[Run the command within the given project directory]:PROJECT:_files' \
'--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' \
'-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' \
'--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' \
'(-v --verbose)-q[Do not print any output]' \
'(-v --verbose)--quiet[Do not print any output]' \
'(-q --quiet)*-v[Use verbose output]' \
'(-q --quiet)*--verbose[Use verbose output]' \
'(--color)--no-color[Disable colors]' \
'--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' \
'--no-native-tls[]' \
'--offline[Disable network access]' \
'--no-offline[]' \
'--preview[Whether to enable experimental, preview features]' \
'--no-preview[]' \
'--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' \
'--show-settings[Show the resolved settings for the current command]' \
'--no-progress[Hide all progress outputs]' \
'--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' \
'-h[Display the concise help for this command]' \
'--help[Display the concise help for this command]' \
'-V[Display the uv version]' \
'--version[Display the uv version]' \
&& ret=0
;;
(prepare-metadata-for-build-wheel)
_arguments "${_arguments_options[@]}" : \
'--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' \
'--python-preference=[Whether to prefer uv-managed or system Python installations]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' \
'--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' \
'(--no-color)--color=[Control colors in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' \
'--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' \
'--project=[Run the command within the given project directory]:PROJECT:_files' \
'--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' \
'-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' \
'--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' \
'(-v --verbose)-q[Do not print any output]' \
'(-v --verbose)--quiet[Do not print any output]' \
'(-q --quiet)*-v[Use verbose output]' \
'(-q --quiet)*--verbose[Use verbose output]' \
'(--color)--no-color[Disable colors]' \
'--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' \
'--no-native-tls[]' \
'--offline[Disable network access]' \
'--no-offline[]' \
'--preview[Whether to enable experimental, preview features]' \
'--no-preview[]' \
'--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' \
'--show-settings[Show the resolved settings for the current command]' \
'--no-progress[Hide all progress outputs]' \
'--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' \
'-h[Display the concise help for this command]' \
'--help[Display the concise help for this command]' \
'-V[Display the uv version]' \
'--version[Display the uv version]' \
':wheel_directory:_files' \
&& ret=0
;;
(get-requires-for-build-editable)
_arguments "${_arguments_options[@]}" : \
'--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' \
'--python-preference=[Whether to prefer uv-managed or system Python installations]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' \
'--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' \
'(--no-color)--color=[Control colors in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' \
'--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' \
'--project=[Run the command within the given project directory]:PROJECT:_files' \
'--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' \
'-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' \
'--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' \
'(-v --verbose)-q[Do not print any output]' \
'(-v --verbose)--quiet[Do not print any output]' \
'(-q --quiet)*-v[Use verbose output]' \
'(-q --quiet)*--verbose[Use verbose output]' \
'(--color)--no-color[Disable colors]' \
'--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' \
'--no-native-tls[]' \
'--offline[Disable network access]' \
'--no-offline[]' \
'--preview[Whether to enable experimental, preview features]' \
'--no-preview[]' \
'--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' \
'--show-settings[Show the resolved settings for the current command]' \
'--no-progress[Hide all progress outputs]' \
'--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' \
'-h[Display the concise help for this command]' \
'--help[Display the concise help for this command]' \
'-V[Display the uv version]' \
'--version[Display the uv version]' \
&& ret=0
;;
(prepare-metadata-for-build-editable)
_arguments "${_arguments_options[@]}" : \
'--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' \
'--python-preference=[Whether to prefer uv-managed or system Python installations]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' \
'--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' \
'(--no-color)--color=[Control colors in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' \
'--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' \
'--project=[Run the command within the given project directory]:PROJECT:_files' \
'--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' \
'-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' \
'--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' \
'(-v --verbose)-q[Do not print any output]' \
'(-v --verbose)--quiet[Do not print any output]' \
'(-q --quiet)*-v[Use verbose output]' \
'(-q --quiet)*--verbose[Use verbose output]' \
'(--color)--no-color[Disable colors]' \
'--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' \
'--no-native-tls[]' \
'--offline[Disable network access]' \
'--no-offline[]' \
'--preview[Whether to enable experimental, preview features]' \
'--no-preview[]' \
'--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' \
'--show-settings[Show the resolved settings for the current command]' \
'--no-progress[Hide all progress outputs]' \
'--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' \
'-h[Display the concise help for this command]' \
'--help[Display the concise help for this command]' \
'-V[Display the uv version]' \
'--version[Display the uv version]' \
':wheel_directory:_files' \
&& ret=0
;;
        esac
    ;;
esac
;;
(cache)
_arguments "${_arguments_options[@]}" : \
'--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' \
'--python-preference=[Whether to prefer uv-managed or system Python installations]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' \
'--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' \
'(--no-color)--color=[Control colors in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' \
'--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' \
'--project=[Run the command within the given project directory]:PROJECT:_files' \
'--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' \
'-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' \
'--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' \
'(-v --verbose)-q[Do not print any output]' \
'(-v --verbose)--quiet[Do not print any output]' \
'(-q --quiet)*-v[Use verbose output]' \
'(-q --quiet)*--verbose[Use verbose output]' \
'(--color)--no-color[Disable colors]' \
'--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' \
'--no-native-tls[]' \
'--offline[Disable network access]' \
'--no-offline[]' \
'--preview[Whether to enable experimental, preview features]' \
'--no-preview[]' \
'--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' \
'--show-settings[Show the resolved settings for the current command]' \
'--no-progress[Hide all progress outputs]' \
'--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' \
'-h[Display the concise help for this command]' \
'--help[Display the concise help for this command]' \
'-V[Display the uv version]' \
'--version[Display the uv version]' \
":: :_uv__cache_commands" \
"*::: :->cache" \
&& ret=0

    case $state in
    (cache)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:uv-cache-command-$line[1]:"
        case $line[1] in
            (clean)
_arguments "${_arguments_options[@]}" : \
'--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' \
'--python-preference=[Whether to prefer uv-managed or system Python installations]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' \
'--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' \
'(--no-color)--color=[Control colors in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' \
'--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' \
'--project=[Run the command within the given project directory]:PROJECT:_files' \
'--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' \
'-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' \
'--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' \
'(-v --verbose)-q[Do not print any output]' \
'(-v --verbose)--quiet[Do not print any output]' \
'(-q --quiet)*-v[Use verbose output]' \
'(-q --quiet)*--verbose[Use verbose output]' \
'(--color)--no-color[Disable colors]' \
'--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' \
'--no-native-tls[]' \
'--offline[Disable network access]' \
'--no-offline[]' \
'--preview[Whether to enable experimental, preview features]' \
'--no-preview[]' \
'--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' \
'--show-settings[Show the resolved settings for the current command]' \
'--no-progress[Hide all progress outputs]' \
'--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' \
'-h[Display the concise help for this command]' \
'--help[Display the concise help for this command]' \
'-V[Display the uv version]' \
'--version[Display the uv version]' \
'*::package -- The packages to remove from the cache:' \
&& ret=0
;;
(prune)
_arguments "${_arguments_options[@]}" : \
'--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' \
'--python-preference=[Whether to prefer uv-managed or system Python installations]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' \
'--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' \
'(--no-color)--color=[Control colors in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' \
'--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' \
'--project=[Run the command within the given project directory]:PROJECT:_files' \
'--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' \
'--ci[Optimize the cache for persistence in a continuous integration environment, like GitHub Actions]' \
'-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' \
'--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' \
'(-v --verbose)-q[Do not print any output]' \
'(-v --verbose)--quiet[Do not print any output]' \
'(-q --quiet)*-v[Use verbose output]' \
'(-q --quiet)*--verbose[Use verbose output]' \
'(--color)--no-color[Disable colors]' \
'--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' \
'--no-native-tls[]' \
'--offline[Disable network access]' \
'--no-offline[]' \
'--preview[Whether to enable experimental, preview features]' \
'--no-preview[]' \
'--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' \
'--show-settings[Show the resolved settings for the current command]' \
'--no-progress[Hide all progress outputs]' \
'--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' \
'-h[Display the concise help for this command]' \
'--help[Display the concise help for this command]' \
'-V[Display the uv version]' \
'--version[Display the uv version]' \
&& ret=0
;;
(dir)
_arguments "${_arguments_options[@]}" : \
'--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' \
'--python-preference=[Whether to prefer uv-managed or system Python installations]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' \
'--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' \
'(--no-color)--color=[Control colors in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' \
'--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' \
'--project=[Run the command within the given project directory]:PROJECT:_files' \
'--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' \
'-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' \
'--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' \
'(-v --verbose)-q[Do not print any output]' \
'(-v --verbose)--quiet[Do not print any output]' \
'(-q --quiet)*-v[Use verbose output]' \
'(-q --quiet)*--verbose[Use verbose output]' \
'(--color)--no-color[Disable colors]' \
'--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' \
'--no-native-tls[]' \
'--offline[Disable network access]' \
'--no-offline[]' \
'--preview[Whether to enable experimental, preview features]' \
'--no-preview[]' \
'--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' \
'--show-settings[Show the resolved settings for the current command]' \
'--no-progress[Hide all progress outputs]' \
'--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' \
'-h[Display the concise help for this command]' \
'--help[Display the concise help for this command]' \
'-V[Display the uv version]' \
'--version[Display the uv version]' \
&& ret=0
;;
        esac
    ;;
esac
;;
(self)
_arguments "${_arguments_options[@]}" : \
'--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' \
'--python-preference=[Whether to prefer uv-managed or system Python installations]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' \
'--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' \
'(--no-color)--color=[Control colors in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' \
'--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' \
'--project=[Run the command within the given project directory]:PROJECT:_files' \
'--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' \
'-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' \
'--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' \
'(-v --verbose)-q[Do not print any output]' \
'(-v --verbose)--quiet[Do not print any output]' \
'(-q --quiet)*-v[Use verbose output]' \
'(-q --quiet)*--verbose[Use verbose output]' \
'(--color)--no-color[Disable colors]' \
'--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' \
'--no-native-tls[]' \
'--offline[Disable network access]' \
'--no-offline[]' \
'--preview[Whether to enable experimental, preview features]' \
'--no-preview[]' \
'--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' \
'--show-settings[Show the resolved settings for the current command]' \
'--no-progress[Hide all progress outputs]' \
'--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' \
'-h[Display the concise help for this command]' \
'--help[Display the concise help for this command]' \
'-V[Display the uv version]' \
'--version[Display the uv version]' \
":: :_uv__self_commands" \
"*::: :->self" \
&& ret=0

    case $state in
    (self)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:uv-self-command-$line[1]:"
        case $line[1] in
            (update)
_arguments "${_arguments_options[@]}" : \
'--token=[A GitHub token for authentication. A token is not required but can be used to reduce the chance of encountering rate limits]:TOKEN: ' \
'--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' \
'--python-preference=[Whether to prefer uv-managed or system Python installations]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' \
'--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' \
'(--no-color)--color=[Control colors in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' \
'--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' \
'--project=[Run the command within the given project directory]:PROJECT:_files' \
'--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' \
'-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' \
'--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' \
'(-v --verbose)-q[Do not print any output]' \
'(-v --verbose)--quiet[Do not print any output]' \
'(-q --quiet)*-v[Use verbose output]' \
'(-q --quiet)*--verbose[Use verbose output]' \
'(--color)--no-color[Disable colors]' \
'--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' \
'--no-native-tls[]' \
'--offline[Disable network access]' \
'--no-offline[]' \
'--preview[Whether to enable experimental, preview features]' \
'--no-preview[]' \
'--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' \
'--show-settings[Show the resolved settings for the current command]' \
'--no-progress[Hide all progress outputs]' \
'--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' \
'-h[Display the concise help for this command]' \
'--help[Display the concise help for this command]' \
'-V[Display the uv version]' \
'--version[Display the uv version]' \
'::target_version -- Update to the specified version. If not provided, uv will update to the latest version:' \
&& ret=0
;;
        esac
    ;;
esac
;;
(clean)
_arguments "${_arguments_options[@]}" : \
'--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' \
'--python-preference=[Whether to prefer uv-managed or system Python installations]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' \
'--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' \
'(--no-color)--color=[Control colors in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' \
'--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' \
'--project=[Run the command within the given project directory]:PROJECT:_files' \
'--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' \
'-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' \
'--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' \
'(-v --verbose)-q[Do not print any output]' \
'(-v --verbose)--quiet[Do not print any output]' \
'(-q --quiet)*-v[Use verbose output]' \
'(-q --quiet)*--verbose[Use verbose output]' \
'(--color)--no-color[Disable colors]' \
'--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' \
'--no-native-tls[]' \
'--offline[Disable network access]' \
'--no-offline[]' \
'--preview[Whether to enable experimental, preview features]' \
'--no-preview[]' \
'--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' \
'--show-settings[Show the resolved settings for the current command]' \
'--no-progress[Hide all progress outputs]' \
'--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' \
'-h[Display the concise help for this command]' \
'--help[Display the concise help for this command]' \
'-V[Display the uv version]' \
'--version[Display the uv version]' \
'*::package -- The packages to remove from the cache:' \
&& ret=0
;;
(version)
_arguments "${_arguments_options[@]}" : \
'--output-format=[]:OUTPUT_FORMAT:((text\:"Display the version as plain text"
json\:"Display the version as JSON"))' \
'--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' \
'--python-preference=[Whether to prefer uv-managed or system Python installations]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' \
'--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' \
'(--no-color)--color=[Control colors in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' \
'--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' \
'--project=[Run the command within the given project directory]:PROJECT:_files' \
'--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' \
'-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' \
'--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' \
'(-v --verbose)-q[Do not print any output]' \
'(-v --verbose)--quiet[Do not print any output]' \
'(-q --quiet)*-v[Use verbose output]' \
'(-q --quiet)*--verbose[Use verbose output]' \
'(--color)--no-color[Disable colors]' \
'--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' \
'--no-native-tls[]' \
'--offline[Disable network access]' \
'--no-offline[]' \
'--preview[Whether to enable experimental, preview features]' \
'--no-preview[]' \
'--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' \
'--show-settings[Show the resolved settings for the current command]' \
'--no-progress[Hide all progress outputs]' \
'--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' \
'-h[Display the concise help for this command]' \
'--help[Display the concise help for this command]' \
'-V[Display the uv version]' \
'--version[Display the uv version]' \
&& ret=0
;;
(generate-shell-completion)
_arguments "${_arguments_options[@]}" : \
'--cache-dir=[]:CACHE_DIR:_files' \
'--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' \
'(--no-color)--color=[]:COLOR:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' \
'--config-file=[]:CONFIG_FILE:_files' \
'--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' \
'--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' \
'--project=[Run the command within the given project directory]:PROJECT:_files' \
'-n[]' \
'--no-cache[]' \
'--no-python-downloads[]' \
'(-v --verbose)-q[]' \
'(-v --verbose)--quiet[]' \
'(-q --quiet)*-v[]' \
'(-q --quiet)*--verbose[]' \
'--native-tls[]' \
'--offline[]' \
'--no-progress[]' \
'--no-config[]' \
'-h[]' \
'--help[]' \
'-V[]' \
'--version[]' \
'--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' \
'(--color)--no-color[Disable colors]' \
'--no-native-tls[]' \
'--no-offline[]' \
'--preview[Whether to enable experimental, preview features]' \
'--no-preview[]' \
'--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' \
'--show-settings[Show the resolved settings for the current command]' \
':shell -- The shell to generate the completion script for:(bash elvish fish nushell powershell zsh)' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
'--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' \
'--python-preference=[Whether to prefer uv-managed or system Python installations]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' \
'--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' \
'(--no-color)--color=[Control colors in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' \
'--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' \
'--project=[Run the command within the given project directory]:PROJECT:_files' \
'--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' \
'--no-pager[Disable pager when printing help]' \
'-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' \
'--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' \
'--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' \
'(-v --verbose)-q[Do not print any output]' \
'(-v --verbose)--quiet[Do not print any output]' \
'(-q --quiet)*-v[Use verbose output]' \
'(-q --quiet)*--verbose[Use verbose output]' \
'(--color)--no-color[Disable colors]' \
'--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' \
'--no-native-tls[]' \
'--offline[Disable network access]' \
'--no-offline[]' \
'--preview[Whether to enable experimental, preview features]' \
'--no-preview[]' \
'--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' \
'--show-settings[Show the resolved settings for the current command]' \
'--no-progress[Hide all progress outputs]' \
'--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' \
'-h[Display the concise help for this command]' \
'--help[Display the concise help for this command]' \
'-V[Display the uv version]' \
'--version[Display the uv version]' \
'*::command:' \
&& ret=0
;;
        esac
    ;;
esac
}

(( $+functions[_uv_commands] )) ||
_uv_commands() {
    local commands; commands=(
'run:Run a command or script' \
'init:Create a new project' \
'add:Add dependencies to the project' \
'remove:Remove dependencies from the project' \
'sync:Update the project'\''s environment' \
'lock:Update the project'\''s lockfile' \
'export:Export the project'\''s lockfile to an alternate format' \
'tree:Display the project'\''s dependency tree' \
'tool:Run and install commands provided by Python packages' \
'python:Manage Python versions and installations' \
'pip:Manage Python packages with a pip-compatible interface' \
'venv:Create a virtual environment' \
'build:Build Python packages into source distributions and wheels' \
'publish:Upload distributions to an index' \
'build-backend:The implementation of the build backend' \
'cache:Manage uv'\''s cache' \
'self:Manage the uv executable' \
'clean:Clear the cache, removing all entries or those linked to specific packages' \
'version:Display uv'\''s version' \
'generate-shell-completion:Generate shell completion' \
'help:Display documentation for a command' \
    )
    _describe -t commands 'uv commands' commands "$@"
}
(( $+functions[_uv__add_commands] )) ||
_uv__add_commands() {
    local commands; commands=()
    _describe -t commands 'uv add commands' commands "$@"
}
(( $+functions[_uv__build_commands] )) ||
_uv__build_commands() {
    local commands; commands=()
    _describe -t commands 'uv build commands' commands "$@"
}
(( $+functions[_uv__build-backend_commands] )) ||
_uv__build-backend_commands() {
    local commands; commands=(
'build-sdist:PEP 517 hook \`build_sdist\`' \
'build-wheel:PEP 517 hook \`build_wheel\`' \
'build-editable:PEP 660 hook \`build_editable\`' \
'get-requires-for-build-sdist:PEP 517 hook \`get_requires_for_build_sdist\`' \
'get-requires-for-build-wheel:PEP 517 hook \`get_requires_for_build_wheel\`' \
'prepare-metadata-for-build-wheel:PEP 517 hook \`prepare_metadata_for_build_wheel\`' \
'get-requires-for-build-editable:PEP 660 hook \`get_requires_for_build_editable\`' \
'prepare-metadata-for-build-editable:PEP 660 hook \`prepare_metadata_for_build_editable\`' \
    )
    _describe -t commands 'uv build-backend commands' commands "$@"
}
(( $+functions[_uv__build-backend__build-editable_commands] )) ||
_uv__build-backend__build-editable_commands() {
    local commands; commands=()
    _describe -t commands 'uv build-backend build-editable commands' commands "$@"
}
(( $+functions[_uv__build-backend__build-sdist_commands] )) ||
_uv__build-backend__build-sdist_commands() {
    local commands; commands=()
    _describe -t commands 'uv build-backend build-sdist commands' commands "$@"
}
(( $+functions[_uv__build-backend__build-wheel_commands] )) ||
_uv__build-backend__build-wheel_commands() {
    local commands; commands=()
    _describe -t commands 'uv build-backend build-wheel commands' commands "$@"
}
(( $+functions[_uv__build-backend__get-requires-for-build-editable_commands] )) ||
_uv__build-backend__get-requires-for-build-editable_commands() {
    local commands; commands=()
    _describe -t commands 'uv build-backend get-requires-for-build-editable commands' commands "$@"
}
(( $+functions[_uv__build-backend__get-requires-for-build-sdist_commands] )) ||
_uv__build-backend__get-requires-for-build-sdist_commands() {
    local commands; commands=()
    _describe -t commands 'uv build-backend get-requires-for-build-sdist commands' commands "$@"
}
(( $+functions[_uv__build-backend__get-requires-for-build-wheel_commands] )) ||
_uv__build-backend__get-requires-for-build-wheel_commands() {
    local commands; commands=()
    _describe -t commands 'uv build-backend get-requires-for-build-wheel commands' commands "$@"
}
(( $+functions[_uv__build-backend__prepare-metadata-for-build-editable_commands] )) ||
_uv__build-backend__prepare-metadata-for-build-editable_commands() {
    local commands; commands=()
    _describe -t commands 'uv build-backend prepare-metadata-for-build-editable commands' commands "$@"
}
(( $+functions[_uv__build-backend__prepare-metadata-for-build-wheel_commands] )) ||
_uv__build-backend__prepare-metadata-for-build-wheel_commands() {
    local commands; commands=()
    _describe -t commands 'uv build-backend prepare-metadata-for-build-wheel commands' commands "$@"
}
(( $+functions[_uv__cache_commands] )) ||
_uv__cache_commands() {
    local commands; commands=(
'clean:Clear the cache, removing all entries or those linked to specific packages' \
'prune:Prune all unreachable objects from the cache' \
'dir:Show the cache directory' \
    )
    _describe -t commands 'uv cache commands' commands "$@"
}
(( $+functions[_uv__cache__clean_commands] )) ||
_uv__cache__clean_commands() {
    local commands; commands=()
    _describe -t commands 'uv cache clean commands' commands "$@"
}
(( $+functions[_uv__cache__dir_commands] )) ||
_uv__cache__dir_commands() {
    local commands; commands=()
    _describe -t commands 'uv cache dir commands' commands "$@"
}
(( $+functions[_uv__cache__prune_commands] )) ||
_uv__cache__prune_commands() {
    local commands; commands=()
    _describe -t commands 'uv cache prune commands' commands "$@"
}
(( $+functions[_uv__clean_commands] )) ||
_uv__clean_commands() {
    local commands; commands=()
    _describe -t commands 'uv clean commands' commands "$@"
}
(( $+functions[_uv__export_commands] )) ||
_uv__export_commands() {
    local commands; commands=()
    _describe -t commands 'uv export commands' commands "$@"
}
(( $+functions[_uv__generate-shell-completion_commands] )) ||
_uv__generate-shell-completion_commands() {
    local commands; commands=()
    _describe -t commands 'uv generate-shell-completion commands' commands "$@"
}
(( $+functions[_uv__help_commands] )) ||
_uv__help_commands() {
    local commands; commands=()
    _describe -t commands 'uv help commands' commands "$@"
}
(( $+functions[_uv__init_commands] )) ||
_uv__init_commands() {
    local commands; commands=()
    _describe -t commands 'uv init commands' commands "$@"
}
(( $+functions[_uv__lock_commands] )) ||
_uv__lock_commands() {
    local commands; commands=()
    _describe -t commands 'uv lock commands' commands "$@"
}
(( $+functions[_uv__pip_commands] )) ||
_uv__pip_commands() {
    local commands; commands=(
'compile:Compile a \`requirements.in\` file to a \`requirements.txt\` file' \
'sync:Sync an environment with a \`requirements.txt\` file' \
'install:Install packages into an environment' \
'uninstall:Uninstall packages from an environment' \
'freeze:List, in requirements format, packages installed in an environment' \
'list:List, in tabular format, packages installed in an environment' \
'show:Show information about one or more installed packages' \
'tree:Display the dependency tree for an environment' \
'check:Verify installed packages have compatible dependencies' \
    )
    _describe -t commands 'uv pip commands' commands "$@"
}
(( $+functions[_uv__pip__check_commands] )) ||
_uv__pip__check_commands() {
    local commands; commands=()
    _describe -t commands 'uv pip check commands' commands "$@"
}
(( $+functions[_uv__pip__compile_commands] )) ||
_uv__pip__compile_commands() {
    local commands; commands=()
    _describe -t commands 'uv pip compile commands' commands "$@"
}
(( $+functions[_uv__pip__freeze_commands] )) ||
_uv__pip__freeze_commands() {
    local commands; commands=()
    _describe -t commands 'uv pip freeze commands' commands "$@"
}
(( $+functions[_uv__pip__install_commands] )) ||
_uv__pip__install_commands() {
    local commands; commands=()
    _describe -t commands 'uv pip install commands' commands "$@"
}
(( $+functions[_uv__pip__list_commands] )) ||
_uv__pip__list_commands() {
    local commands; commands=()
    _describe -t commands 'uv pip list commands' commands "$@"
}
(( $+functions[_uv__pip__show_commands] )) ||
_uv__pip__show_commands() {
    local commands; commands=()
    _describe -t commands 'uv pip show commands' commands "$@"
}
(( $+functions[_uv__pip__sync_commands] )) ||
_uv__pip__sync_commands() {
    local commands; commands=()
    _describe -t commands 'uv pip sync commands' commands "$@"
}
(( $+functions[_uv__pip__tree_commands] )) ||
_uv__pip__tree_commands() {
    local commands; commands=()
    _describe -t commands 'uv pip tree commands' commands "$@"
}
(( $+functions[_uv__pip__uninstall_commands] )) ||
_uv__pip__uninstall_commands() {
    local commands; commands=()
    _describe -t commands 'uv pip uninstall commands' commands "$@"
}
(( $+functions[_uv__publish_commands] )) ||
_uv__publish_commands() {
    local commands; commands=()
    _describe -t commands 'uv publish commands' commands "$@"
}
(( $+functions[_uv__python_commands] )) ||
_uv__python_commands() {
    local commands; commands=(
'list:List the available Python installations' \
'install:Download and install Python versions' \
'find:Search for a Python installation' \
'pin:Pin to a specific Python version' \
'dir:Show the uv Python installation directory' \
'uninstall:Uninstall Python versions' \
    )
    _describe -t commands 'uv python commands' commands "$@"
}
(( $+functions[_uv__python__dir_commands] )) ||
_uv__python__dir_commands() {
    local commands; commands=()
    _describe -t commands 'uv python dir commands' commands "$@"
}
(( $+functions[_uv__python__find_commands] )) ||
_uv__python__find_commands() {
    local commands; commands=()
    _describe -t commands 'uv python find commands' commands "$@"
}
(( $+functions[_uv__python__install_commands] )) ||
_uv__python__install_commands() {
    local commands; commands=()
    _describe -t commands 'uv python install commands' commands "$@"
}
(( $+functions[_uv__python__list_commands] )) ||
_uv__python__list_commands() {
    local commands; commands=()
    _describe -t commands 'uv python list commands' commands "$@"
}
(( $+functions[_uv__python__pin_commands] )) ||
_uv__python__pin_commands() {
    local commands; commands=()
    _describe -t commands 'uv python pin commands' commands "$@"
}
(( $+functions[_uv__python__uninstall_commands] )) ||
_uv__python__uninstall_commands() {
    local commands; commands=()
    _describe -t commands 'uv python uninstall commands' commands "$@"
}
(( $+functions[_uv__remove_commands] )) ||
_uv__remove_commands() {
    local commands; commands=()
    _describe -t commands 'uv remove commands' commands "$@"
}
(( $+functions[_uv__run_commands] )) ||
_uv__run_commands() {
    local commands; commands=()
    _describe -t commands 'uv run commands' commands "$@"
}
(( $+functions[_uv__self_commands] )) ||
_uv__self_commands() {
    local commands; commands=(
'update:Update uv' \
    )
    _describe -t commands 'uv self commands' commands "$@"
}
(( $+functions[_uv__self__update_commands] )) ||
_uv__self__update_commands() {
    local commands; commands=()
    _describe -t commands 'uv self update commands' commands "$@"
}
(( $+functions[_uv__sync_commands] )) ||
_uv__sync_commands() {
    local commands; commands=()
    _describe -t commands 'uv sync commands' commands "$@"
}
(( $+functions[_uv__tool_commands] )) ||
_uv__tool_commands() {
    local commands; commands=(
'run:Run a command provided by a Python package' \
'uvx:Run a command provided by a Python package.' \
'install:Install commands provided by a Python package' \
'upgrade:Upgrade installed tools' \
'list:List installed tools' \
'uninstall:Uninstall a tool' \
'update-shell:Ensure that the tool executable directory is on the \`PATH\`' \
'dir:Show the path to the uv tools directory' \
    )
    _describe -t commands 'uv tool commands' commands "$@"
}
(( $+functions[_uv__tool__dir_commands] )) ||
_uv__tool__dir_commands() {
    local commands; commands=()
    _describe -t commands 'uv tool dir commands' commands "$@"
}
(( $+functions[_uv__tool__install_commands] )) ||
_uv__tool__install_commands() {
    local commands; commands=()
    _describe -t commands 'uv tool install commands' commands "$@"
}
(( $+functions[_uv__tool__list_commands] )) ||
_uv__tool__list_commands() {
    local commands; commands=()
    _describe -t commands 'uv tool list commands' commands "$@"
}
(( $+functions[_uv__tool__run_commands] )) ||
_uv__tool__run_commands() {
    local commands; commands=()
    _describe -t commands 'uv tool run commands' commands "$@"
}
(( $+functions[_uv__tool__uninstall_commands] )) ||
_uv__tool__uninstall_commands() {
    local commands; commands=()
    _describe -t commands 'uv tool uninstall commands' commands "$@"
}
(( $+functions[_uv__tool__update-shell_commands] )) ||
_uv__tool__update-shell_commands() {
    local commands; commands=()
    _describe -t commands 'uv tool update-shell commands' commands "$@"
}
(( $+functions[_uv__tool__upgrade_commands] )) ||
_uv__tool__upgrade_commands() {
    local commands; commands=()
    _describe -t commands 'uv tool upgrade commands' commands "$@"
}
(( $+functions[_uv__tool__uvx_commands] )) ||
_uv__tool__uvx_commands() {
    local commands; commands=()
    _describe -t commands 'uv tool uvx commands' commands "$@"
}
(( $+functions[_uv__tree_commands] )) ||
_uv__tree_commands() {
    local commands; commands=()
    _describe -t commands 'uv tree commands' commands "$@"
}
(( $+functions[_uv__venv_commands] )) ||
_uv__venv_commands() {
    local commands; commands=()
    _describe -t commands 'uv venv commands' commands "$@"
}
(( $+functions[_uv__version_commands] )) ||
_uv__version_commands() {
    local commands; commands=()
    _describe -t commands 'uv version commands' commands "$@"
}

if [ "$funcstack[1]" = "_uv" ]; then
    _uv "$@"
else
    compdef _uv uv
fi