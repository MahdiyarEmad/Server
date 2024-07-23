# Server

To setup ssh key for github use commands below
```bash
ssh-keygen -t rsa -b 4096 -C "mtmralone@gmail.com"
cat ~/.ssh/id_rsa.pub
```
after put your ssh key to your github use this command
```bash
bash <(curl -Ls https://raw.githubusercontent.com/MTMrAlone/Server/main/setup.sh)
```
