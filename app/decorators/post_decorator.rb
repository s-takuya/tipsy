module PostDecorator
  def body_with_tag_link
    body.gsub(/(#([^\s]+))/, '<a href="/tags/\\2">\\1</a>').html_safe
  end
end
