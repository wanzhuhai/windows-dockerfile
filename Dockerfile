FROM e2eteam/busybox:1.29

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

USER ContainerAdministrator

RUN Invoke-WebRequest  'https://cdn.mysql.com//archives/mysql-5.7/mysql-5.7.32-winx64.zip' -OutFile 'mysql-5.7.32-winx64.zip'; \
        Expand-Archive 'mysql-5.7.32-winx64.zip' -DestinationPath  C:\ ;\
        Remove-Item 'mysql-5.7.32-winx64.zip' -Force ; \
        Rename-Item 'c:\mysql-5.7.32-winx64' c:\mysql
        #New-Item -Path 'C:\mysql\data' -ItemType directory" &&\
        #Invoke-WebRequest  'https://downloads.mysql.com/general/timezone_2020d_posix.zip'  -OutFile 'c:\timezone_2020d_posix.zip' &&\
        #Expand-Archive 'c:\timezone_2020d_posix.zip' C:\  &&\
        #Remove-Item 'c:\timezone_2020d_posix.zip' -Force &&\
        #Copy-Item 'c:\timezone_2020d_posix\*' 'C:\mysql\data\mysql\.' -Force &&\
        #Remove-Item 'c:\timezone_2020d_posix' -Force -Recurse  && \
         
COPY my.ini /mysql

EXPOSE 3306

COPY start-mysql.ps1 /

WORKDIR C:\\mysql

CMD ["powershell -file c:\\start-mysql.ps1 $env:MYSQL_ROOT_PASSWORD"]
