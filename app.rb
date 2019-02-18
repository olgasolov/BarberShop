#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

configure do
	@db = SQLite3::Database.new 'barbershop.db'
	@db.execute 'CREATE TABLE IF NOT EXISTS
		"Users"
		(
			"id" INTEGER PRIMARY KEY AUTOINCREMENT,
			"username" TEXT,
			"phone" TEXT,
			"datestamp" TEXT,
			"barber" TEXT
		)'
end

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end

get '/about' do
	@error = "something wrong!"
	erb :about
end

get '/visit' do
	erb :visit
end

post '/visit' do
	@username = params[:username]
	@phone = params[:phone]
	@datetime = params[:datetime]
	@barber = params[:barber]
	@color = params[:color]		

	# хеш
	hh= { :username => 'Введите имя', 
	      :phone => 'Введите телефон', 
	      :datetime => 'Введите дату и время' }

	# для каждой пары ключ-значение

	@error = hh.select {|key,_| params[key] == ""}.values.join(", ")

	if @error != '' 
		return erb :visit
	end	
	
	erb "ОК, username is #{@username}, #{@phone}, #{@datetime}, #{@barber}, #{@color}"
end

get '/contacts' do
	erb :contacts
end



