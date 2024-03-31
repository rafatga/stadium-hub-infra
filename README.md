![](https://github.com/rafatga/stadium-hub-infra/blob/main/doc/img/hero.gif)

# Stadium Hub (Local) Infrastructure
No need to manually clone them follow [Installation](#Installation) steps
```
https://github.com/rafatga/stadium-hub-api
https://github.com/rafatga/stadium-hub-panel
https://github.com/rafatga/stadium-hub-front
```

## Installation of Infra
### [1] Add hosts to local hosts files
```
[mac] -> /etc/hosts
[ubuntu] -> /etc/hosts
[windows] -> C:\Windows\system32\drivers\etc\hosts

127.0.0.1       api.stadium-hub.loc
127.0.0.1       panel.stadium-hub.loc
127.0.0.1       front.stadium-hub.loc
```
### [2] Download repositories
Running `make bootup`, will automatically download the repositories and add them to ./code directory.
```
make bootup
```
### [3] Build projects (first time)
This command will ask you which projects to build and once selected, it will start building them one by one
```
make build
```

## Starting Infra
### [1] Start projects
This command will ask you which projects to start and once selected, it will start them one by one
```
make start
```
### [2] Stop projects
This command will stop all projects
```
make stop
```

