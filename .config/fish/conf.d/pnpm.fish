set --global --export PNPM_HOME $XDG_DATA_HOME/pnpm

if not contains $PNPM_HOME $PATH
  set --global --export PATH $PNPM_HOME $PATH
end
