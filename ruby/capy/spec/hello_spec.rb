describe "Meu primeiro script" do
  it "visitar a pagina" do
    visit "/"
    expect(page.title).to eql "Training Wheels Protocol"
  end
end
