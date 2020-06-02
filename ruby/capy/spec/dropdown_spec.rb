describe  "Caixa de opções", :dropdown do

    before(:each) do
        visit "/dropdown"
    end

    it "item específico simples" do
        select("Loki", from: "dropdown")
    end

    it "item espec[ifico com o find" do
        drop = find(".avenger-list")
        drop.find("option", text:"Scott Lang").select_option
    end

    it "qualquer item", :sample do
        drop = find(".avenger-list")
        drop.all("option").sample
    end

    after(:each) do
        sleep 3
    end

end