require 'colorize'
require 'strscan'
require_relative '../lib/file_reader'

class ErrorCheck
  attr_reader :checker, :errors

  def initialize(file_path)
    @checker = FileReader.new(file_path)
    @errors = []
    @keywords = %w[class def begin do if module unless case]
  end

  def check_tag_error(*args)
    @checker.file_lines.each_with_index do |value, index|
      open_p = []
      close_p = []
      open_p << value.scan(args[0])
      close_p << value.scan(args[1])

      status = open_p.flatten.size <=> close_p.flatten.size

      log_error("line:#{index + 1} Lint/Syntax: Unexpected/Missing token '#{args[2]}' #{args[4]}") if status.eql?(1)
      log_error("line:#{index + 1} Lint/Syntax: Unexpected/Missing token '#{args[3]}' #{args[4]}") if status.eql?(-1)
    end
  end

  def tag_error
    check_tag_error(/\(/, /\)/, '(', ')', 'Parenthesis')
    check_tag_error(/\[/, /\]/, '[', ']', 'Square Bracket')
    check_tag_error(/\{/, /\}/, '{', '}', 'Curly Bracket')
  end

  def end_error
    keyword_count = 0
    end_count = 0
    @checker.file_lines.each_with_index do |value, _index|
      keyword_count += 1 if @keywords.include?(value.split(' ').first) || value.split(' ').include?('do')
      end_count += 1 if value.strip == 'end'
    end

    status = keyword_count <=> end_count
    log_error("Lint/Syntax: Missing 'end'") if status.eql?(1)
    log_error("Lint/Syntax: Unexpected 'end'") if status.eql?(-1)
  end

  def log_error(error_msg)
    @errors << error_msg
  end

  def trailing_spaces
    @checker.file_lines.each_with_index do |val, index|
      if val[-2] == ' ' && !val.strip.empty?
        @errors << "line:#{index + 1}:#{val.size - 1}: Error: Trailing whitespace detected."
        + " '#{val.gsub(/\s*$/, '_')}'"
      end
    end
  end

  def empty_line_error
    @checker.file_lines.each_with_index do |val, indx|
      check_class_empty_line(val, indx)
      check_method_empty_line(val, indx)
      check_end_empty_line(val, indx)
      check_do_empty_line(val, indx)
    end
  end

  def check_class_empty_line(val, indx)
    msg = 'Extra empty line detected in the class body'
    return unless val.strip.split(' ').first.eql?('class')

    log_error("line:#{indx + 2} #{msg}") if @checker.file_lines[indx + 1].strip.empty?
  end

  def check_method_empty_line(val, indx)
    message1 = 'Extra empty line detected at the beginning of method'
    message2 = 'Empty lines between method definition'

    return unless val.strip.split(' ').first.eql?('def')

    log_error("line:#{indx + 2} #{message1}") if @checker.file_lines[indx + 1].strip.empty?
    log_error("line:#{indx + 1} #{message2}") if @checker.file_lines[indx - 1].strip.split(' ').first.eql?('end')
  end

  def check_end_empty_line(val, indx)
    return unless val.strip.split(' ').first.eql?('end')

    log_error("line:#{indx} Extra empty line detected at block body end") if @checker.file_lines[indx - 1].strip.empty?
  end

  def check_do_empty_line(val, indx)
    msg = 'Extra empty line detected at block body beginning'
    return unless val.strip.split(' ').include?('do')

    log_error("line:#{indx + 2} #{msg}") if @checker.file_lines[indx + 1].strip.empty?
  end
end
