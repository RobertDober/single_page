defmodule SinglePage do
  alias __MODULE__.Helpers
  @moduledoc """
  Interpret an eex template with html and markdown specific helpers
  """

  @doc ~S"""

  `eval_file` is calling `EEx.eval_file` 

  iex(1)> eval_file("test/fixtures/empty_file")
  ""

    but with helpers in the binding, we can also convert markdown

  iex(2)> eval_file("test/fixtures/with_markdown.eex")
  "<h1>\nHello</h1>\n\n"

    the example above is converting a string, normally you would like to convert files

  iex(3)> eval_file("test/fixtures/import_markdown.eex")
  "<p>\n<em>hello</em></p>\n\n"

    But we can also include files, and that recursively

  iex(4)> eval_file("test/fixtures/book.eex")
  "\n  Chapter 1\n\n\n  Chapter 2\n<p>\n<em>hello</em></p>\n\n\n\n"


  For more details see the doc of `SinglePage.Helpers`
  """

  @spec bindings() :: Keyword.t()
  def bindings do
    [
      earmark: Earmark,
      h: Helpers,
    ]
  end

  @spec eval_file(binary())::binary()
  def eval_file(path) do
    EEx.eval_file(path, bindings())
  end
end
