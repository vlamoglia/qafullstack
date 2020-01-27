class AvengersHeadquarter
  attr_accessor :list

  def initialize
    self.list = []
  end

  def put(avenger)
    self.list.push(avenger)
  end
end

describe AvengersHeadquarter do
  it "deve adicionar um vingador" do
    hq = AvengersHeadquarter.new
    hq.put("Spiderman")
    expect(hq.list).to include "Spiderman"
  end

  it "deve adicionar uma lista de vingadores" do
    hq = AvengersHeadquarter.new
    hq.put("Thor")
    hq.put("Hulk")
    hq.put("Spiderman")

    res = hq.list.size > 0
    expect(res).to be true
  end

  it "thor deve ser o primeiro da lista" do
    hq = AvengersHeadquarter.new
    hq.put("Thor")
    hq.put("Hulk")
    hq.put("Spiderman")

    expect(hq.list).to start_with("Thor")
  end

  it "ironman deve ser o ultimo da lista" do
    hq = AvengersHeadquarter.new
    hq.put("Thor")
    hq.put("Hulk")
    hq.put("Spiderman")
    hq.put("Ironman")

    expect(hq.list).to end_with("Ironman")
  end

  it "deve conter o sobrenome" do
    avenger = "Peter Parker"
    expect(avenger).to match(/Parker/)
    expect(avenger).not_to match(/Vanessa/)
  end
end
