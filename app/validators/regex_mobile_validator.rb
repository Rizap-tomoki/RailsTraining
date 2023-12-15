class RegexMobileValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)

    return if value.nil?
  
    unless value =~ /\A\d{3}-\d{4}-\d{4}\z/
      record.errors.add(attribute, "は無効な形式です")
    end
  end

end