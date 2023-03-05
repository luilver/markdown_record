module MarkdownRecord
  module ContentDsl
    module DescribeModel
      REGEX = /(?<!`|`\n|`html\n)<!--\s*describe_model\s*({[\s|"|'|\\|\w|:|,|.|\[|\]|\{|\}]*})\s*-->(?!`|\n`)/
      ENCODED_REGEX = /(?<!<code>|<code class="html">)&lt;!--\s*describe_model\s*({[\s|"|'|\\|\w|:|,|.|\[|\]|\{|\}|;|&]*})\s*--&gt;(?!<\/code>)/

      def describe_model_dsl(text)
        match = text.match(REGEX)

        if match
          JSON.parse(match[1])
        else
          nil
        end
      end

      def self.remove_dsl(text)
        text.gsub(ENCODED_REGEX, "")
      end
    end
  end
end