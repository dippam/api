module IedRecordsHelper
  def highlight(text, phrases, *args)
    unless phrases.nil?
      m = phrases.match(/\"(.+)\"/) 
      phrases = m.nil? ? phrases.scan(/\w+/) : m[1]
    end
    super
  end
end
