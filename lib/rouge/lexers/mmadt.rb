# -*- coding: utf-8 -*- #
# frozen_string_literal: true

module Rouge
  module Lexers
    class MmADT < RegexLexer
      title "mm-ADT"
      desc %q(<desc for="this-lexer">mm-ADT</desc>)
      tag 'mmadt'
      filenames '*.mmadt'
      mimetypes 'text/mm-adt', 'application/mm-adt'

      def self.opcodes
        @opcodes ||= Set.new %w(
          map db get new op path start type union
          filter and coin has hasKey hasValue hasValue or is
          barrier dedup order range sample tail
          reduce count fold group map mean media min sum 
          sideEffect add as define drop fit put
        )
      end

      def self.operators
        @operators ||= Set.new %w(
          between eq gt gte lt lte neq regex typeof within 
          plus div mod mult pow sub
          len split
        )
      end

      state :root do
        rule %r/\s+/m, Text
        rule %r/\/\/.*/, Comment::Single
        
        rule %r/\[/, Punctuation
        rule %r/,/, Punctuation
        rule %r/\]/, Punctuation
        rule %r/\(/, Punctuation
        rule %r/\)/, Punctuation
        rule %r/\{/, Punctuation
        rule %r/\}/, Punctuation
        rule %r/</, Punctuation
        rule %r/>/, Punctuation
        rule %r/'/, Punctuation
        rule %r/"/, Punctuation
           
        rule %r/@\w*/, Keyword::Variable   
                
        rule %r/\w\w*/ do |m|
          if self.class.opcodes.include? m[0]
            token Keyword::Reserved
          elsif self.class.operators.include? m[0]  
            token Keyword::Type          
          else
            token Name::Function
          end
        end    
        
        rule %r/\./, Name::Function          
        
        rule %r/=>/, Keyword::Constant
        rule %r/->/, Keyword::Constant
        rule %r/&/, Operator
        rule %r/\*/, Operator
        rule %r/!/, Keyword::Constant
        rule %r/:/, Operator
        rule %r/\|/, Operator
        rule %r/\$/, Operator
        rule %r/\~/, Operator
        rule %r/-/, Operator
        rule %r/\?/, Operator        
        rule %r/\+/, Operator
        
      end
    end
  end
end
