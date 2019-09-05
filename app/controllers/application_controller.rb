
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    @articles = Article.all
    erb :index
  end

  get 'articles/new' do 
    erb :new 
  end 

  post '/articles' do 
    @article = Article.new(title: params[:title], content: params[:content])
    @article.save
    @articles = Article.all
    erb :show
  end 
  
  get '/articles' do 
    @articles = Article.all
    erb :index
  end 
  
  get '/articles/:id' do 
    @article = Article.find(params[:id])
    erb :show
  end 
  
  get '/articles/:id/edit' do  
    @article = Article.find(params[:id])
    erb :edit 
  end 
  
  patch '/articles/:id' do 
     article = Article.find(params[:id])
     article.update(params[:article])
     redirect URI.escape("/articles/#{article.id}")
  end 
  
  
  delete '/articles/:id/delete' do 
    article = Article.find(params[:id])
    article.delete
    redirect '/articles'
  end
  
end
