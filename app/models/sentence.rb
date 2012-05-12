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

  def body=(body)
    self[:body] = body

    return if body == nil || body.length == 0

    last_letter = body[body.length-1]
    self[:body] += "." if !last_letter.match(/[.?!]/)
  end
end
