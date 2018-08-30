# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  allow_password_change  :boolean          default(FALSE)
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string
#  encrypted_password     :string           default(""), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  provider               :string           default("email"), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  tokens                 :json
#  uid                    :string           default(""), not null
#  unconfirmed_email      :string
#  username               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_uid_and_provider      (uid,provider) UNIQUE
#  index_users_on_username              (username) UNIQUE
#


describe User do
  subject do
    create(:user, :confirmed)
  end

  it "is creatable" do
    create(:user)
    user = User.first
    expect(user.email).not_to be_blank
    expect(user.username).not_to be_blank
    expect(user.password).to be_blank
  end

  it "follows lessons link" do
    create(:user, :with_lessons)
    user = User.first
    expect(user.lessons.first.creator).to eq(user)
  end

  it "cascade destroys its lessons" do
    user = create(:user, :with_lessons)
    expect{ user.destroy }.to change(Lesson, :count).to(0)
  end

  it "doesn't need confirmation" do
    expect(create(:user).confirmation_required?).to be_falsey
  end

  context "As devise_token_auth doesn't use serializers _sigh_" do
    it "returns the right fields in a JSON" do
      user_json = JSON.parse(subject.to_json)
      expect(user_json['id']).to eq(subject.id)
      expect(user_json['uid']).to eq(subject.uid)
      expect(user_json['email']).to eq(subject.email)
      expect(user_json['username']).to eq(subject.username)
      expect(user_json['provider']).to eq(subject.provider)
      expect(user_json['confirmed_at']).to eq(subject.confirmed_at.as_json)
    end
  end

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:username) }
  it { is_expected.to validate_uniqueness_of(:username).case_insensitive }
end

