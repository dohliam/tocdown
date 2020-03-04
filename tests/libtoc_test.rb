require 'minitest/autorun'
require_relative '../libtoc.rb'

class LibTocTest < MiniTest::Unit::TestCase

    def test_basic
        options = {}
        options[:bullets] = true

        toc = md_to_toc( File.read(__dir__ + '/test.md'), options )

        assert toc.include?("* Top-level topic (Heading 2)")
        assert toc.include?("* First sub-sub-sub-sub-topic (Heading 6)")
    end

    def test_skip_heading
        options = {}
        options[:bullets] = true
        options[:scanmarker] = true

        toc = md_to_toc( File.read(__dir__ + '/test.md'), options )

        refute toc.include?("* Top-level topic (Heading 2)")
        assert toc.include?("* First sub-sub-sub-sub-topic (Heading 6)")
    end

    def test_ignore_code
        options = {}

        toc = md_to_toc( File.read(__dir__ + '/test.md'), options )

        refute toc.include?("Top-level topic that should not be counted")
        assert toc.include?("Top-level topic")
    end
end
