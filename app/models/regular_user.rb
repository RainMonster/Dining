class RegularUser < User

  has_secure_password

  validates :first_name, :last_name, :email, presence: true
  validates :password, length: { minimum: 8 }
  validates :email, uniqueness: true,
    format: {
      with: /[\w\.\+]+@[\w\.]+\.\w+/,
        message: "must be valid email address" }

        
end