defmodule SinglePage.Cli do
  alias ExAequo.Color

  import SinglePage.Color 

  @moduledoc ~S"""
  
  """

  def main(args)

  def main([]) do
    Color.putc([:yellow, "usage:"], :stderr)
    Color.putc(usage(), :stderr)
  end

  def main(~W[-v]), do: version()
  def main(~W[--version]), do: version()
  def main(~W[-h]), do: help()
  def main(~W[--help]), do: help()
  def main([path|args]) do
    IO.puts(SinglePage.eval_file(path, args))
  end


  defp help do
    Color.putc(usage())
  end

  defp usage do
    [
      :bold,
      "usage:", nl(),
      "  single_page", :cyan, " -h|--help", :reset, " shows this text\n",
      "  single_page", :cyan, " -v|--version", nl(),
      "\n",
      "  single_page", :magenta, " file ", :cyan, "<named args>", nl(),
      "      evaluate  an eex template from ", mag("file"), nl(),
      "      the following bindings are available inside eex templates:", nl(), nl(),
      "     ", blue("earmark"), " which exposes all Earmark functions", nl(),
      "     ", blue("h"), " which exposes the following functions", nl(),
      "         ", blue("h.include <file>"), " includes the, recursive, evaluation of <file>", nl(),
      "         ", blue("h.md_from_file <file>"), " short for ", blue("earmark.as_html!"), nl(),
      "         ", blue("h.style <file>"), " create a stylesheet tag for ", blue("<file>"), nl(),
      "         ", blue("h.args"), " a map of the ", cyan("<named args>"), nl(),
    ] 
    |> List.flatten 
  end

  @spec version() :: :ok
  defp version() do
    with {:ok, version_lst} <- :application.get_key(:single_page, :vsn) do
      Color.putc(["single_page version: ", :cyan, to_string(version_lst)])
    end
  end


end
# SPDX-License-Identifier: AGPL-3.0-or-later
