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

	Given (/^I am on Bosoconsulting.it$/) do
		$brws.XOgoto('www.bosoconsulting.it')
		$brws.XOlookFor(:title, 'Consulenze Infrastruttura Informatica Ing. Boso', true)
	end

