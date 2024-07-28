defmodule SinglePage.Helpers do
  import Earmark.Transform, only: [map_ast: 3, transform: 1]
  
  @moduledoc ~S"""
  These functions are exposed to the EEx templates via the binding `H`
  """

  @doc ~S"""
  This transforms the ast by adding attributes for a given element before rendering

      iex(1)> add_attributes_to("test/fixtures/markdown2.md", "img", class: :small)
      "<p>\n  <img src=\"url1\" alt=\"img1\" class=\"small\">\n</p>\n<ul>\n  <li>\na list\n    <img src=\"url2\" alt=\"img2\" class=\"small\">\n\nh&gt;hjlink3](url3)  </li>\n</ul>\n"

  """
  @spec add_attributes_to(binary(),binary(),Keyword.t()) :: binary()
  def add_attributes_to(path, element, atts) do
    path
    |> get_ast!() 
    |> map_ast(attribute_adder(element, atts), true)
    |> transform()
  end

  @doc ~S"""

  can be used with one class
      iex(2)> add_class_to("test/fixtures/markdown2.md", "img", :image)
      "<p>\n  <img src=\"url1\" alt=\"img1\" class=\"image\">\n</p>\n<ul>\n  <li>\na list\n    <img src=\"url2\" alt=\"img2\" class=\"image\">\n\nh&gt;hjlink3](url3)  </li>\n</ul>\n"


  or a list of classes
      iex(2)> add_class_to("test/fixtures/markdown2.md", "img", [:small, :thumb])
      "<p>\n  <img src=\"url1\" alt=\"img1\" class=\"small thumb\">\n</p>\n<ul>\n  <li>\na list\n    <img src=\"url2\" alt=\"img2\" class=\"small thumb\">\n\nh&gt;hjlink3](url3)  </li>\n</ul>\n"

  """
  def add_class_to(path, element, class)
  def add_class_to(path, element, classes) when is_list(classes) do
    add_attributes_to(path, element, class: Enum.join(classes, " "))
  end
  def add_class_to(path, element, class) do
    add_attributes_to(path, element, class: class)
  end

  @spec include(binary())::binary()
  def include(path) do
    SinglePage.eval_file(path)
  end

  @spec md_from_file(binary())::binary()
  def md_from_file(path) do
    path 
    |> File.read! 
    |> Earmark.as_html!
  end

  @doc false
  def get_ast!(path) do
    path  
    |> File.read! 
    |> Earmark.as_ast! 
  end

  @spec attribute_adder(Earmark.ast_node(), Keyword.t()) :: Earmark.ast_node()
  defp attribute_adder(element, atts) do
    fn {tag, atts1, children, meta} = node ->
      if tag == element do
        {tag, atts1 ++ stringyfied(atts), children, meta}
      else
        node
      end
    end
  end

  defp stringyfied(atts) do
    atts 
    |> Enum.map(fn {a, b} -> {to_string(a), to_string(b)} end)
  end
end
# SPDX-License-Identifier: AGPL-3.0-or-later
