require 'colorize'

module colorize
	def colorize(text, color_code)
		"#{color_code}#{text}\e[0m"
	end

	def red(text)
		colorize(text, 31)
	end
	
	def blue(text)
		colorize(text, 34)
	end

	def green(text)
		colorize(text, 32)
	end

	def yellow(text)
		colorize(text, 33)
	end

	def purple(text)
		colorize(text, 35)
	end
end
