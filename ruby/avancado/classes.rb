class Conta
  attr_accessor :saldo, :nome

  def initialize(nome)
    self.saldo = 0.0
    self.nome = nome
  end

  def deposita(valor)
    # puts "Depositando a quantia de " + valor.to_s + " reais."
    self.saldo += valor
    puts "Depositando a quantia de #{valor} reais na conta de #{nome}."
    puts "O saldo da conta de #{nome} e de #{saldo} reais."
  end
end

c = Conta.new("Vanessa")
c.deposita(100.55)
c.deposita(1.45)
