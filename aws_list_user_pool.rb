require 'json'
require 'pry'

# EMSFed pool
data = JSON.parse(`aws cognito-idp list-users --user-pool-id <your user-pool-id I.E us-east-1_xxxxxxxx>`)

good_array = []

data["Users"].each do |user|
  line = "Created:" + user["UserCreateDate"].to_s
  line += " Updated:" + user["UserLastModifiedDate"].to_s
  difference = user["UserLastModifiedDate"] - user["UserCreateDate"]
  line += " Diff:" + difference.to_s
  line += " " + user["Username"]
  user["Attributes"].each do |attribute|
    if attribute["Name"] == "email"  || attribute["Name"] == "phone_number"
      line += " " + attribute["Name"] + " " + attribute["Value"]
    end
  end
  good_array << line
end

binding.pry
print_array = good_array.sort.reverse
print_array.each do |line|
  puts line
end
