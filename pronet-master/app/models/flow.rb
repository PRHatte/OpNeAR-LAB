# == Schema Information
#
# Table name: flows
#
#  id             :integer          not null, primary key
#  ext_flow_id    :integer
#  title          :string
#  dst            :string
#  src            :string
#  status         :integer
#  start_time     :datetime
#  end_time       :datetime
#  min_bandwidth  :decimal(, )
#  max_bandwidth  :decimal(, )
#  bandwidth_unit :string
#  latency        :integer
#  method         :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  bw             :decimal(, )
#  duration       :decimal(, )
#  startt         :decimal(, )
#  user_id        :integer
#
# Indexes
#
#  index_flows_on_ext_flow_id  (ext_flow_id) UNIQUE
#

class Flow < ApplicationRecord
    METHOD = ['TCP', 'UDP', 'IP', 'MAC']
    BANDWIDTH_UNITS = ['GB/s', 'MB/s', 'KB/s', 'B/s']
    # When modifiying this array, ONLY APPEND THINGS TO THE BACK!!!!
    # If you don't, you will modify production data
    STATES = [:not_approved, :pending_scheduling, :scheduled, :denied]

    scope :unapproved, -> { where(status: 0) }
    scope :pending, -> { where(status: 1) }
    scope :scheduled, -> { where(status: 2) }
    scope :denied, -> { where(status: 3) }

    validates :title, presence: true
    validates :dst, presence: true
                    # format: { with: /\d{1,3}.\d{1,3}.\d{1,3}.\d{1,3}/ }
    validates :src, presence: true
                    # format: { with: /\d{1,3}.\d{1,3}.\d{1,3}.\d{1,3}/ }
    validates :start_time, presence: true
    validates :end_time, presence: true
    validates :min_bandwidth, presence: true
    validates :max_bandwidth, presence: true
    validates :latency, presence: true
    validates :method,  presence: true,
                        inclusion: { in: METHOD }
    # validates :bw, presence: true
    # validates :duration, presence: true
    validates :bandwidth_unit,  presence: true,
                                inclusion: { in: BANDWIDTH_UNITS }

    belongs_to :user

    # after_commit :add_flow_to_orchestrator
    # after_destroy :delete_flow_from_orchestrator

    after_initialize do
        self.status ||= 0 # Set to not approved
    end

    def english_status
        STATES[self.status].to_s.humanize
    end

    protected

    # Disabled for demo purposes
    # def add_flow_to_orchestrator
    #     FlowWorker.perform_async(1, self.id)
    # end

    # def delete_flow_from_orchestrator
    #     FlowWorker.perform_async(2, self.id)
    # end
end
