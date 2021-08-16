Param(
[Parameter(Mandatory=$true)]
[String]$MYSQL_ROOT_PASSWORD
)

$env:Path += ";C:\mysql\bin"
setx Path $env:Path /m

mysqld --defaults-file=c:\mysql\my.ini --initialize-insecure --explicit_defaults_for_timestamp
mysqld --install

Start-Service mysql

echo $env:Path

mysql -u root -e "GRANT ALL ON *.* to root@'%' IDENTIFIED BY '$env:MYSQL_ROOT_PASSWORD'; FLUSH PRIVILEGES;"

tail -f C:\mysql\mysql.err
