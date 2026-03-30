###############################################################################

function title {
    echo -e "\n=== $1"
}

function subtitle {
    echo "--- $1"
}

###############################################################################

_dnf_install=()

function dnf_install {
  _dnf_install+=("$1")
}

function dnf_install_exec {
  title "Adding packages..."
  if [[ -n "${_dnf_install[*]}" ]]; then
    (
        set -x
        echo dnf install "${_dnf_install[@]}"
    ) || true
  fi
}

###############################################################################

_dnf_remove=()

function dnf_remove {
  _dnf_remove+=("$1")
}

function dnf_remove_exec {
  title "Removing packages..."
  if [[ -n "${_dnf_remove[*]}" ]]; then
    (
        set -x
        echo dnf remove -y "${_dnf_remove[@]}"
    ) || true
  fi
  unset package
}

###############################################################################

_rpm_ostree_install=()

function rpm_ostree_install {
  _rpm_ostree_install+=("$1")
}

function rpm_ostree_install_exec {
  title "Adding packages..."
  if [[ -n "${_rpm_ostree_install[*]}" ]]; then
    (
        set -x
        echo rpm-ostree install --idempotent -y "${_rpm_ostree_install[@]}"
    ) || true
  fi
}

###############################################################################

_rpm_ostree_remove=()

function rpm_ostree_remove {
  _rpm_ostree_remove+=("$1")
}

function rpm_ostree_remove_exec {
  title "Removing packages..."
  for package in "${_rpm_ostree_remove[@]}"; do
      (
          set -x
          echo rpm-ostree override remove "${package}"
      ) || true
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
      echo sudo curl --progress-bar --location --output "$output" "$repo_url"
  done
  unset repo_filename repo_url output
}

###############################################################################

# Takes arguments:
# 1: directory to look for ".post" files to execute
function post_run_add_exec {
  source_run=$(which "$HOME"/bin/,source-some-scripts)

  title "Running post install scripts..."
  (
    "$source_run" "$1"/*.post
  ) || true
}

###############################################################################

_yarn_add=()

function yarn_add {
  _yarn_add+=("$1")
}

function yarn_add_exec {
  echo yarn global add "${_yarn_add[@]}"
}

###############################################################################
