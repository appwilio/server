#!/bin/bash
POSTGRE_SEARCH_DIR="/usr/share/postgresql/9.4/tsearch_data"
POSTGRE_HOME="/etc/postgresql/9.4/main"
#POSTGRE_DB_NAME="forge"

#Downloading dictionary
echo "Getting dictionary files"
cd /tmp
wget -q https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/hunspell-ru/ru_RU_UTF-8_20120301.zip

#Unzip dictionary
unzip -o ru_RU_UTF-8_20120301.zip -d /tmp/
cp /tmp/ru_RU.aff "$POSTGRE_SEARCH_DIR/ru_ru.affix"
cp /tmp/ru_RU.dic "$POSTGRE_SEARCH_DIR/ru_ru.dict"

#Fix affix file
sed --in-place 's/FLAG/#FLAG/g' "$POSTGRE_SEARCH_DIR/ru_ru.affix"
echo "Done!"

/etc/init.d/postgresql start
sudo -u postgres psql -d forge -f /temp/postgres-fulltextsearch.sql

#Default search setup
echo "Change postgresql.conf"
cp "$POSTGRE_HOME/postgresql.conf" "$POSTGRE_HOME/postgresql.conf.backup-$(date +%d.%m.%Y-%H:%M)"
sed --in-place 's/default_text_search_config/#default_text_search_config/g' "$POSTGRE_HOME/postgresql.conf"
echo "default_text_search_config = 'ru'" >> "$POSTGRE_HOME/postgresql.conf"
/etc/init.d/postgresql restart
echo "Done!"
