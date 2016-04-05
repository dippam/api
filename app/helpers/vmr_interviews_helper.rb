module VmrInterviewsHelper
  def pretty_duration(seconds)
   seconds = seconds.to_i
   total_minutes = seconds / 1.minutes
   seconds_in_last_minute = seconds - total_minutes.minutes.seconds
   "#{total_minutes}:#{"%02d" % seconds_in_last_minute}"
  end
end
