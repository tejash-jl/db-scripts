
## Properties file
set -e
properties_file="$1"
echo `date "+%m/%d/%Y %H:%M:%S"` ": $properties_file"
if [ -f "$properties_file" ]
then
     echo `date "+%m/%d/%Y %H:%M:%S"` ": Property file \"$properties_file\" found."
    while IFS='=' read -r key value
    do
        key=$(echo $key | tr '.' '_')
         eval ${key}=\${value}
    done < "$properties_file"
else
     echo `date "+%m/%d/%Y %H:%M:%S"` ": Property file not found, Pass property file name as argument."
fi

#echo "$DB_NAME"

# Check if schema exists
SCHEMA_NAME="certify"

SCHEMA_EXISTS=$(PGPASSWORD=$SU_USER_PWD psql --username=$SU_USER --host=$DB_SERVERIP --port=$DB_PORT --dbname=$DEFAULT_DB_NAME -tAc "SELECT 1 FROM information_schema.schemata WHERE schema_name = '$SCHEMA_NAME'")
if [ "$SCHEMA_EXISTS" = "1" ]; then
    echo  " Schema \"$SCHEMA_NAME\" already exists. Exiting."
    # exit 1
else
    echo "Schema '$SCHEMA_NAME' doesnt exists"
fi

echo "$DB_NAME"

PGPASSWORD=$SU_USER_PWD psql -v ON_ERROR_STOP=1 -v db=$DB_NAME -v dbpass=$SU_USER_PWD --username=$SU_USER --host=$DB_SERVERIP --port=$DB_PORT --dbname=$DEFAULT_DB_NAME -f db.sql 
PGPASSWORD=$SU_USER_PWD psql -v ON_ERROR_STOP=1 -v db=$DB_NAME -v dbpass=$SU_USER_PWD --username=$SU_USER --host=$DB_SERVERIP --port=$DB_PORT --dbname=$DEFAULT_DB_NAME -f ddl.sql
PGPASSWORD=$SU_USER_PWD psql -v ON_ERROR_STOP=1 -v db=$DB_NAME --username=$SU_USER --host=$DB_SERVERIP --port=$DB_PORT --dbname=$DEFAULT_DB_NAME -a -b -f dml.sql 
