describe "Forms" do
  it "login com sucesso" do
    login("stark","jarvis!")
    expect(find("#flash").visible?).to be true
    # expect(find("#flash").text).to include "Olá, Tony Stark. Você acessou a área logada!"
    expect(find("#flash")).to have_content "Olá, Tony Stark. Você acessou a área logada!"
  end

  it 'senha incorreta' do
    login("stark","abcd")
    expect(find("#flash")).to have_content "Senha é invalida!"
  end
  
  it 'usuário não cadastrado' do
    login("vanessa","jarvis")
    expect(find("#flash")).to have_content "O usuário informado não está cadastrado!"
  end
end

def login(usuario,senha)
  visit '/login'
  fill_in 'username', with: usuario
  fill_in 'password', with: senha
  click_button 'Login'
end
