# Start
Create new project
```rails new <ProjectName>```

Start server 
```rails s|server [-p port -e production|development|test]```

Start IRB console (*tinker*)
```rails c|console```

Generate & Destroy
```rails generate|destroy|g|d <GeneratorName> <GenArgs> [--force ]```

Print stats (Lines of code)
```rails stats```

Generate secret key
```rails secret```

#### Creating custom rake commands
Create file in ```lib\tasks``` with extension ```.rake```
```
require 'rake'
 
namespace :<Prefix> do
  ...
  desc '<Task description>'
  task :<TaskName> [<depends>] do
    # Any ruby code
    # ex. Rake::Task['<Pre-Defined task name>'].invoke
  end
  ...
end

```
If your need to interact with your application models, perform database queries and so on, your task should depend on the ```environment``` task, which will load your application code.

# Database
## Migrations
    class <ClassName> < ActiveRecord::Migration[5.0]
      def change
        create_table :<TableName> do |t|
          t.<type> :<name>
          ...
          
          t.timestamps
        end
      end
    end
    
#### Foreign keys
1. Create `<TableName>_id` field
2. After `create_table` write `add_foreign_key :<ThisTable> :<ToTable>`
3. ??Write model functions??
 
#### Soft deletion
0. Add gem `gem install paranoia`. [Source and guides](https://github.com/rubysherpas/paranoia)
1. Insert column `t.datetime :deleted_at`
2. Insert index `add_index :<table>, :deleted_at`
2. Add `acts_as_paranoid` to Model
 
#### Production changes
*For easy tasks like change 1 field*
```
class <ClassName> < ActiveRecord::Migration[5.0]
  def change
    reversible do |dir|
      change_table :<TableName> do |t|
        dir.up   { t.change :price, :string }  # For migrating
        dir.down { t.change :price, :integer } # For rolling back
      end
    end
  end
end  
```
OR

*For more complicated tasks*
```
class <ClassName> < ActiveRecord::Migration[5.0]
  def up
    change_table :<TableName> do |t|
      t.change :price, :string
    end
  end
 
  def down
    change_table :<TableName> do |t|
      t.change :price, :integer
    end
  end
end
```

## ActiveRecord
#### Useful code
Run raw SQL `ActiveRecord::Base.connection.execute('<SQL>')`

Dump seeds - install gem `123` and do `rake db:seed:dump`
**Does not dump tables, dumps models (so if you have table only, it wont dump it)**


## Views, Templates, Layouts and Partials
[Layouts and Rendering](http://guides.rubyonrails.org/layouts_and_rendering.html)

#### How to create partial
1. Create file `_<Name>.html.erb` in `app/views/partials`
2. Render partial in needed place `<%= render 'partials/<Name>' %>`

# Ruby
## Array
Methods:
* `a.collect {|v| <expr>}` - iterates and creates new array of results

## Hash
Methods:
* `a.`