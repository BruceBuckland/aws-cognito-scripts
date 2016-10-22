# aws-cognito-scripts

- Three little ruby files to help during development with cognito-identity.
As I tested my apps I found that a lot of disabled identities got created.  
This made it hard to check using the console.  So i created a script that listed
up to 60 identities (an aws cli max).  Then I created one that would delete
disabled identities.  And finally one that would smash the whole pool
by deleting all the identities.  Be careful with that last one because it will
cause you to need to reset the simulator / development ios device because the
keychains left around by cognito will be looking for identities that have
disappeared.
