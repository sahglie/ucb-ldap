#UC Berkeley LDAP

UCB::LDAP is a wrapper module around Net::LDAP intended to simplify searching the UC Berkeley
LDAP directory: http://directory.berkeley.edu

##Introduction to LDAP
If you are blissfully ignorant of LDAP, you should familiarize yourself with some of the basics.
Here is a great online resource: http://www.zytrax.com/books/ldap

The RDoc for the ruby-net-ldap Gem (http://rubyfurnace.com/docs/ruby-net-ldap-0.0.4/classes/Net/LDAP.html) also has a good introduction to LDAP.


##Examples

###General Search

Search the directory specifying tree base and filter, getting back generic `UCB::LDAP::Entry` instances:

```ruby
  entries = UCB::LDAP::Entry.search(:base => "ou=people,dc=berkeley,dc=edu", :filter => {:uid => 123})
  entries.class            #=> Array
  entries[0].class         #=> UCB::LDAP::Entry
  entries[0].uid           #=> '123'
  entries[0].givenname     #=> 'John'
  entries[0].sn            #=> 'Doe'
```

See `UCB::LDAP::Entry` for more information.

###Person Search

Search the Person tree getting back UCB::LDAP::Person instances:

```ruby
  person = UCB::LDAP::Person.find_by_uid("123")
  person.firstname           #=> "John"
  person.affiliations        #=> ['EMPLOYEE-TYPE-STAFF']
  person.employee?           #=> true
  person.employee_staff?     #=> true
  person.employee_academic?  #=> false
  person.student?            #=> false
```

See `UCB::LDAP::Person` for more information.

###Org Unit Search

Search the Org Unit tree getting back `UCB::LDAP::Org` instances:

``` ruby
  dept = UCB::LDAP::Org.org_by_ou('jkasd')
  dept.deptid         #=> "JKASD"
  dept.name           #=> "Administrative Systems Dept"
```

See `UCB::LDAP::Org` for more information.

###Privileged Binds

If you want access the directory anonymously, no credentials are required.
If you want to access via a privileged bind, authenticate before querying:

```ruby
  p = UCB::LDAP::Person.find_by_uid("123")
  p.non_public_attr    #=> NoMethodError

  UCB::LDAP.authenticate("mybind", "mypassword")
  p = UCB::LDAP::Person.find_by_uid("123")
  p.non_public_attr    #=> "some value"
```

###Privileged Binds and Rails

See `UCB::LDAP.bind_for_rails`

##Dependencies

* Net::LDAP
* Ruby 1.9.2 or better

##Maintainers

* Steven Hansen
* Steve Downey
