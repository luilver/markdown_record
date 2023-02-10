module MarkdownCms
  class Configuration
    include Singleton

    attr_accessor :content_root
    attr_accessor :rendered_content_root
    attr_accessor :html_layout_directory
    attr_accessor :html_layout_path
    attr_accessor :pdf_layout_path
    attr_accessor :markdown_extensions
    attr_accessor :indexer_class
    attr_accessor :html_render_options
    attr_accessor :public_layout
    attr_accessor :html_renderer_class
    attr_accessor :render_strategy
    attr_accessor :pdf_routes
    attr_accessor :html_routes
    attr_accessor :json_routes
    attr_accessor :content_routes

    RENDER_STRATEGIES = [:full, :directory, :file]

    def initialize
      @content_root = Rails.root.join("markdown_cms","content")
      @rendered_content_root = Rails.root.join("markdown_cms","rendered")
      @indexer_class = ::MarkdownCms::Indexer
      @html_renderer_class = ::Redcarpet::Render::HTML
      @html_render_options = {}
      @html_layout_directory = Rails.root.join("markdown_cms","layouts")
      @html_layout_path = "_markdown_cms_layout.html.erb"
      @pdf_layout_path = @html_layout_path
      @markdown_extensions = {}
      @public_layout = "layouts/application"
      @render_strategy = :full
      @pdf_routes = [:show, :download]
      @html_routes = [:show]
      @json_routes = [:show, :download]
      @content_routes = [:show, :download]
    end

    def render_strategy_options(strategy = nil)
      strat = strategy || @render_strategy

      unless RENDER_STRATEGIES.include?(strat)
        raise ::ArgumentError.new("Invalide render strategy.")
      end

      case strategy || @render_strategy
      when :full
        {:concat => true, :deep => true}
      when :directory
        {:concat => true, :deep => false}
      when :file
        {:concat => false, :deep => true}
      end
    end

    def routing
      { :pdf => pdf_routes, :html => html_routes, :json => json_routes, :content => content_routes}
    end
  end
end