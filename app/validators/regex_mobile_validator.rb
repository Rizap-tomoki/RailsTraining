class RegexMobileValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    # value が nil の場合は検証をスキップする
    return if value.nil?
  
    unless value =~ /\A\d{2,5}-\d{1,4}-\d{4}\z/
      record.errors.add(attribute, "は無効な形式です")
    end
  end

end