# frozen_string_literal: true

describe Rouge::Lexers::MmAdt do
  let(:subject) { Rouge::Lexers::MmAdt.new }

  describe 'guessing' do
    include Support::Guessing

    it 'guesses by filename' do
      assert_guess :filename => 'foo.mmadt'
    end

    it 'guesses by mimetype' do
      assert_guess :mimetype => 'application/mmadt'
    end
  end
end
