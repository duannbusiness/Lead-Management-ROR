# frozen_string_literal: true

class BlobValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, values)
    return unless values.attached?

    Array(values).each do |value|
      record.errors.add(attribute, 'Image must be in jp/jpeg/png format') unless valid_content_type?(value.blob)
    end
  end

  private

  def valid_content_type?(blob)
    return true if options[:content_type].nil?

    case options[:content_type]
    when Regexp
      options[:content_type].match?(blob.content_type)
    when Array
      options[:content_type].include?(blob.content_type)
    when Symbol
      blob.public_send("#{options[:content_type]}?")
    else
      options[:content_type] == blob.content_type
    end
  end
end
