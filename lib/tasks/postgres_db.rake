require 'date'
task spec: ['postgres:db:test:prepare']

namespace :postgres do
  namespace :db do |ns|
    %i(drop create setup migrate rollback seed version).each do |task_name|
      task task_name do
        Rake::Task["db:#{task_name}"].invoke
      end
    end

    namespace :schema do
      %i(load dump).each do |task_name|
        task task_name do
          Rake::Task["db:schema:#{task_name}"].invoke
        end
      end
    end

    namespace :import do
      desc "Import fact_quotes data from MYSQL"
      task fact_quotes: :environment do
        FactQuote.destroy_all
        count = 0
        Quote.find_each do |record|
          fq = FactQuote.new
          fq.quoteId = record.id
          fq.companyName = record.companyName
          fq.email = record.email
          fq.nbElevator = record.no_of_elevators_needed
          fq.createdOn = Time.at(record.created_at).to_datetime
          if fq.save
            puts "fact_quotes saved"
            count = count + 1
          else
            puts "... bad: #{u.errors.full_messages.join(',')}"
          end
        end
        puts "#{count} fact_quotes saved."
      end

      desc "Import fact_contact data from MYSQL"
      task fact_contacts: :environment do
        FactContact.destroy_all
        count = 0
        Lead.find_each do |record|
          fc = FactContact.new
          fc.contactId = record.id
          fc.createdOn = Time.at(record.created_at).to_datetime
          fc.companyName = record.cie_name
          fc.email = record.email
          fc.projectName = record.project_name
          if fc.save
            count = count + 1
          else
            puts "... bad: #{u.errors.full_messages.join(',')}"
          end
        end
        puts "#{count} fact_contacts saved."
      end

      desc "Import fact_elevator data from MYSQL"
      task fact_elevators: :environment do
        FactElevator.destroy_all
        count = 0
        Elevator.find_each do |record|
          fe = FactElevator.new
          fe.serialNumber = record.Serial_number
          fe.dateOfCommissioning = record.Date_of_commissioning
          column = Column.where(id: record.columns_id)
          battery = Battery.where(id: column.pluck(:batteries_id))
          building_id = battery.pluck(:buildings_id).first
          fe.buildingId = building_id
          fe.customerId = Building.where(id: building_id).pluck(:customers_id).first
          fe.buildingCity = Adress.where(id: Building.where(id: building_id).pluck(:adresses_id).first).pluck(:city).first
          if fe.save
            count = count + 1
          else
            puts "... bad: #{u.errors.full_messages.join(',')}"
          end  
         end
        puts "#{count} fact_elevators saved."
      end


      desc "Import dim_customers data from MYSQL"
      task dim_customers: :environment do
        DimCustomer.destroy_all
        count = 0
        Customer.find_each do |record|
          dc = DimCustomer.new
          dc.id = record.id
          dc.createdOn = Time.at(record.created_at).to_datetime
          dc.companyName = record.Company_Name
          dc.fullNameOfMainContact = record.Full_Name_of_the_company_contact
          dc.emailOfMainContact = record.Email_of_the_company_contact
          dc.nbElevator = 0 
          buildings = Building.where(customers_id: record.id)
          buildings.each do |building|
            batteries = Battery.where(buildings_id: building.id)
            batteries.each do |battery|
              columns = Column.where(batteries_id: battery.id)
              columns.each do |column|
                dc.nbElevator = Elevator.where(columns_id: column.id).count
                puts dc.nbElevator
              end
            end
          end
        dc.customerCity = record.city
        if dc.save
          count = count + 1
        else
          puts "... bad: #{u.errors.full_messages.join(',')}"
        end
      end
      puts "#{count} dim_customers saved."
    end
  end


    namespace :test do
      task :prepare do
        Rake::Task['db:test:prepare'].invoke
      end
    end

    # append and prepend proper tasks to all the tasks defined here above
    ns.tasks.each do |task|
      task.enhance ['postgres:set_custom_config'] do
        Rake::Task['postgres:revert_to_original_config'].invoke
      end
    end
  end

  task :set_custom_config do
    # save current vars
    @original_config = {
      env_schema: ENV['SCHEMA'],
      config: Rails.application.config.dup
    }

    # set config variables for custom database
    ENV['SCHEMA'] = 'postgres_db/schema.rb'
    Rails.application.config.paths['db'] = ['postgres_db']
    Rails.application.config.paths['db/migrate'] = ['postgres_db/migrate']
    # If you are using Rails 5 or higher change `paths['db/seeds']` to `paths['db/seeds.rb']`
    Rails.application.config.paths['db/seeds.rb'] = ['postgres_db/seeds.rb']
    Rails.application.config.paths['config/database'] = ['config/postgres_database.yml']
  end

  task :revert_to_original_config do
    # reset config variables to original values
    ENV['SCHEMA'] = @original_config[:env_schema]
    Rails.application.config = @original_config[:config]
  end
end


# namespace :postgres_db do
#     task load_config: :environment do
#         @postgres_env = "postgres_#{Rails.env}"
#         @schema_path = File.join(ActiveRecord::Tasks::DatabaseTasks.db_dir, "postgres_schema.rb")
#     end
#     #Create and drop database defined below:
#     desc "Creates the Postgres database from config/postgres_database.yml."
#     task create: :load_config do
#         ActiveRecord::Tasks::DatabaseTasks.create_current(@postgres_env)
#     end 
#     desc "Drops the Postgres database from config/database.yml for the current RAILS_ENV."
#     task drop: [:load_config] do
#       ActiveRecord::Tasks::DatabaseTasks.drop_current(@postgres_env)
#     end

#     namespace :
#     #dump from one schema to postgres schema
#     # namespace :schema do
#     #     desc "Creates a db/schema.rb file that is portable against any DB supported by Active Record"
#     #     task dump: :load_config do
#     #         require "active_record/schema_dumper"
#     #         db_config = ActiveRecord::Base.configurations['postgres_production']
#     #         connection = ActiveRecord::Base.establish_connection(db_config).connection
#     #         File.open(@schema_path, "w:utf-8") do |file|
#     #         ActiveRecord::SchemaDumper.dump(connection, file)
#     #         end
#     #     end
#     #     desc "Loads a schema.rb file into the database"
#     #     task load: :load_config do
#     #     ActiveRecord::Tasks::DatabaseTasks.load_schema_current(:ruby, @schema_path, @reporting_env)
#     #     end
#     # end
#     desc "Migrate to postgres database"
#     task :migrate do
#         Rake::Task["db:migrate"].invoke
#     end

#     task :migrate
# end