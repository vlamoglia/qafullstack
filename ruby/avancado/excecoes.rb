# begin
#   file = File.open("./ola")

#   if file
#     puts file.read
#   else
#   end
# rescue Exception => e
#   #   puts e
#   puts e.message
#   puts e.backtrace
# end

def soma(n1, n2)
  n1 + n2
rescue Exception => e
  #   puts e
  puts e.message
  puts e.backtrace
  puts "Erro ao executar a soma"
end

soma("1", 2)
