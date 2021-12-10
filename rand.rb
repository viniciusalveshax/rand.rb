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

#p normal_args

chosen = normal_args[rand(normal_args.size)]

if options[:quiet]
    puts chosen
else
    puts "E o escolhido foi: " + chosen    
end


