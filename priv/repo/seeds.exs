alias Retrospectivex.Accounts

# Create a default administrator
Accounts.create_administrator(%{
  email: "example@example.com",
  password: "123456",
  first_name: "Example",
  last_name: "Example"
})
