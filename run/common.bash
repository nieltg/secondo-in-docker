# Use .secondorc

source ~/.secondorc

# Update config. file

[ -n "SECONDO_HOST" ] &&
  crudini --set "$SECONDO_CONFIG" Environment SecondoHost "$SECONDO_HOST"
[ -n "SECONDO_PORT" ] &&
  crudini --set "$SECONDO_CONFIG" Environment SecondoPort "$SECONDO_PORT"
