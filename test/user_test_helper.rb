module UserTestHelper
  def default_user
    return @default_user if defined? @default_user
    @default_user = User.new(username: 'default', email: 'default@example.com', password: 'zaq123')
    @default_user.send(:encrypt_password)
    @default_user
  end
end