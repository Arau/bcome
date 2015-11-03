class ::Bcome::RenderIrb

  def list_items(parent_collection, items)
    if !items || !items.any?
      print "\nNo resources collections found. Maybe you forgot to add any?".headsup
    else
     print  "\n #{parent_collection}\n\n".colorize(:green) # are available:\n\n".colorize(:green)
     items.each do |item|
        colour = item.highlight? ? :yellow : :green
        print "* #{item.do_describe}\n".colorize(colour)
      end
    end
    print "\n"
  end

  def menu(menu_items)
    menu_str = "\n** Commands **\n\n"
    menu_str = "\n\The following commands are available: \n\n"
    menu_items.each do |item|
      command = item[:command]
      description = item[:description]
      usage = item[:usage]

      menu_str += "> #{command}\n"
      menu_str += "- #{description}\n"
      menu_str += "e.g. #{usage}\n" if usage

      menu_str += "\n"
    end
    menu_str += "\n\n"
    print menu_str.menu
  end

end
