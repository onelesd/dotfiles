#
# awsext
#
# awsext is a supa-dupa cool tool for making you development easier.
# Link: https://www.awsext.xyz

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_AWSEXT_SHOW="${SPACESHIP_AWSEXT_SHOW=true}"
SPACESHIP_AWSEXT_ASYNC="${SPACESHIP_AWSEXT_ASYNC=true}"
SPACESHIP_AWSEXT_PREFIX="${SPACESHIP_AWSEXT_PREFIX="@ "}"
SPACESHIP_AWSEXT_SUFFIX="${SPACESHIP_AWSEXT_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_AWSEXT_COLOR="${SPACESHIP_AWSEXT_COLOR="yellow"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# Show awsext status
# spaceship_ prefix before section's name is required!
# Otherwise this section won't be loaded.
spaceship_awsext() {
  # If SPACESHIP_AWSEXT_SHOW is false, don't show awsext section
  [[ $SPACESHIP_AWSEXT_SHOW == false ]] && return

  # Check if awsext command is available for execution
  # spaceship::exists awsext || return

  # Show awsext section only when there are awsext-specific files in current
  # working directory.

  # spaceship::upsearch utility helps finding files up in the directory tree.
  # local is_awsext_context="$(spaceship::upsearch awsext.conf)"
  # Here glob qualifiers are used to check if files with specific extension are
  # present in directory. Read more about them here:
  # http://zsh.sourceforge.net/Doc/Release/Expansion.html
  # [[ -n "$is_awsext_context" || -n *.foo(#qN^/) || -n *.bar(#qN^/) ]] || return

  source ~/.gimme-aws-creds.lockfile

  # local awsext_vars="$(awsext --version)"

  # Check if tool version is correct
  # [[ $awsext_version == "system" ]] && return

  # Display awsext section
  # spaceship::section utility composes sections. Flags are optional
  spaceship::section::v4 \
    --color "$SPACESHIP_AWSEXT_COLOR" \
    --prefix "$SPACESHIP_AWSEXT_PREFIX" \
    --suffix "$SPACESHIP_AWSEXT_SUFFIX" \
    --symbol "$SPACESHIP_AWSEXT_SYMBOL" \
    "$AWS_ACCOUNT_NAME"
}
