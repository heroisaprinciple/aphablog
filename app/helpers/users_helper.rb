module UsersHelper

  def gravatar_for(user, options = {size: 80})
    email_address = "valcat552@gmail.com"
    hash = Digest::MD5.hexdigest(email_address).downcase
    size = options[:size]
    image_src = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"

    # we'll puts it in the img tag (the built-in method in RoR)
    image_tag(image_src, class: "rounded shadow mx-auto d-block", alt: user.username)
  end
end
