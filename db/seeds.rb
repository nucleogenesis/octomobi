# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Feature.create([
	{title: "Contact", image: "logo.png", is_active: true, 
	css_id: "contact_feature"},
	{title: "Content Page", image: "logo.png", is_active: true, 
	css_id: "content_page_feature"},
	{title: "External Links", image: "logo.png", is_active: true, 
	css_id: "external_links_feature"},
	{title: "Introduction", image: "logo.png", is_active: true, 
	css_id: "introduction_feature"},
	{title: "RSS Feed", image: "logo.png", is_active: true, 
	css_id: "rss_feed_feature"},
	{title: "Social Links", image: "logo.png", is_active: true, 
	css_id: "social_links_feature"}])

