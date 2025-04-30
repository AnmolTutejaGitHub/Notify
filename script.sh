banner Notes Manangement System

choice=$(yad --width=200 --height=80 \
  --title="Notes Management System" \
  --center \
  --button="Login:1" \
  --button="Create Account:2")
button_clicked=$?

if [ "$button_clicked" -eq 1 ]; then
    chmod +x ./Auth/login.sh
   ./Auth/login.sh

elif [ "$button_clicked" -eq 2 ]; then
    chmod +x ./Auth/create_account.sh
  ./Auth/create_account.sh
else echo "Terminated"
fi


