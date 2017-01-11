# Set local MySQL increments to ClearDB's
#

exec_sql 'SET @@global.auto_increment_increment = 10'
exec_sql 'SET @@global.auto_increment_offset = 4'
exec_sql 'SET @@session.auto_increment_increment = 10'
exec_sql 'SET @@session.auto_increment_offset = 4'