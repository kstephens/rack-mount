require 'test_helper'

class ConditionTest < Test::Unit::TestCase
  Condition = Rack::Mount::Condition

  def test_condition_with_string_pattern
    condition = Condition.new(:request_method, 'GET')
    assert_equal %r{\AGET\Z}, condition.to_regexp
    assert_equal({ :request_method => 'GET' }, condition.keys)
  end

  def test_condition_with_string_pattern_should_escape_pattern
    condition = Condition.new(:host, '37s.backpackit.com')
    assert_equal %r{\A37s\.backpackit\.com\Z}, condition.to_regexp
    assert_equal({ :host => '37s.backpackit.com' }, condition.keys)
  end

  def test_condition_with_regexp_pattern
    condition = Condition.new(:request_method, /^GET|POST$/)
    assert_equal %r{^GET|POST$}, condition.to_regexp
    assert_equal({ :request_method => /^GET|POST$/ }, condition.keys)
  end

  def test_condition_with_simple_pattern
    condition = Condition.new(:request_method, /^GET$/)
    assert_equal %r{^GET$}, condition.to_regexp
    assert_equal({ :request_method => 'GET' }, condition.keys)
  end

  def test_condition_with_complex_pattern
    condition = Condition.new(:request_method, /^.*$/)
    assert_equal %r{^.*$}, condition.to_regexp
    assert_equal({ :request_method => /^.*$/ }, condition.keys)
  end
end

class SplitConditionTest < Test::Unit::TestCase
  SplitCondition = Rack::Mount::SplitCondition
  EOS = Rack::Mount::Const::NULL

  def test_condition_with_path_with_slash
    condition = SplitCondition.new(:path_info, '/foo/bar', %w( / ))
    assert_equal %r{\A/foo/bar\Z}, condition.to_regexp
    assert_equal({
      [:path_info, 0, %r{/}] => 'foo',
      [:path_info, 1, %r{/}] => 'bar',
      [:path_info, 2, %r{/}] => EOS
     }, condition.keys)
    assert_equal ['foo', 'bar', EOS],
      condition.split('/foo/bar')
  end

  def test_condition_with_path_with_slash_and_dot
    condition = SplitCondition.new(:path_info, '/foo/bar', %w( / . ))
    assert_equal %r{\A/foo/bar\Z}, condition.to_regexp
    assert_equal({
      [:path_info, 0, %r{/|\.}] => 'foo',
      [:path_info, 1, %r{/|\.}] => 'bar',
      [:path_info, 2, %r{/|\.}] => EOS
     }, condition.keys)
    assert_equal ['foo', 'bar', EOS],
      condition.split('/foo/bar')
  end

  def test_condition_with_host
    condition = SplitCondition.new(:host, '37s.backpackit.com', %w( . ))
    assert_equal %r{\A37s\.backpackit\.com\Z}, condition.to_regexp
    assert_equal({
      [:host, 0, %r{\.}] => '37s',
      [:host, 1, %r{\.}] => 'backpackit',
      [:host, 2, %r{\.}] => 'com',
      [:host, 3, %r{\.}] => EOS
    }, condition.keys)
    assert_equal ['37s', 'backpackit', 'com', EOS],
      condition.split('37s.backpackit.com')
  end

  def test_condition_with_path_with_capture
    if Rack::Mount::Const::SUPPORTS_NAMED_CAPTURES
      condition = SplitCondition.new(:path_info, eval('%r{^/foo/(?<id>[0-9]+)$}'), %w( / ))
      assert_equal eval('%r{^/foo/(?<id>[0-9]+)$}'), condition.to_regexp
    else
      condition = SplitCondition.new(:path_info, %r{^/foo/(?:<id>[0-9]+)$}, %w( / ))
      assert_equal %r{^/foo/([0-9]+)$}, condition.to_regexp
    end

    assert_equal({
      [:path_info, 0, %r{/}] => 'foo',
      [:path_info, 1, %r{/}] => /\A[0-9]+\Z/,
      [:path_info, 2, %r{/}] => EOS
     }, condition.keys)
    assert_equal ['foo', '123', EOS],
      condition.split('/foo/123')
  end

  def test_condition_with_path_with_optional_capture
    if Rack::Mount::Const::SUPPORTS_NAMED_CAPTURES
      condition = SplitCondition.new(:path_info, eval('%r{^/foo/bar(\.(?<format>[a-z]+))?$}'), %w( / ))
      assert_equal eval('%r{^/foo/bar(\.(?<format>[a-z]+))?$}'), condition.to_regexp
    else
      condition = SplitCondition.new(:path_info, %r{^/foo/bar(\.(?:<format>[a-z]+))?$}, %w( / ))
      assert_equal %r{^/foo/bar(\.([a-z]+))?$}, condition.to_regexp
    end

    assert_equal({
      [:path_info, 0, %r{/}] => 'foo'
     }, condition.keys)
    assert_equal ['foo', 'bar.xml', EOS],
      condition.split('/foo/bar.xml')
  end

  def test_condition_with_path_with_seperators_inside_optional_captures
    if Rack::Mount::Const::SUPPORTS_NAMED_CAPTURES
      condition = SplitCondition.new(:path_info, eval('%r{^/foo(/(?<action>[a-z]+))?$}'), %w( / ))
      assert_equal eval('%r{^/foo(/(?<action>[a-z]+))?$}'), condition.to_regexp
    else
      condition = SplitCondition.new(:path_info, %r{^/foo(/(?:<action>[a-z]+))?$}, %w( / ))
      assert_equal %r{^/foo(/([a-z]+))?$}, condition.to_regexp
    end

    assert_equal({
      [:path_info, 0, %r{/}] => 'foo'
     }, condition.keys)
    assert_equal ['foo', EOS],
      condition.split('/foo')
    assert_equal ['foo', 'bar', EOS],
      condition.split('/foo/bar')
  end

  def test_condition_with_path_with_optional_capture_with_slash_and_dot
    if Rack::Mount::Const::SUPPORTS_NAMED_CAPTURES
      condition = SplitCondition.new(:path_info, eval('%r{^/foo(\.(?<format>[a-z]+))?$}'), %w( / . ))
      assert_equal eval('%r{^/foo(\.(?<format>[a-z]+))?$}'), condition.to_regexp
    else
      condition = SplitCondition.new(:path_info, %r{^/foo(\.(?:<format>[a-z]+))?$}, %w( / . ))
      assert_equal %r{^/foo(\.([a-z]+))?$}, condition.to_regexp
    end

    assert_equal({
      [:path_info, 0, %r{/|\.}] => 'foo'
     }, condition.keys)
   assert_equal ['foo', EOS],
     condition.split('/foo')
    assert_equal ['foo', 'xml', EOS],
      condition.split('/foo.xml')
  end
end
