class Carro
  attr_accessor :nome

  def ligar
    "O carro esta pronto para iniciar o trajeto."
  end
end

civic = Carro.new
civic.nome = "Civic"

puts civic.nome
civic.ligar
