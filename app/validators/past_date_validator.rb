class PastDateValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
        if value.present? && value > Date.today
            record.errors.add(attribute, "誕生日が未来の日付になっています")
        end
    end
end