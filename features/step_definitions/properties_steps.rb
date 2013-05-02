When(/^I search for a property called "([^"]*)"$/) do |property_name|
  fill_in 'property[name]', :with => property_name
end
When(/^I press the search button$/) do
  click_button 'Search'
end
When(/^property "([^"]*)" has been rented out$/) do |name|
  Property.where("name=?",name).first.update_attribute :rented_at, Time.now
end
Then(/^I should not see property "([^"]*)"$/) do |name|
  first(:css,".property .name:contains(\"#{name}\")").should be_nil
end
When(/^I should see property "([^"]*)"$/) do |name|
  first(:css,".property .name:contains(\"#{name}\")").should_not be_nil
end
Then(/^the alternatives should list the following properties only and in this order:$/) do |table|
  # table is a | Flat with stunning view   | 2               | 1 km          |
  nodes=all(:css,'.alternative_properties .property')
  data_from_page=nodes.map {|node| {'name'=>node.first(:css,'.name').text, 'bedroom_count' => node.first(:css,'.bedroom_count').text, 'distance' => node.first(:css,'.distance').text}}
  table.diff!(data_from_page)
end
Then(/^the alternatives list should be empty$/) do
  all(:css,'.alternative_properties .property').count.should eql 0
  first(:css,'.alternative_properties').text.should match "Sorry, no alternatives can be found for this property."
end