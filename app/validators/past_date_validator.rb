class PastDateValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
        if value.present? && value > Time.zone.today
            record.errors.add(attribute, "未来の日付になっています")
        end
    end
end