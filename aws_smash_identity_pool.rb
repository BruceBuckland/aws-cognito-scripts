require 'json'
require 'pry'

data = JSON.parse(`aws cognito-identity list-identities --identity-pool-id "<your identity-pool-id here >" --max-results 60`)

good = 0
unauthenticated = 0
disabled = 0
delete_list = ""


data["Identities"].each do |variable|
  if variable["Logins"] != nil && variable["Logins"][0] != "DISABLED" #
    good += 1
   puts("\nGood ID #{variable["IdentityId"]}")
   puts(variable["Logins"])
  delete_list += "\"#{variable["IdentityId"]}\" "
  elsif variable["Logins"] == nil
    unauthenticated += 1
   delete_list += "\"#{variable["IdentityId"]}\" " # don't delete these, it really screws things up because the keychains contain them
   puts("\nGood ID #{variable["IdentityId"]}")
   puts("Un-Authenticated - in use by user that has not logged in")
  else
    disabled += 1
    delete_list += "\"#{variable["IdentityId"]}\" "
   puts("\nDisabled ID #{variable["IdentityId"]} once used #{variable["Logins"]}")
  end
end
puts("\n\n#{good} Good ID's\n #{unauthenticated} Unauthenticated ID's\n #{disabled} Disabled ID's")
puts("Deleting all identities (up to 60 identity max)")
data2 = JSON.parse(`aws cognito-identity delete-identities --identity-ids-to-delete #{delete_list}`)
puts(data2)
