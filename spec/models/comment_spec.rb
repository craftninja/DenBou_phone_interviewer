require 'spec_helper'

describe Comment do
  describe "validations" do

    let(:comment) {Comment.new(body: 'foo', user_id: 1, recording_id: 1)}

    it 'must have a body' do
      expect(comment).to be_valid
      comment.body = nil
      expect(comment).to_not be_valid
    end

    it 'must have a user_id' do
      expect(comment).to be_valid
      comment.user_id = nil
      expect(comment).to_not be_valid
    end

    it 'must have a recording_id' do
      expect(comment).to be_valid
      comment.recording_id = nil
      expect(comment).to_not be_valid
    end
  end
end