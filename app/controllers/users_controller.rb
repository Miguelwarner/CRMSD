# MyITCRM - Repairs Business CRM Software
# Copyright (C) 2009-2011  Glen Vanderhel
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 3
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
class UsersController < ApplicationController
#  load_and_authorize_resource

 def new
    @title = t "user.t_new_user"
    @user = User.new
 end

  def index
    @title = t "user.t_title"
#    @user = User.search(params[:search], params[:page])
    name = params[:name]
    role = params[:role]
    phone = params[:phone]
    @users = User.where('name LIKE  ?', "%#{name}%").where('role LIKE  ?', "%#{role}%").where('phone LIKE  ?', "%#{phone}%").order(:id).page params[:page]
    respond_to do |format|
      format.html
      format.js
    end
#    authorize! :read, @user
 end

   def show
    @title = t "user.t_view"
   @user = User.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
#     authorize! :read, @user
  end


  def edit
    @title = t "user.t_edit_user"
    @user = User.find(params[:id])
#    authorize! :update, @user
  end

 def create
    @title = t "user.t_new_user"
     @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to(@user, :notice => [ t "user.flash_new_success"]) }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "register" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end

  end
def register
   @title = t "user.t_new_user"
   @user = User.new
end

  def update
    @title = t "user.t_update_user"
    @user = User.find(params[:id])
#    authorize! :update, @user
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice =>[t "user.flash_delete_user"])}
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @title = t "user.t_delete_user"
    @user.destroy
#     authorize! :destroy, @user
    respond_to do |format|
      flash[:notice] = t "user.flash_delete_user"
      format.html { redirect_to(users_url) }
    end
  end

   def edit_profile
    @title = t "user.t_edit_user"
    @user = current_user
  end

  def update_profile
    @title = t "user.t_update_user"
    if @user.update_attributes(params[:user])
      flash[:notice] = t "user.flash_update_user"
      redirect_to root_url
    else
      render :action => "edit_profile"
    end

  end
 def clients
     @title = t "user.t_clients"
 #    @user = User.search(params[:search], params[:page])
     @users = User.where("client = ?", true).order(:name).page params[:page]
#     authorize! :read, @user
  end

end
