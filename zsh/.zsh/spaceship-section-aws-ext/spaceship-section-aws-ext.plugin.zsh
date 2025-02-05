#
# awsext
#
# awsext lets you know your current AWS account name and remaining time

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_AWSEXT_SHOW="${SPACESHIP_AWSEXT_SHOW=true}"
SPACESHIP_AWSEXT_ASYNC="${SPACESHIP_AWSEXT_ASYNC=true}"
SPACESHIP_AWSEXT_PREFIX="${SPACESHIP_AWSEXT_PREFIX="@ "}"
SPACESHIP_AWSEXT_SUFFIX="${SPACESHIP_AWSEXT_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_AWSEXT_COLOR="${SPACESHIP_AWSEXT_COLOR="yellow"}"

# ------------------------------------------------------------------------------
# Usage
# ------------------------------------------------------------------------------
#
# Install the spaceship prompt:
#
#   https://github.com/spaceship-prompt/spaceship-prompt
#
# Copy this file somewhere and include it in your .zshrc:
#
#   source ~/.zsh/spaceship-section-aws-ext/spaceship-section-aws-ext.plugin.zsh
#   spaceship add awsext

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# Show awsext status
# spaceship_ prefix before section's name is required!
# Otherwise this section won't be loaded.
spaceship_awsext() {
  # If SPACESHIP_AWSEXT_SHOW is false, don't show awsext section
  [[ $SPACESHIP_AWSEXT_SHOW == false ]] && return

  human_friendly_time() {
    local total_seconds=$1
    local hours=$((total_seconds / 3600))
    local minutes=$(( (total_seconds % 3600) / 60 ))
    local seconds=$((total_seconds % 60))

    if (( hours > 0 )); then
      printf "%02d:%02d:%02d" $hours $minutes $seconds
    elif (( minutes > 0 )); then
      printf "%02d:%02d" $minutes $seconds
    else
      printf "%02d" $seconds
      # printf "%ds" 1
    fi
  }

  local timeout=7200
  local lockfile="${HOME}/.gimme-aws-creds.lockfile"
  if [[ -f $lockfile ]]; then
    age_seconds=$(($(date +%s) - $(stat -t %s -f %m -- "$lockfile")))
    if [[ $age_seconds -ge $timeout ]]; then
      return
    else
      source $lockfile
      local remaining_time=$(human_friendly_time $((timeout - age_seconds)))
      local display="$AWS_ACCOUNT_NAME (-$remaining_time)"
    fi
  else
    return
  fi

  # Display awsext section
  # spaceship::section utility composes sections. Flags are optional
  spaceship::section::v4 \
    --color "$SPACESHIP_AWSEXT_COLOR" \
    --prefix "$SPACESHIP_AWSEXT_PREFIX" \
    --suffix "$SPACESHIP_AWSEXT_SUFFIX" \
    --symbol "$SPACESHIP_AWSEXT_SYMBOL" \
    "$display"
}
