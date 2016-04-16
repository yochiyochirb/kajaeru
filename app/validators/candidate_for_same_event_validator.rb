class CandidateForSameEventValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    # Avoid voter votes to candidate of different event
    record.errors.add(
      attribute,
      'cannot be voted because of candidate for different event'
    ) unless record.voter.event == record.candidate.event
  end
end
