require "icalendar"
require "ostruct"
require "date"

year = 2020

data = File.readlines("dynamic.txt") #cada linha do texto que nao esteja vazia e colocada em uma celula do array
data.map! { |line| line.gsub(/Jan/, "01") } #invoke on each line gsub
data.map! { |line| line.gsub(/Feb/, "02") }
data.map! { |line| line.gsub(/Mar/, "03") }
data.map! { |line| line.gsub(/Apr/, "04") }
data.map! { |line| line.gsub(/May/, "05") }
data.map! { |line| line.gsub(/Jun/, "06") }
data.map! { |line| line.gsub(/Jul/, "07") }
data.map! { |line| line.gsub(/Aug/, "08") }
data.map! { |line| line.gsub(/Sep/, "09") }
data.map! { |line| line.gsub(/Oct/, "10") }
data.map! { |line| line.gsub(/Nov/, "11") }
data.map! { |line| line.gsub(/Dec/, "12") }
data.map! { |line| line.gsub(year.to_s + "Entering", year.to_s + ", Entering") }
data.map! { |line| line.gsub(/\n/, "") }
#data.each_with_index { |val, index| puts "#{val} => #{index}" }
File.open("test.txt", "w+") { |f| f.puts data } #output data to other file

index = 0

# Create a calendar with an event (standard method)
cal = Icalendar::Calendar.new

while index < data.length
  #puts index
  if data[index].start_with?("TRANSITING", "PROGRESSED", "ECLIPSE", "DIRECTED")
    evt = OpenStruct.new
    #arrayDate = Array.new
    #incluir no calendario
    #puts data[index]
    evt.summary = data[index]

    index += 1
    #while data[index] != nil
    # if data[index].start_with?("In Orb", "Entering")
    #   if data[index].start_with?("In Orb")
    #     # setar no calendario Janeiro 2020
    #     data[index].slice!("In Orb ")
    #     #puts data[index]
    #   else #Entering
    #     # setar no calendario data especificada
    #     data[index].slice!("Entering ")
    #     #puts data[index]
    #   end
    # else
    #   # data
    # end

    #puts data[index]
    #inorbArray = data[index].enum_for(:scan, /(?=In\sOrb\s)/).map { Regexp.last_match.offset(0).first }
    #enteringArray = data[index].enum_for(:scan, /(?=Entering\s)/).map { Regexp.last_match.offset(0).first }
    #leavingArray = data[index].enum_for(:scan, /(?=Leaving\s)/).map { Regexp.last_match.offset(0).first }
    # puts "enteringArray: " + enteringArray.to_s + " inorbArray: " + inorbArray.to_s + " leavingArray: " + leavingArray.to_s

    res = data[index].split(", ")
    #puts res

    i = 0
    startDate = ""
    endDate = ""
    while i < res.length
      if res[i].start_with?("In Orb ") || res[i].start_with?("Entering ")
        startDate << res[i].slice(/\d{2}\s\d{1,2}\s\d{4}/) << "|"
        i += 1
        leaving = false
        while leaving == false && i < res.length
          if res[i].start_with?("Leaving ")
            endDate << res[i].slice(/\d{2}\s\d{1,2}\s\d{4}/) << "|"
            leaving = true
            #puts leaving
          end
          i += 1
        end
        if leaving == false #&& i >= res.length
          #puts "31Dezembro"
          endDate << "12 31 " + year.to_s << "|"
        end
      elsif res[i].start_with?("Exact ")
      else #date
        startDate << res[i].slice(/\d{2}\s\d{1,2}\s\d{4}/) << "|"
        endDate << res[i].slice(/\d{2}\s\d{1,2}\s\d{4}/) << "|"
        i += 1
      end
      #puts "startDate:" + startDate
      #puts "endDate:" + endDate
    end

    # iter = inorbArray.length + enteringArray.length
    # if iter > 0
    #   leavingIdx = 0
    #   while iter > 0
    #     if data[index].start_with?("In Orb")
    #       sizeInOrb = "In Orb ".length
    #       slicedStartDate = data[sizeInOrb..data[index].length - 1] #.slice(/\d{2}\s\d{1,2}\s\d{4}/)
    #       if leavingArray == nil
    #         slicedEndDate = "12 31" + year
    #       else
    #         slicedEndDate = data[leavingArray[leavingIdx] + "Leaving ".length..data[index].length - 1] #.slice(/\d{2}\s\d{1,2}\s\d{4}/)
    #         leavingIdx += 1
    #       end
    #     else #Entering
    #       for enteringIdx in 0..enteringArray.length
    #         slicedStartDate = data[enteringArray[enteringIdx] + "Entering ".length..data[index].length - 1].slice(/\d{2}\s\d{1,2}\s\d{4}/)
    #         slicedEndDate = data[leavingArray[leavingIdx] + "Leaving ".length..data[index].length - 1].slice(/\d{2}\s\d{1,2}\s\d{4}/)
    #         leavingIdx += 1
    #       end
    #       iter -= 1
    #     end
    #   end
    # else
    #   #only dates
    # end

    index += 1

    description = data[index]

    #end

    #if description.empty?
    if description.start_with?("This aspect is not included") || description.start_with?("No text available")
      description = ""
    else
      #puts description
    end

    evt.description = description

    #   #(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\s+\d{1,2}\s+\d{4}
    #   month = data[index].slice!(/(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\s/)
    #   puts month
    #   day = data[index].slice!(/\d{1,2}\s/)
    #   puts day
    #   year = data[index].slice!(/\d{4}(\s)?/)
    #   puts year
    #   data[index].slice!(", ")
    #   leavingidx = data[index].index("Leaving")
    #   if leavingidx != nil
    #     data[index].slice!(0..leavingidx - 1)
    #     data[index].slice!("Leaving ")
    #   end
    # puts data[index]
    #Procurar o leaving
    #end

    startDateStr = startDate.split("|")
    #puts "startDateStr:" + startDateStr.to_s
    endDateStr = endDate.split("|")
    #puts "endDateStr:" + endDateStr.to_s

    j = 0
    while j < startDateStr.length
      event = Icalendar::Event.new
      event.ip_class = "PRIVATE"
      event.summary = evt.summary
      puts evt.summary
      event.description = evt.description

      monthST = startDateStr[j].slice!(/\d{2}/)
      dayST = startDateStr[j].slice!(/\d{1,2}\s/)
      yearST = startDateStr[j].slice!(/\d{4}/)
      event.dtstart = Date.strptime(yearST + "/" + monthST + "/" + dayST, "%Y/%m/%d")
      puts "START:" + event.dtstart.to_s

      monthE = endDateStr[j].slice!(/\d{2}/)
      dayE = endDateStr[j].slice!(/\d{1,2}\s/)
      yearE = endDateStr[j].slice!(/\d{4}/)
      event.dtend = Date.strptime(yearE + "/" + monthE + "/" + dayE, "%Y/%m/%d")
      puts "END:" + event.dtend.to_s

      puts evt.description

      cal.add_event(event)
      j += 1
    end
    # aqui precisa percorrer um array

    #event.dtstart = evt.dtstart
    #event.dtend = evt.dtend

  end
  index += 2
  #index = data.length

end

cal.publish

cal_string = cal.to_ical
#cal_subs = cal_subs.gsub('/\r\n/', "")
#puts cal_subs

File.open("cal_string.ics", "w+") { |f| f.puts cal_string } #output data to other file
# File.open("cal_string.ics", "w+") { |f| f.puts cal_string }
# out = File.open("cal_string2.ics", "w+")
# data2 = File.readlines("cal_string.ics") #cada linha do texto que nao esteja vazia e colocada em uma celula do array
# data2.map! { |line| out.puts line unless line.chomp.empty? } #invoke on each line gsub
# #puts data2

# File.open("cal_string3.ics", "w+") { |f| f.puts data2 } #output data to other file