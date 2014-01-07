module Nationbuilder::Model

  class PageBase < Base

    STATUSES = %w(drafted published)

    attribute :id, Integer

    attribute :slug, String,
      accessibility: :optional,
      sample: "happy_labor_day",
      description: "Page SEO friendly portion of URL"

    attribute :path, String,
      accessibility: :optional,
      sample: "/billsmith/happy_labor_day",
      description: "URL path that locates the page on the website"

    attribute :status, String,
      accessibility: :required,
      sample: "published",
      description: "drafted or published"

    attribute :site_slug, String,
      accessibility: :readonly,
      sample: "foobar",
      description: "The slug of the website the page is contained on"

    attribute :name, String,
      accessibility: :required,
      sample: "Happy Labor Day!",
      description: "A name for the page"

    attribute :headline, String,
      accessibility: :optional,
      sample: "Celebrate the Labor movement with us",
      description: "the headline of the page"

    attribute :title, String,
      accessibility: :optional,
      sample: "Happy Labor Day",
      description: "A title for the page"

    attribute :excerpt, String,
      accessibility: :optional,
      description: "Excerpt of the content of the page to show on search engine results"

    attribute :author_id, Integer,
      accessibility: :optional,
      sample: 12345,
      description: "The author's id in the nation"

    attribute :published_at, DateTime,
      accessibility: :optional,
      sample: "2013-09-23T01:39:19-07:00",
      description: "When the page was published"

    attribute :external_id, String,
      accessibility: :optional,
      sample: "14812",
      description: "id of the page from another tool"

    attribute :tags, Array[String],
      accessibility: :optional,
      sample: ["funny", "true"],
      description: "list of tags"

    validates_presence_of :site_slug, :name, :status
    validates_inclusion_of :status, in: STATUSES

  end

end
