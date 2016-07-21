#
module ListenNotify
  extend ActiveSupport::Concern

  # included do
  #   after_update :notify_update
  # end

  private

  def on_update_listen_notify_channel
    "#{self.class}#update(#{id})"
  end

  def on_create_listen_notify_channel
    "#{self.class}::create"
  end

  def notify_update
    root = self.class.to_s.downcase
    payload = { root => changes }.to_json
    self.class.connection.execute(
      "NOTIFY \"#{on_update_listen_notify_channel}\", '#{payload}'"
    )
  end

  public

  def listen_for_update(timeout)
    connection = self.class.connection
    connection.execute "LISTEN \"#{on_update_listen_notify_channel}\""
    timed_out = false
    until timed_out
      timed_out = !connection.raw_connection.wait_for_notify(timeout) do |event, pid, data|
        yield event, data, pid
      end
    end
  ensure
    connection.execute "UNLISTEN \"#{on_update_listen_notify_channel}\""
  end

  #
  module ClassMethods
    def notify_on_update
      after_update :notify_update
    end

    def notify_create
      connection.execute(
        "NOTIFY \"#{on_create_listen_notify_channel}\", '#{changes}'"
      )
    end

    def listen_for_create
      connection.execute "LISTEN comments"
      loop do
        connection.raw_connection.wait_for_notify do |event, pid, data|
          yield data
        end
      end
    ensure
      connection.execute 'UNLISTEN comments'
    end
  end
end
