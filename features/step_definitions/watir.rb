#	def click(selector, tvalue)
#	def goto (url)
#	def selectList(selector, tvalue, values)
#	def typeText(tag, tvalue, text)
#	def dragAndDrop(tag, tvalue, from, to)
#	def lookFor(type, tvalue, wait)
#	def radioSet(tag, tvalue)
#	def typeText(selector, tvalue, text)
#	def takeScreenShot(path)													# take screenshot
#	def url()
#	def close
########################################################################################################################

	Given (/^I am on watir-example$/) do
		$brws.XOgoto('http://bit.ly/watir-example')
		$brws.XOlookFor(:title, 'Watir Example', true)
	end

	Then(/^I write "(.*?)" to text field$/) do |text|
		$brws.XOtypeText(:id, 'entry_0', text)
	end

	Then(/^I write "(.*?)" to textbox$/) do |text|
		$brws.XOtypeText(:id, 'entry_1', text)
	end

	Then(/^I select "(.*?)" as testing tool$/) do |sel|
		$brws.XOclick(:value, sel)
	end

	Then(/^I like "(.*?)" as language$/) do |sel|
		$brws.XOclick(:value, sel)
	end

	Then(/^I use "(.*?)" as browser$/) do |sel|
		$brws.XOselectList(:id, 'entry_6', sel)
	end

	Then(/^I'm happy at (\d+)$/) do |val|
		$brws.XOclick(:id, 'group_8_'+val.to_s)
	end

	Then(/^OS is at (\d+) for "(.*?)"$/) do |val, item|
		group='group_1'+ item[-1]+'_'+val.to_s
		$brws.XOclick(:id, group)
	end

	And(/^I press "(.*?)"$/) do |sel|
		$brws.XOclick(:value, sel)
	end

