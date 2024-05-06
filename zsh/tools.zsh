#!/usr/bin/env bash

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/${HOME_USERNAME}/.sdkman"
[[ -s "/Users/${HOME_USERNAME}/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/${HOME_USERNAME}/.sdkman/bin/sdkman-init.sh"


# Brew completions
if type brew &>/dev/null
then
  HOMEBREW_PREFIX="$(brew --prefix)"
  if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]
  then
    source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  else
    for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*
    do
      if 
      source "${HOMEBREW_PREFIX}/etc/bash_completion.d/az"
    #   [[ -r "${COMPLETION}" ]] && source "${COMPLETION}"
    done
  fi
fi