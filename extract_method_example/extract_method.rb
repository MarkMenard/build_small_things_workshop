def print_invoice_for_amount (amount)
  print_header
  puts "Name: #{@name}"
  puts "Amount: #{amount}"
end

def print_invoice_for_amount (amount)
  print_header
  print_details (amount)
end

def print_details (amount)
  puts "Name: #{@name}"
  puts "Amount: #{amount}"
end