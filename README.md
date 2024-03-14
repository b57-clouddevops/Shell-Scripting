# Shell-Scripting

This is a repository for learning BASH and automating the entire configuration management using BASH.
We will place all the files in a serial order that gives you the approach which one to look first and next

So please practice them in the serial order.

For Authentcation, GITHUB offers PAT ( Personal Access Token )

Before you make a first push, ensure you generate the token, 

    On your account ----> profile ----> Settings -----> Developer Settings -----> Classic Token ( This is sensitive )


### Whenever you design anything, makesure that piece of automation should work for other environments as well ( prod, non-prod, qa, dev )

## Best Practices To Be Followed for a better automation :

    1) Always consider something as working if it works multiple times.
    2) Try to avoid the repetivie code and utilize functions as much as possible to avoid the code duplication.



### DRY Code vs WET Code ?

    DRY : Don't Repeat Yourself (DRY) is a software development principle, the main aim of which is to reduce repetition of code
    WET : Write Everything Twice


### Point To Be Notes When Dealing Internal DNS Record 

    1) When you create any Private DNS Record, don't prefer to delete anytime.
    2) Just update the IP
    3) If you delete the Private DNS Record and try to create again, sometimes it would take up to 24 hours.

# What we have achieved ?
    1) We have parameterized the code, so that with very minimal changes we were able to re-use the code
    2) But is our code still DRY ?
