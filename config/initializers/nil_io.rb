module Paperclip
  class Attachment
    def assign_with_empty_string_handling uploaded_file
      assign_without_empty_string_handling(uploaded_file) unless uploaded_file == ''
    end
    alias_method_chain :assign, :empty_string_handling
  end
end