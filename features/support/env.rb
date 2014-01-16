#!/usr/local/bin/ruby
################################################################################
#
#	Nagios Ruby WebDriver plugin.
#
#	By Sergio Boso		www.bosoconsulting.it
#
#	This software is covered by GPL license
#	It is provided AS IS with NO WARRANTY OF ANY KIND, INCLUDING THE
#	WARRANTY OF DESIGN, MERCHANTABILITY, AND FITNESS FOR A PARTICULAR PURPOSE.
#	You can use and modify it but you must keep this message in it.
#
#
#	Wscan  - uses NSCA architecture to Nagios
#			- executes multiple service checks on multiple host in sequence
#			- executes multiple Selenium IDE tables per service.
#
#	parameters:
#		none
################################################################################
# add source location
#
$LOAD_PATH.unshift(File.dirname(__FILE__))
puts
require File.dirname(__FILE__)+'/../../../Crossover/Src/definitions.rb'

require 'rexml/document'
include REXML																	# so that we don't have to prefix everything with REXML::...

require 'optparse'
require 'pp'
require 'headless'
require 'OS'
require 'open3'
require 'timeout'
require 'net/smtp'

require 'watir-webdriver'														#open a browser WD mode
require 'watir-webdriver-performance'

require File.dirname(__FILE__)+'/../../../Crossover/Src/logRoutine.rb'
require File.dirname(__FILE__)+'/../../../Crossover/Src/perfRoutine.rb'
require File.dirname(__FILE__)+'/../../../Crossover/Src/browserCommands.rb'
require File.dirname(__FILE__)+'/../../../Crossover/Src/sendServRes.rb'
require File.dirname(__FILE__)+'/../../../Crossover/Src/confRoutine.rb'
require File.dirname(__FILE__)+'/../../../Crossover/Src/commandExec.rb'
#
################################################################################
LONG	=20.0
SHORT	=3.0
RANGE 	=1.5

def thinkTimeShort
	$brws.XOwaitThinkTime([SHORT, SHORT* RANGE])
end

def thinkTimeLong
#	$brws.WaitTTime([20.0, 30.0])
	$brws.XOwaitThinkTime([LONG, LONG* RANGE])
end

################################################################################
#
# Minitest integration
#
#	module MinitestBridge
#	def self.extended(base)
#		base.extend(MiniTest::Assertions)
#		base.assertions = 0
#	end
#
#	MiniTest::Spec.new(nil)
#	MiniTest::Unit.new()
#	attr_accessor :assertions
#end

# World(MinitestBridge)

################################################################################
#
#		Calc service result
#
################################################################################

def calcServiceRes(locService)

	locServer= $gcfd.brwsrType
	case $gcfd.brwsrType
		when 'fi' then locServer='Firefox'
		when 'ie' then locServer='Explorer'
		when 'ch' then locServer='Chrome'
	end

	iServ=0
	locWarnTO= $gcfd.scfd[iServ].warnTO
	locCritTO= $gcfd.scfd[iServ].critTO
	$pfd.perfClose(locService, $brws.url.to_s)
	$pfd.applResMsg= $pfd.CalcPerfData(iServ, locWarnTO, locCritTO)

	$pfd.append2JtlTotal()
	return sendServRes( locServer, locService, 0, $pfd.applResMsg, $pfd.retState) # process output
end
 
################################################################################
#
#		Beginning of env setup
#
################################################################################

#	World do
#	end

Before do |scenario|

	if(scenario.respond_to? (:scenario_outline))
		tag=scenario.to_hash.map{|k,v| "#{k}=#{v}"}
		$namScen= scenario.scenario_outline.title+' '+tag[0]
	else
		$namScen= scenario.title
	end
	$pfd=PerfData.new($gcfd.logPath+$namScen+'.jtl', false, CUCUMBER, CUCUMBER)	# get results file name from service name

end

After do |scenario|
	# Do something after each scenario.
	# The +scenario+ argument is optional, but
	# if you use it, you can inspect status with
	# the #failed?, #passed? and #exception methods.

	res= calcServiceRes( $iScenario.to_s+' '+$namScen)               			# we reference always to service[0]

#	if(scenario.failed?)
#		puts scenario.title +" failed!"+ ' Ris.'+res.to_s
#	end

	$iScenario +=1
end


###############################################################################

###############################################################################
AfterConfiguration do |config|
	if ENV.length!=0 && ENV['CONF']!=nil
		parms= ENV['CONF'],''
	else
		parms= './Cfg/cucumber.conf',''											# get command line info
	end
	$gcfd= GlobConfData.new														# create browser interface


	$iScenario= 0
	$namScen= ''

	$gcfd.XOstartUp(parms[0], parms[1])											# GLOBAL SETUP

	at_exit do
		$gcfd.XOtearDown()
		puts 'stopped'
	end

	ret=OK

end

