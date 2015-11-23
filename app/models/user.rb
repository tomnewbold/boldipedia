class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :confirmable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :wikis

  after_initialize do 
    self.role ||= "standard"
  end

  def admin?
    role == "admin"
  end

   def premium?
    role == "premium"
   end

   def standard?
    role == "standard"
   end

  def public_wikis
    wikis.each do |wiki|
      if wiki.private == true
        wiki.update_attributes(private: false)
      end
    end
  end
end
