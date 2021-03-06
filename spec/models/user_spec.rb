require 'spec_helper'

describe User do
  describe '#valid?' do
    subject {User.new(email: nil) }
    it { should be_invalid }
    it { subject.activation_state.should be_nil}
    it { subject.admin.should be_false}
    it { subject.limited.should be_false}
  end

  describe '#role' do
    context 'admin' do
      let(:admin_user) {create(:admin_user)}
      subject{admin_user.role}
      it {should eq 'admin'}
    end
    context 'member' do
      let(:user) {create(:user)}
      subject{user.role}
      it {should eq 'member'}
    end
    context 'guest' do
      let(:guest) {create(:guest)}
      subject{guest.role}
      it {should eq 'guest'}
    end
  end

  describe '#role=' do
    let(:user) {create(:user)}
    context 'admin' do
      subject{user.tap{|u| u.role = 'admin'}}
      it {subject.role.should eq 'admin'}
      it {subject.admin.should be_true}
      it {subject.limited.should be_false}
    end
    context 'member' do
      subject{user.tap{|u| u.role = 'member'}}
      it {subject.role.should eq 'member'}
      it {subject.admin.should be_false}
      it {subject.limited.should be_false}
    end
    context 'guest' do
      subject{user.tap{|u| u.role = 'guest'}}
      it {subject.role.should eq 'guest'}
      it {subject.admin.should be_false}
      it {subject.limited.should be_true}
    end
  end

  describe '#lock_or_destroy_by' do
    let!(:admin_user){create(:admin_user)}
    let!(:user){create(:user)}
    let!(:locked_user){create(:user).destroy}

    context 'active user' do
      subject{user.tap{|u| u.lock_or_destroy_by(admin_user)}}
      its(:deleted) {should be_true}
    end

    context 'locked user' do
      it 'deleted user' do
        u = User.with_deleted.find_by(email: locked_user.email)
        expect {
          u.lock_or_destroy_by(admin_user)
        }.to change(User.with_deleted, :count).by(-1)
      end
    end

    context "doesn't work lock when operation myself" do
      subject{admin_user.tap{|u| u.lock_or_destroy_by(admin_user)}}
      its(:deleted){should be_false}
    end
  end

  context 'soft delete (never_wastes)' do
    describe '#destroy' do
      let!(:user) {create(:user)}
      let!(:deleted_user) {create(:user).destroy}
      subject {User.all}
      it {should_not be_include(deleted_user)}
    end
  end
end
