class User < ApplicationRecord
    validates_uniqueness_of :username
    validates_uniqueness_of :email
    has_secure_password
    has_secure_token :auth_token
    has_many :courses
    has_many :enrollments

    mount_uploader :image, ImageUploader
    

    def invalidate_token
        self.update_columns(auth_token: nil)
    end

    def self.validate_login(username, password)
        user = find_by(username: username)
        if user && user.authenticate(password)
            user 
        end
    end
end
