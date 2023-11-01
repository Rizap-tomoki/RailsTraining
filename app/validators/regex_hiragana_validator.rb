class RegexHiraganaValidator < ActiveModel::EachValidator

    def validate_each(record, attribute, value)
      unless value =~ /\A[ァ-ヶー－]+\z/
        record.errors.add(attribute, "は無効な形式です")
      end
    end
  
end