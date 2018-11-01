{{- define "startAndLoad.sh" -}}
#!/bin/bash

# Run the server
/opt/mssql/bin/sqlservr --accept-eula &

echo "Checking if sql is up..."
COLL=0
STATUS=0
CHECKDB=0
i=0
inc=1

COLL=`grep -i "The default collation was successfully changed." /var/opt/mssql/log/errorlog* | wc -l`



while [ $STATUS -lt 1 ] && [ $i -lt 180 ] && [ $COLL -lt 1 ]; do
    i=$((i + inc))
    sleep 1
    #/opt/mssql-tools/bin/sqlcmd -t 1 -U sa -P 'Kondor_123' -i /usr/local/bin/afterload.sql >> /dev/null
    STATUS=`grep -i "The default collation was successfully changed." /var/opt/mssql/log/errorlog | wc -l`
    echo "Checking if collation is changed..."
done

i=0

while [ $STATUS -lt 1 ] && [ $i -lt 90 ]; do
    i=$((i + inc))
    sleep 1
    STATUS=`/opt/mssql-tools/bin/sqlcmd -t 1 -U sa -P 'Kondor_123' -Q"SELECT 'SQL Server is up'" | grep "SQL Server is up" | wc -l`
    echo "Checking if sql is up..."
done

if [ $STATUS -lt 1 ]; then
    echo "Error: MSSQL SERVER took more than 270 seconds to start up."
    exit 1
else
    echo "Sql server is up"
fi

sleep 10

CHECKDB=`/opt/mssql-tools/bin/sqlcmd -t 1 -U sa -P 'Kondor_123' -Q"SELECT 'Number of user databases: [' + cast(count(*) as varchar(100)) + ']' FROM sys.databases WHERE database_id > 4" | grep "Number of user databases: \[[^0]" | wc -l`



dirNo=$(find /db_* -maxdepth 1 -type d  -print | wc -l)

if [ $dirNo -ge 1 ] && [ $CHECKDB -lt 1 ]; then
    echo "Scanning folder for scripts..."
    for directory in `find /db_* -maxdepth 1 -type d  -print`; do
        i=0
        STATUS=`dir $directory/*.sql | wc -l`
        while [ $STATUS -lt 1 ]; do
            echo "Waiting until $directory will be prepared..."
            sleep 1
            STATUS=`dir $directory/*.sql | wc -l`
        done
        echo "Executing scripts from: ${directory}"
        for sqlfile in $directory/*.sql; do
            echo "Script: ${sqlfile}"
            /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 'Kondor_123' -S localhost -i $sqlfile -U sa -P 'Kondor_123' -o $sqlfile.out
        done
	done
fi
echo "Getting back to mssql as main process"


{{- end -}}