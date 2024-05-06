dir="${HOME}/dotfiles/zsh"
for zsh_file in $dir/*.zsh; do
  source $zsh_file
done
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/dgubin/.sdkman"
[[ -s "/Users/dgubin/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/dgubin/.sdkman/bin/sdkman-init.sh"
