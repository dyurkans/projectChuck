class User < ActiveRecord::Base
  # Use built-in rails support for password protection
  has_secure_password  

  attr_accessible :active, :email, :guardian_id, :password, :password_confirmation, :role

  # Relationships
  belongs_to :guardian
  
  before_save :reformat_email
  
  # Validations
  validates_uniqueness_of :email, :case_sensitive => false
  validates_format_of :email, :with => /^[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))$/i, :message => "is not a valid format"
  validates_inclusion_of :active, :in => [true, false], :message => "must be true or false"
  validates_inclusion_of :role, :in => %w[admin member], :message => "is not recognized by the system"
  # validate :guardian_is_active_in_system, :on => :create
  scope :alphabetical, joins(:guardian).order('last_name')

  # for use in authorizing with CanCan
  ROLES = [['Administrator', :admin], ['Member', :member]]

  def role?(authorized_role)
    if role.nil? then false else role.downcase.to_sym == authorized_role end
  end

  def self.eligible_guardians(guard)
    @guardians = Guardian.alphabetical
    @eligible_guardians = []
    for g in @guardians
        if g.user.nil? || g == guard
            @eligible_guardians << g
        end
    end
    @eligible_guardians
  end
  
  # alternative methods (some find more natural...)
  def is_admin?
    role == 'admin'
  end
  
  def is_member?
    role == 'member'
  end

  # login by email address
  def self.authenticate(email, password)
    find_by_email(email).try(:authenticate, password)
  end
  
  private
  def reformat_email
    email = self.email.downcase  # change email to be all lowercase 
    self.email = email       # reset self.email to new lowercase email
  end
  
  def guardian_is_active_in_system
    # get an array of all active guardians in the system
    active_guardian_ids = Guardian.active.all.map{|g| g.id}
    # add error unless the guardian id of the registration is in the array of active guardians
    unless active_guardian_ids.include?(self.guardian_id)
      errors.add(:guardian, "is not an active guardian in the system")
    end
  end

end
