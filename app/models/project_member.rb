# == Schema Information
#
# Table name: project_members
#
#  id         :integer          not null, primary key
#  project_id :integer          not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ProjectMember < ApplicationRecord
  belongs_to :project, counter_cache: true
  belongs_to :user, class_name: 'User'
end
