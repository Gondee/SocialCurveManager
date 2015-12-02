module UsersHelper
    # Returns the Gravatar for the given user.
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: "Gravatar Icon", class: "gravatar")
  end
  def gravatar_url(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    "https://secure.gravatar.com/avatar/#{gravatar_id}"
  end
  def nav_button_gen(page,icon,text)
    if current_page?(page)
      raw "<li class='active'><a href='#{page}'><i class='icon-#{icon}'></i> <span>#{text}</span></a></li>"
    else
      raw "<li><a href='#{page}'><i class='icon-#{icon}'></i> <span>#{text}</span></a></li>"
    end
  end
end
