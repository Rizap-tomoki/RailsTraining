class RegexPostcodeValidator < ActiveModel::EachValidator

    def validate_each(record, attribute, value)
     unless value =~ /\A\d{3}-\d{4}\z/
        record.errors.add(attribute, "は無効な形式です")
     end
    end
 
end