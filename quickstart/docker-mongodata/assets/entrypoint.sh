echo "Notice: running mongod in foreground to perform initial checks"
mongod --fork --syslog --quiet

if [ "${MONGO_DB}x" != "x" ]; then
	echo "Notice: checking if database '${MONGO_DB}' exists"
	echo 'show dbs' | mongo --quiet admin | grep ${MONGO_DB}
	if [ $? -gt 0 ]; then
		echo "Notice: database '${MONGO_DB}' not found, creating..."
		if [ "${MONGO_DUMP}x" != "x" ]; then
			echo "Notice: dump file provided, trying to import..."
			echo "Notice: doownloading dump from ${MONGO_DUMP}"
			curl -s ${MONGO_DUMP} -o dump.tar.gz -z dump.tar.gz
			echo "Notice: completed"
			echo "Notice: unpacking"
			tar xzf dump.tar.gz
			echo "Notice: completed"
			if [ -d dump/${MONGO_DB} ]; then
				echo 'Found database dump'
			fi
			mongorestore --quiet --db ${MONGO_DB} dump/${MONGO_DB}
		fi
	else
		echo "Found, using existing one"
	fi
fi

if [ "${MONGO_USER}x" != "x" -a "${MONGO_PASS}x" != "x" -a "${MONGO_DB}x" != "x" ]; then
	echo "Notice: DB name and credentials defined, checking if exists..."
	echo "Notice: checking if user '${MONGO_USER}' exists"
	echo 'show users' | mongo --quiet admin | grep ${MONGO_USER}
	if [ $? -gt 0 ]; then
		echo "Not found, creating..."
		echo "db.createUser({user:'${MONGO_USER}',pwd:'${MONGO_PASS}',roles:[{role:'root',db:'admin'}]})" | mongo --quiet admin
		if [ $? -gt 0 ]; then
			echo 'Failed'
		else
			echo 'Success'
		fi
	fi
	echo "Notice: stopping background daemon"
	mongod --shutdown
	echo "Notice: restarting in foreground with auth"
	mongod --quiet --auth
else
	echo "Notice: stopping background daemon"
	mongod --shutdown
	echo "Notice: restarting in foreground with no auth"
	mongod --quiet
fi
