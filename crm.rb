# require 'pry'

require_relative 'contact'

class CRM

  def initialize(name)
    puts "OK! This CRM has the name " + name
  end


  def main_menu
    while true
      print_main_menu
      user_input = gets.chomp.to_i
      while user_input > 7 || user_input < 1
        puts "Invalid option. Please select from the main menu options and enter option number."
        user_input = gets.chomp.to_i
      end
      call_option(user_input)
    end
  end


  def print_main_menu
    puts "[1] Add a new contact"
    puts "[2] Modify an existing contact"
    puts "[3] Delete a contact"
    puts "[4] Display all contacts"
    puts "[5] Search by attribute"
    puts "[6] Exit"
    puts "Enter a number: "
  end


  def call_option(user_input)
    case user_input
      when 1 then add_new_contact
      when 2 then modify_existing_contact
      when 3 then delete_contact
      when 4 then display_all_contacts
      when 5 then search_by_attribute
      when 6 then abort("You ended your session. Goodbye.")
    end
  end


  def add_new_contact
    print "Enter first name: "
      first_name = gets.chomp
    print "Enter last name: "
      last_name = gets.chomp
    print "Enter email address: "
      email = gets.chomp
    print "Enter any notes about the contact: "
      notes = gets.chomp

    puts Contact.create(first_name, last_name, email, notes)
  end


  def modify_existing_contact
    target_contact = search_by_attribute

    puts "Which attribute would you like to modify?"
    puts "Select from the following list: "
    puts "[1] First name"
    puts "[2] Last name"
    puts "[3] Email"
    puts "[4] Notes"
    puts "Enter a number: "

    attribute = gets.chomp.to_i
    while attribute > 4 || attribute < 1
      puts "Invalid option. Please select from the menu options and enter option number."
      attribute = gets.chomp.to_i
    end

    case attribute
      when 1 then attribute = "first_name"
      when 2 then attribute = "last_name"
      when 3 then attribute = "email"
      when 4 then attribute = "notes"
    end

    puts "Please enter the new information below."
    value = gets.chomp

    puts target_contact.update(attribute, value).inspect # update is an instance method from class Contact
  end


  def delete_contact
    target_contact = search_by_attribute
    puts "You are about to delete #{target_contact}. Are you sure?"
    puts "[1] Yes"
    puts "[2] No"

    delete_input = gets.chomp.to_i
    while delete_input > 2 || delete_input < 1
      puts "Invalid option. Please select from the menu options and enter option number."
      attribute_input = gets.chomp.to_i
    end

    if delete_input == 1
      puts target_contact.delete
      puts "You deleted #{target_contact}."

    elsif delete_input == 2
      puts "You aborted the deletion of #{target_contact}."
    end
  end

  def display_all_contacts
    puts Contact.all.inspect
  end

  def search_by_attribute
    puts "Which contact would you like to work on?"
    puts "You can search by the followings: "
    puts "[1] First name"
    puts "[2] Last name"
    puts "[3] Email"
    puts "Enter a number: "

    attribute = gets.chomp.to_i
    while attribute > 3 || attribute < 1
      puts "Invalid option. Please select from the menu options and enter option number."
      attribute = gets.chomp.to_i
    end

    case attribute
      when 1 then attribute = "first_name"
      when 2 then attribute = "last_name"
      when 3 then attribute = "email"
    end

    puts "Please enter the search information below."
    value = gets.chomp.to_s

    return  Contact.find_by(attribute, value)
  end

end


crm_app = CRM.new("Hangry Daddy")

crm_app.main_menu
