describe "TestRail maintenance" do
  it "Replace references" do

    #Change the data below - START
    usr = "youremail@zattoo.com"
    pwd = "yourpassword"
    projName = "WEBTV - BigScreen React Client"
    oldReference = "ZRB-"
    newReference = "WEBTV-"
    #END

    evt = OpenStruct.new
    f = File.open("log.txt", "w+")
    #visit "/"
    login(usr, pwd)
    sleep 1
    click_link(projName, match: :first)
    sleep 1
    find("input.top-search-control").click.set(oldReference).native.send_keys(:return)
    sleep 1
    table_Links = []
    table_TC = find("h2", text: "Test Cases").first(:xpath, "./following-sibling::table")

    table_TC.all(:css, ".link-noline").each do |el|
      table_Links.push(el[:href])
    end

    table_Links.each do |el|
      visit(el)

      evt.href = el.dup
      puts "Link: " + evt.href

      oldRef_str = ""
      page.all(:css, ".referenceLink").each do |el2|
        oldRef_str += el2.text + ","
      end

      oldRef_str = oldRef_str.nil? ? "" : oldRef_str.chomp(",")

      evt.oldref = oldRef_str.dup
      puts "Old reference: " + evt.oldref

      evt.newref = evt.oldref.dup
      evt.newref = evt.newref.gsub! oldReference, newReference
      evt.newref = evt.newref.nil? ? "" : evt.newref
      puts "New reference: " + evt.newref + "\n"
      f.puts evt

      click_link("Edit", match: :first)
      sleep 1
      find("input#refs").set("").set(evt.newref)
      find("[id=accept]").click
      sleep 1
    end
  end
end

def login(user, password)
  visit "/"
  fill_in "name", with: user
  fill_in "password", with: password
  click_button "Log In"
end
