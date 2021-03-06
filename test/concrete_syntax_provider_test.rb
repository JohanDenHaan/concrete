$:.unshift(File.dirname(__FILE__)+"/../lib")

require 'test/unit'
require 'fileutils'
require 'concrete/concrete_syntax_provider'
begin 
  require 'haml'
rescue LoadError
end

class ConcreteSyntaxProviderTest < Test::Unit::TestCase

  TestDir = File.dirname(__FILE__)+"/concrete_syntax_provider_test"

  class LoggerMock
    attr_reader :messages
    def initialize; @messages = []; end
    def info(msg)
      @messages << "INFO: #{msg}"
    end
    def warn(msg)
      @messages << "WARN: #{msg}"
    end
    def error(msg)
      @messages << "ERROR: #{msg}"
    end
  end

  class ConfigMock
    attr_reader :values
    def initialize; @values = {}; end
    def loadValue(ident)
      @values[ident] 
    end
    def storeValue(ident, value)
      @values[ident] = value
    end
  end

  def test_syntaxes_no_dirs
    logger = LoggerMock.new
    sp = Concrete::ConcreteSyntaxProvider.new([], logger)
    assert_equal [], sp.syntaxes
    assert_equal '{ "syntaxes": [], "selected": "" }', sp.syntaxesAsJson
    assert_equal [], logger.messages
  end

  def test_syntaxes_non_existing_dir
    logger = LoggerMock.new
    sp = Concrete::ConcreteSyntaxProvider.new([TestDir+"/doesNotExist"], logger)
    assert_equal [], sp.syntaxes
    assert_equal '{ "syntaxes": [], "selected": "" }', sp.syntaxesAsJson
    assert_equal [], logger.messages
  end

  def test_syntaxes_no_syntaxes
    logger = LoggerMock.new
    raise "bad preconditions" unless File.exist?(TestDir+"/syntaxDir0")
    sp = Concrete::ConcreteSyntaxProvider.new([TestDir+"/syntaxDir0"], logger)
    assert_equal [], sp.syntaxes
    assert_equal '{ "syntaxes": [], "selected": "" }', sp.syntaxesAsJson
    assert_equal [], logger.messages
  end

  def test_syntaxes_empty_syntax
    logger = LoggerMock.new
    sp = Concrete::ConcreteSyntaxProvider.new([TestDir+"/syntaxDir1"], logger)
    assert_equal 1, sp.syntaxes.size
    assert_equal "Empty Syntax", sp.syntaxes.first.name
    assert_equal [], logger.messages
    assert_equal '{ "syntaxes": [' + 
      '{ "ident": "'+TestDir+'/syntaxDir1/empty_syntax", "name": "Empty Syntax" }' + 
      '], "selected": "" }', sp.syntaxesAsJson
  end

  def test_syntaxes_common
    logger = LoggerMock.new
    sp = Concrete::ConcreteSyntaxProvider.new([TestDir+"/syntaxDir2"], logger)
    syntaxes = sp.syntaxes
    assert_equal 1, syntaxes.size
    assert_equal "First Syntax", syntaxes.first.name
    assert_equal TestDir+"/syntaxDir2/first_syntax", syntaxes.first.ident
    assert_equal '{ "syntaxes": [' + 
      '{ "ident": "'+TestDir+'/syntaxDir2/first_syntax", "name": "First Syntax" }' + 
      '], "selected": "" }', sp.syntaxesAsJson
    assert_equal [], logger.messages
  end

  def test_selectSyntax_no_syntax
    logger = LoggerMock.new
    sp = Concrete::ConcreteSyntaxProvider.new([], logger)
    assert_nothing_raised do
      sp.selectSyntax("dummy")
    end
    assert_nil sp.selectedSyntax
  end

  def test_selectSyntax_no_config
    logger = LoggerMock.new
    sp = Concrete::ConcreteSyntaxProvider.new([TestDir+"/syntaxDir2", TestDir+"/syntaxDir3"], logger)
    assert_nothing_raised do
      sp.selectSyntax("dummy")
    end
    assert_equal "First Syntax", sp.selectedSyntax.name
    sp.selectSyntax(TestDir+"/syntaxDir3/haml_syntax")
    assert_equal "Haml Syntax", sp.selectedSyntax.name
  end

  def test_selectSyntax_load_config
    logger = LoggerMock.new
    config = ConfigMock.new
    config.values["concrete_syntax"] = TestDir+"/syntaxDir3/haml_syntax" 
    sp = Concrete::ConcreteSyntaxProvider.new([TestDir+"/syntaxDir2", TestDir+"/syntaxDir3"], logger, config)
    assert_equal "Haml Syntax", sp.selectedSyntax.name
  end

  def test_selectSyntax_store_config
    logger = LoggerMock.new
    config = ConfigMock.new
    sp = Concrete::ConcreteSyntaxProvider.new([TestDir+"/syntaxDir2", TestDir+"/syntaxDir3"], logger, config)
    sp.selectSyntax("dummy")
    assert_equal({}, config.values)
    sp.selectSyntax(TestDir+"/syntaxDir3/haml_syntax" )
    assert_equal({"concrete_syntax" => TestDir+"/syntaxDir3/haml_syntax" }, config.values)
  end

end
