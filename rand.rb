require 'readline'

# process_input is modified from process_argv https://www.rubyguides.com/2018/12/ruby-argv/
def process_input(cmd_args)
    options = {}
    normal_args = []
    cmd_args.each do |arg|
       case arg
            when "-q"
                options[:quiet] = true
            when "-r"
                options[:range] = true
            #TODO Add option do show a inline help
            #Read from file
            when "-f"
            	options[:file] = true
            #Read from pipe
            when "-p"
            	options[:pipe] = true
            else
                normal_args.push(arg)
       end
    end
    
    return { :options => options, :normal_args => normal_args }
end

processed_input = process_input(ARGV)

options = processed_input[:options]
normal_args = processed_input[:normal_args]

if options[:range]
   range_begin = normal_args[0]
   range_end   = normal_args[1]
   normal_args = Range.new(range_begin, range_end).to_a
end

if options[:file]
	filename = normal_args[0]
	lines = IO.readlines(filename)
	lines_count = lines.size
	puts "Length " + lines_count.to_s
	normal_args = Range.new(1, lines_count).to_a
	if lines_count > 1_000_000
		#Will eat to much memory
		puts "File too long. Exiting ..."
		exit
	end
end

if options[:pipe]
	lines = []
	lines_count = 0
	#Made with a little help from this link
	#https://zetcode.com/lang/rubytutorial/io/	
	while line = $stdin.gets
		lines.push(line)
		lines_count+=1
	end
	normal_args = Range.new(1, lines_count).to_a
end

#Choose a rand item
chosen = normal_args[rand(normal_args.size)]

if options[:file] or options[:pipe]
	# https://stackoverflow.com/questions/4014352/how-to-get-a-particular-line-from-a-file	
	chosen = lines[chosen]
end

if options[:quiet]
    puts chosen
else
    puts "E o escolhido foi: " + chosen    
end


