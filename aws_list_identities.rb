require 'json'
require 'pry'

data = JSON.parse(`aws cognito-identity list-identities --identity-pool-id "<your identity-pool-id here >" --max-results 60`)
good = 0
unauthenticated = 0
disabled = 0

good_array = []
unauth_array = []


data["Identities"].each do |variable|
  if variable["Logins"] != nil && variable["Logins"][0] != "DISABLED" #
    good += 1
   good_array << "#{variable["IdentityId"]}"
   variable["Logins"].each do |provider|
   good_array[good_array.count - 1] = good_array[good_array.count - 1] + " " + provider
 end

  elsif variable["Logins"] == nil
    unauthenticated += 1
    unauth_array << "#{variable["IdentityId"]}"
  else
    disabled += 1
   puts("\nDisabled ID #{variable["IdentityId"]} once used #{variable["Logins"]}")
  end
end

puts("\n\n#{good} Good ID's\n #{unauthenticated} unauthenticated ID's\n #{disabled} Disabled ID's")
puts "Authenticated Id's"
good_array.each do |line|
  puts line
end
puts "Unauthenticated Id's"
unauth_array.each do |line|
  puts line
end


# binding.pry
