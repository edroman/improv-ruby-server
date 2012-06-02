class Sentence < ActiveRecord::Base

  belongs_to :story

  # one-to-many requires belongs_to rather than has_one
  belongs_to :constraint

  accepts_nested_attributes_for :constraint
  validate :validate_sentence

  def validate_sentence
    # Check if sentence has constraint inside it. If not, display an error.
    # TODO: the error is not being propagated up.  story.curr_sentence doesn't check in-memory models with errors!
    if (self.body && (self.body.length < 0 || !self.body.downcase.match(self.constraint.phrase.downcase)))
      errors.add :sentence, "must use the word #{self.constraint.phrase}!"
      return :sentence
    end
  end

  # Adds bold formatting around constraint within sentence
  def body_formatted
    return "" if body == nil || body == ""
    start_pos = body.downcase.index(constraint.phrase.downcase)
    return body if start_pos == nil

    end_pos = start_pos + constraint.phrase.length

    # Increment end_pos until we've reached the end of the current word (due to pluralization issues) or reached the end of the body
    until end_pos == body.length || /[^A-Za-z]/.match(body[end_pos])
      end_pos += 1
    end


    new_body = body.clone
    new_body.insert end_pos, '</strong>'
    new_body.insert start_pos, '<strong>'
    return new_body
  end

  def body=(body)
    self[:body] = body

    return if body == nil || body.length == 0

    last_letter = body[body.length-1]
    self[:body] += "." if !last_letter.match(/[.?!]/)
  end
end
