/					< ROOT >
/admin/admins/...							(for admin login, admin user-management)
/user/...									(for user CRUD and sessions handling)
/user/dashboard/...							(for user to view and manage their subscription, payments and sites)
/user/site/(... || :site_id)/...			(where user CRUDs mobile sites)
/pricing									(where user views pricing options & products)
/features									(where user views features)
/preview									(where guest user plays with the creator-- requires EMAIL address)
/preview/publish							(where guest user recieves temporary link to their site and Call To Action)
/checkout/:subscription_type				(where guest is sent after choosing a package to purchase)


Create a Layout for the Creator to be inserted into other pages.

CONTROLLERS

home
subscriptions
payments
checkout
sites
