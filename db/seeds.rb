# Load and execute seeder code
#
#  name:: Filename to load
def load_seed (name)
    require File.join(Rails.root, 'db', 'seeds', name)
end

# Get id for heroku (cleardb)
#
#  i:: id
def id (i)
    (i-1)*10 + 4
end

# Execute custom SQL code
#
#  sql:: SQL string
def exec_sql (sql)
    ActiveRecord::Base.connection.execute sql
end


load_seed 'init_seeder'
load_seed 'theatres_seeder'
load_seed 'u_perms_seeder'
load_seed 'u_apis_seeder'
load_seed 'u_webs_seeder'
load_seed 'actors_seeder'
load_seed 'p_types_seeder'
load_seed 'perf_seeder'
load_seed 't_hall_seeder'
load_seed 't_perf_seeder'
load_seed 'poster_seeder'


