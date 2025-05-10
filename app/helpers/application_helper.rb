module ApplicationHelper
  def show_meta_tags
    assign_meta_tags if display_meta_tags.blank?
    display_meta_tags
  end

  def assign_meta_tags(options = {})
    defaults = {
    site: "Kutemy",
    title: "お子様の好き嫌いを克服するためのアプリ",
    description: "苦手な食材でも食べやすいレシピを探してみませんか？",
    image: image_url('OGP_default.png')
    }
    options.reverse_merge!(defaults)
    site = options[:site]
    title = options[:title]
    description = options[:description]
    image = options[:image]
    configs = {
      reverse: true,
      site:,
      title:,
      description:,
      image:,
      canonical: "https://www.kutemy.com/",
      og: {
        type: 'website',
        title: title.presence || site,
        description:,
        url: "https://www.kutemy.com/",
        image:,
        site_name: site
      },
      twitter: {
        site:,
        card: 'summary_large_image',
        image:
      }
    }
    set_meta_tags(configs)
  end
end
