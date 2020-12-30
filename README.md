# Ruby Linter

This is a Ruby linter created using Ruby programming language. The aim of this linter is to make sure Ruby code is written well and improves the code.

# About
The custom Ruby linter currently checks/detects for the following errors/warnings.
- check for missing/unexpected tags i.e. '( )', '[ ]', and '{ }'
- check missing/unexpected end
- check for trailing spaces
- check empty line error

> Below are demonstrations of good and bad code for the above cases. I will use the pipe '|' symbol to indicate cursor position where necessary.
## Missing/Unexpected Tag
~~~ruby
# Good Code

class ErrorCheck
  def initialize(file_path)
    @checker = FileReader.new(file_path)
    @errors = []
    @keywords = %w[class def begin do if module unless case]
  end
end

# Bad Code

class ErrorCheck
  def initialize file_path)
    @checker = FileReader.new((file_path)
    @errors = []
    @keywords = %w[class def begin do if module unless case]
  end
end
~~~

## Missing/unexpected end
~~~ruby
# Good Code

class ErrorCheck
  def initialize(file_path)
    @checker = FileReader.new(file_path)
    @errors = []
    @keywords = %w[class def begin do if module unless case]
  end
end

# Bad Code

class ErrorCheck
  def initialize(file_path)
    @checker = FileReader.new(file_path)
    @errors = []
    @keywords = %w[class def begin do if module unless case]

end
~~~

## Trailing spaces
> note where the cursor(|) is on the bad code 
~~~ruby
# Good Code

class ErrorCheck
  def initialize(file_path)
    @checker = FileReader.new(file_path)
    @errors = []
    @keywords = %w[class def begin do if module unless case]
  end
end

# Bad Code

class ErrorCheck
  def initialize(file_path)
    @checker = FileReader.new(file_path)   |
    @errors = []
    @keywords = %w[class def begin do if module unless case]
  end
end
~~~

## Empty line error
~~~ruby
# Good Code

class ErrorCheck
  def initialize(file_path)
    @checker = FileReader.new(file_path)
    @errors = []
    @keywords = %w[class def begin do if module unless case]
  end
end

# Bad Code

class ErrorCheck
  def initialize(file_path)



    @checker = FileReader.new(file_path)
    @errors = []
    @keywords = %w[class def begin do if module unless case]
  end
end
~~~

## Built With
- Ruby

# Getting Started

To get a local copy of the repository please run the following commands on your terminal:

```
$ cd <folder>
```

```
$ git clone https://github.com/HillaryOkello/ruby-linter.git
```

**To check for errors on a file:** 

~~~bash
$ bin/main test.rb
~~~
# Author

👤 **Hillary Okello**

- Github: [@HillaryOkello](https://github.com/HillaryOkello/)
- Twitter: [@kellyhillary4](https://twitter.com/Kellyhillary4)
- Linkedin: [HillaryOkello](https://www.linkedin.com/in/hillary-okello-b173101a4/)


## 🤝 Contributing

Contributions, issues and feature requests are welcome!

## Show your support

Give a ⭐️ if you like this project!
