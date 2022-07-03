module LoginUsers
  def login_chief_editor_user
    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in FactoryBot.create(:chief_editor_user)
    end
  end

  def login_writer_user
    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in FactoryBot.create(:writer_user)
    end
  end
end