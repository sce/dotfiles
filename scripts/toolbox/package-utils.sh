###############################################################################

# Takes arguments:
# 1: name of container
# 2..n: packages to install
function create_toolbox {
  local cname="$1"
  shift
  (
    set -euxo pipefail
    toolbox create "$cname" 2>/dev/null
    $in_container sudo dnf install -y "$@"
  )
}

# Takes argument:
# 1: name of container
# 2..n: command with arguments to run
function run_in_container {
  toolbox run --container "$@"
}

###############################################################################

function title {
    echo -e "\n=== $1"
}

function subtitle {
    echo "--- $1"
}

function run_command {
  (
    set -x
    "$@"
  ) || true
}

###############################################################################

_dnf_install=()

function dnf_install {
  _dnf_install+=("$@")
}

function dnf_install_exec {
  title "Adding packages..."
  if [[ -n "${_dnf_install[*]}" ]]; then
    run_command sudo dnf install -y "${_dnf_install[@]}"
  fi
}

###############################################################################

_dnf_remove=()

function dnf_remove {
  _dnf_remove+=("$@")
}

function dnf_remove_exec {
  title "Removing packages..."
  if [[ -n "${_dnf_remove[*]}" ]]; then
    run_command sudo dnf remove -y "${_dnf_remove[@]}"
  fi
  unset package
}

###############################################################################

_rpm_ostree_install=()

function rpm_ostree_install {
  _rpm_ostree_install+=("$@")
}

function rpm_ostree_install_exec {
  title "Adding packages..."
  if [[ -n "${_rpm_ostree_install[*]}" ]]; then
    run_command rpm-ostree install --idempotent -y "${_rpm_ostree_install[@]}"
  fi
}

###############################################################################

_rpm_ostree_remove=()

function rpm_ostree_remove {
  _rpm_ostree_remove+=("$@")
}

function rpm_ostree_remove_exec {
  title "Removing packages..."
  for package in "${_rpm_ostree_remove[@]}"; do
    run_command rpm-ostree override remove "${package}"
  done
  unset package
}

###############################################################################

# associative map (dictionary):
declare -A _repository_add

# Takes arguments:
# 1: repository filename (e.g. "docker-ce.repo")
# 2: repository url (e.g. "https://download.docker.com/linux/fedora/docker-ce.repo")
function repository_add {
  repo_filename="$1"
  repo_url="$2"
  _repository_add[$repo_filename]="$repo_url"
}

function repository_add_exec {
  title "Installing repositories..."
  for repo_filename in "${!_repository_add[@]}"; do
      repo_url=${_repository_add[$repo_filename]}
      output="/etc/yum.repos.d/$repo_filename"
      subtitle "$output from $repo_url"
      # TODO: move to temp file first and then use sudo to move it to the right place
      run_command sudo curl --progress-bar --location --output "$output" "$repo_url"
  done
  unset repo_filename repo_url output
}

###############################################################################

# Takes arguments:
# 1: directory to look for ".post" files to execute
function post_run_add_exec {
  local dir="$1"
  source_run=$(which "$HOME"/bin/,source-some-scripts)

  title "Running post install scripts..."
  if [[ -f "$dir/*.post" ]]; then
    "$source_run" "$1"/*.post || true
  fi
}

###############################################################################

_yarn_add=()

function yarn_add {
  _yarn_add+=("$@")
}

function yarn_add_exec {
  title "Adding yarn packages..."
  if [[ -n "${_yarn_add[*]}" ]]; then
    run_command yarn global add "${_yarn_add[@]}"
  fi
}

###############################################################################
