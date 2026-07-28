module ApplicationHelper
  GITHUB_URL = "https://github.com/HenryGlo/algoviz".freeze

  def github_url(path = "")
    path.present? ? "#{GITHUB_URL}/#{path}" : GITHUB_URL
  end

  # Prosa de la entrada (Markdown -> HTML) con commonmarker.
  def markdown(text)
    return "" if text.blank?

    Commonmarker.to_html(
      text,
      options: {
        render: { unsafe: false, hardbreaks: false },
        extension: { table: true, strikethrough: true, autolink: true }
      }
    ).html_safe
  end

  # Resaltado server-side de código con Rouge (Python y Ruby en las tabs).
  def highlight_code(code, language)
    lexer = Rouge::Lexer.find(language.to_s) || Rouge::Lexers::PlainText.new
    formatter = Rouge::Formatters::HTML.new
    inner = formatter.format(lexer.lex(code.to_s))
    tag.div(class: "highlight") { tag.pre { tag.code(inner.html_safe, class: "language-#{language}") } }
  end

  def level_badge(level)
    tag.span(level.to_s.capitalize, class: "badge badge--#{level}")
  end
end
