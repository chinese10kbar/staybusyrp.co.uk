# sb-management

New sb-bossmenu / sb-gangmenu converted into one resource using sb-menu and sb-input, with SQL support for society funds!

## Dependencies
- [sb-core](https://github.com/qbcore-framework/sb-core)
- [sb-smallresources](https://github.com/qbcore-framework/sb-smallresources) (For the Logs)
- [sb-input](https://github.com/qbcore-framework/sb-input)
- [sb-menu](https://github.com/qbcore-framework/sb-menu)
- [sb-inventory](https://github.com/qbcore-framework/sb-inventory)
- [sb-clothing](https://github.com/qbcore-framework/sb-clothing)

## Screenshots
![image](https://i.imgur.com/9yiQZDX.png)
![image](https://i.imgur.com/MRMWeqX.png)

## Installation
### Manual
- Download the script and put it in the `[qb]` directory.
- IF NEW SERVER: Import `sb-management.sql` in your database
- IF EXISTING SERVER: Import `sb-management_upgrade.sql` in your database
- Edit config.lua with coords
- Restart Script / Server

## ATTENTION
### YOU NEED TO CREATE A ROW IN DATABASE WITH NAME OF SOCIETY IN MANAGEMENT_FUNDS TABLE IF YOU HAVE CUSTOM JOBS / GANGS
![database](https://i.imgur.com/6cd3NLU.png)

# License

    QBCore Framework
    Copyright (C) 2021 Joshua Eger

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>
