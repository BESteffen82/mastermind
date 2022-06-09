require 'colorize'

module Colorize
	def colorize(text, color_code)
		"#{color_code}#{text}\e[0m"
	end

	def red(text)
		colorize(text, "\e[31m")
	end
	
	def blue(text)
		colorize(text, "\e[34m")
	end

	def green(text)
		colorize(text, "\e[32m")
	end

	def yellow(text)
		colorize(text, "\e[33m")
	end

	def purple(text)
		colorize(text, "\e[35m")
	end
end

