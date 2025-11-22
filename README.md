##Ogorodnik Adam 4cs-31

README.md
🚀 How to Run

  Завантаж run.sh на свій EC2 інстанс.

Зроби його виконуваним:

  chmod +x run.sh


Запусти:

  ./run.sh

  cat /etc/passwd | grep -E "adminuser|poweruser" - Перевірити, що користувачі створені
  
  sudo grep '^adminuser:' /etc/shadow - Перевірити, що пароль adminuser хешований
  
  sudo -l -U adminuser - Перевірити sudo-права adminuser
  
  su - poweruser - Перевірити, що poweruser може логінитись без пароля
  
  sudo -l -U poweruser - Перевірити sudo-права poweruser (тільки iptables)
  
  ls -ld /home/adminuser - Перевірити доступ poweruser до home adminuser
  
  getent group adminaccess - Перевірити групу adminaccess
  
  ls -l /home/poweruser/mtab_link - Перевірити symlink у poweruser
  
