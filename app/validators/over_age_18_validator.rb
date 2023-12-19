class OverAge18Validator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
        if value.present? && value > 18.years.ago.to_date
            record.errors.add(attribute, "は18歳以上である必要があります")
        end
    end
end