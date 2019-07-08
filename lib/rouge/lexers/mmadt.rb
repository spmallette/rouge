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
          db start
          drop
          map get loops obj path select type 
          flatmap unfold
          filter and coin has hasKey hasValue hasValue is or 
          barrier dedup order range sample tail
          reduce count fold group limit max mean median min sum 
          sideEffect as fit put
          branch at choose coalesce ifelse repeat union
          cost migrate define deref explain model new op ref
        )
      end

      def self.operators
        @operators ||= Set.new %w(
          between eq gt gte lt lte neq regex typeof within 
          add div mod mult pow sub
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
        rule %r/\^/, Operator
        
        rule %r/#/, Keyword::Reserved
        rule %r/_/, Keyword::Reserved
        
      end
    end
  end
end
