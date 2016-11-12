class EmailProcessor
  def initialize(email)
    @email = email
  end

  # process is called on every new object/email sent.
  def process
    # all of your application-specific code here - creating models,
    # processing reports, etc

    # Grab the 'to' emails @email.to -> array of hashes. array hash :email
    # grab the 'cc' emails @email.cc array hash :email
    

    # from - hash containing sender address information. .


    #raw_text v. #body?


  end
end
