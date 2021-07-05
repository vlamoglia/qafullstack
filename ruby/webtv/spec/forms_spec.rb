describe "TestRail maintenance" do
  before do
    #Change the data below - START
    usr = "yourJiraemail"
    pwd = "yourpassword"
    projName = "WEBTV - BigScreen React Client"
    #END

    logInTR(usr, pwd)
    sleep 1
    click_link(projName, match: :first)
    sleep 1
  end

  it "test", :skip => true do
    #allRefs = "WEBTV-1757,WEBTV-1788,WEBTV-1801,WEBTV-1817,WEBTV-1818,WEBTV-1835,WEBTV-1853,WEBTV-1861,WEBTV-1878,WEBTV-1887,WEBTV-1889,WEBTV-1904,WEBTV-1915,WEBTV-1916,WEBTV-1917,WEBTV-1927,WEBTV-1928,WEBTV-1930,WEBTV-1931,WEBTV-1935,WEBTV-1939,WEBTV-1940,WEBTV-1942,WEBTV-1946,WEBTV-1948,WEBTV-1956,WEBTV-1958,WEBTV-1963,WEBTV-1964,WEBTV-1966,WEBTV-1967,WEBTV-1968,WEBTV-1969,WEBTV-1973,WEBTV-1974,WEBTV-1975,WEBTV-1978,WEBTV-1982,WEBTV-1987,WEBTV-1990,WEBTV-1991,WEBTV-1994,WEBTV-1997,WEBTV-2000,WEBTV-2001,WEBTV-2014,WEBTV-2022,WEBTV-2037,WEBTV-2045,WEBTV-2046,WEBTV-2048,WEBTV-2051,WEBTV-2054,WEBTV-2058,WEBTV-2059,WEBTV-2060,WEBTV-2064,WEBTV-2092,WEBTV-2095,WEBTV-2097,WEBTV-2099,WEBTV-2104,WEBTV-2106,WEBTV-2121,WEBTV-2122,WEBTV-2124,WEBTV-2143,WEBTV-2177,WEBTV-2226,WEBTV-2303,WEBTV-2311,WEBTV-2340,WEBTV-2348,WEBTV-2370,WEBTV-2473,WEBTV-2474,WEBTV-2475,WEBTV-2476,WEBTV-2478,WEBTV-2480,WEBTV-2483,WEBTV-2484,WEBTV-2485,WEBTV-2539,WEBTV-2550,WEBTV-2559,WEBTV-2702"
    evt = {}
    href = {}
    oldRef = {}
    oldDef = {}
    href[0] = "https://zattoo2.testrail.net/index.php?/cases/view/99629"
    href[1] = "https://zattoo2.testrail.net/index.php?/cases/view/160941"
    oldRef[0] = "WEBTV-1935"
    oldRef[1] = "WEBTV-1935"
    oldDef[0] = "WEBTV-1935"
    oldDef[1] = ""

    i = 0
    href.each do |el|
      evt[i] = OpenStruct.new
      evt[i].href = href[i]
      evt[i].oldRef = oldRef[i]
      evt[i].oldDef = oldDef[i]
      i += 1
    end

    i = 0
    evt.each do |el|
      puts el[1].href
      puts "href: " + evt[1].href
      puts "oldRef: " + evt[1].oldRef
      puts "oldDef: " + evt[1].oldDef
      puts "Pass: "
      puts i
      i += 1
    end
  end

  it "Move bug ticket ids from References to Defects" do
    find("input.top-search-control").click.set("WEBTV-29").native.send_keys(:return)
    sleep 1
    table_Links = []
    table_TC = find("h2", text: "Test Cases").first(:xpath, "./following-sibling::table")

    table_TC.all(:css, ".link-noline").each do |el|
      table_Links.push(el[:href])
    end

    allRefs = ""
    evt = {}

    i = 0
    table_Links.each do |el|
      evt[i] = OpenStruct.new

      visit(el)

      evt[i].href = el.dup

      oldRef_str = ""

      page.all(:css, ".referenceLink").each do |el2|
        oldRef_str += el2.text + ","
      end

      oldRef_str = oldRef_str.nil? ? "" : oldRef_str.chomp(",")
      evt[i].oldRef = oldRef_str.split(",").reverse.uniq.reverse.join(",")

      evt[i].oldDef = ""
      if has_css?("label", text: "Defects", wait: 0)
        defect_str = find("[id=cell_custom_defects]").text
        defect_str.slice! "Defects\n"
        evt[i].oldDef = defect_str.split(",").reverse.uniq.reverse.join(",")
      end

      if oldRef_str != ""
        allRefs += evt[i].oldRef + ","
      end
      i += 1
    end

    allRefs = allRefs.split(",").reverse.uniq.reverse.join(" ").split(/ /).sort

    #Change the data below - START
    logInJ("yourTestRailemail", "yourpassword")
    #end
    bugRefs = ""
    allRefs.each do |el4| # https://zattoo2.atlassian.net/l/c/9wuajs3u
      if el4.start_with?(/[A-Z]+-/)
        visit "https://zattoo2.atlassian.net/browse/" + el4
        if has_css?("img[alt=Bug]", wait: 0)
          bugRefs += el4 + ","
        end
      end
    end

    bugRefs = bugRefs.split(",").join(" ").split(/ /).sort

    f = File.open("logMoveBugIDs.txt", "w+")
    i = 0
    evt.each do |el5|
      oldRef = evt[i].oldRef.split(",").reverse.uniq.reverse.join(" ").split(/ /).sort

      newRef = ""
      newDef = ""
      oldRef.each do |el6|
        if bugRefs.include? el6
          newDef += el6 + ","
        else
          newRef += el6 + ","
        end
      end
      newDef = newDef + evt[i].oldDef
      evt[i].newDef = newDef.split(",").reverse.uniq.reverse.join(" ").split(/ /).sort.join(",")
      evt[i].newRef = newRef.split(",").reverse.uniq.reverse.join(" ").split(/ /).sort.join(",")

      if evt[i].oldRef != evt[i].newRef || evt[i].oldDef != evt[i].newDef
        puts "Link: " + evt[i].href
        puts "Old reference: " + evt[i].oldRef
        puts "New reference: " + evt[i].newRef
        puts "Old defect: " + evt[i].oldDef
        puts "New defect: " + evt[i].newDef
        f.puts evt[i]
        visit(evt[i].href)
        sleep 2
        click_link("Edit", match: :first)
        sleep 1
        find("input#refs").set("").set(evt[i].newRef)
        find("input#custom_defects").set("").set(evt[i].newDef)
        find("[id=accept]").click
        sleep 1
      end
      i += 1
    end
  end

  it "Replace ZRB references with WEBTV", :skip => true do
    oldReference = "ZRB-"
    newReference = "WEBTV-"

    find("input.top-search-control").click.set(oldReference).native.send_keys(:return)
    sleep 1
    table_Links = []
    table_TC = find("h2", text: "Test Cases").first(:xpath, "./following-sibling::table")

    table_TC.all(:css, ".link-noline").each do |el|
      table_Links.push(el[:href])
    end

    evt = OpenStruct.new
    f = File.open("logReplaceZRB.txt", "w+")

    table_Links.each do |el|
      visit(el)

      evt.href = el.dup
      #puts "Link: " + evt.href

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

def logInTR(user, password)
  visit "/"
  fill_in "name", with: user
  fill_in "password", with: password
  click_button "Log In"
end

def logInJ(user, password)
  visit "https://zattoo2.atlassian.net"
  fill_in "username", with: user
  find("[id=login-submit]").click
  sleep 3
  fill_in "password", with: password
  sleep 3
  find("[id=login-submit]").click
  sleep 3
end
