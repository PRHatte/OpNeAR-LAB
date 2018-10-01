# == Schema Information
#
# Table name: user_host_links
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  host_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_user_host_links_on_host_id_and_user_id  (host_id,user_id)
#

class UserHostLink < ApplicationRecord
  belongs_to :user, class_name: "User"
  belongs_to :host, class_name: "Pronet::Host"
end
