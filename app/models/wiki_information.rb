class WikiInformation < ActiveRecord::Base

  attr_accessible :created_by, :is_private, :name

  has_many :pages, :dependent => :destroy
  has_many :private_memberships, :dependent => :destroy
  has_many :visible_authority_users, :through => :private_memberships, :source => :user
  has_many :visibilities, :dependent => :destroy
  has_many :visible_wikis, :through => :visibilities, :source => :user
  belongs_to :creator, :class_name => 'User', :foreign_key => 'created_by'

  validates :name, :presence => true, :uniqueness => true, :format => { :with => /\A[-a-z]+\Z/i, :message => :wrong_format_wiki_name}

  before_update :rename_repository_directory
  after_create :prepare_git_repository
  after_destroy :cleanup_git_repository

  BASE_GIT_DIRECTORY = Rails.root.join('data')

  scope :accessible_by, ->(user) do
    if user.admin?
      all
    elsif user.limited
      user.visible_wikis
    else
      WikiInformation.where(:is_private => false) + user.private_wiki_informations
    end
  end

  def private?
    is_private?
  end

  def git_directory(overwrite_name = nil)
    BASE_GIT_DIRECTORY.join("#{overwrite_name or name}.git").to_s
  end

  def collaborator_for_private_wiki?(user)
    membership = private_memberships.find_by_user_id(user.id)
    return false unless membership
    return true if membership.admin?
    false
  end

  private

  def rename_repository_directory
    return unless self.name_changed?
    before, after = self.name_change
    File.rename(self.git_directory(before), self.git_directory(after))
  end

  def prepare_git_repository
    Grit::Repo.init(self.git_directory)
    self.pages.create(:name => 'Welcome', :body => 'Getting started guide', :updated_by => self.created_by)

    if is_private?
      self.private_memberships.create(:user_id => self.created_by, :admin => true)
    end
  end

  def cleanup_git_repository
    FileUtils.rm_rf(self.git_directory)
  rescue => e
    logger.warn "Failed Cleanup Git Repository: #{e.message}"
  end


end
