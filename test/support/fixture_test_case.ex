defmodule Test.Support.FixtureTestCase do
  defmacro __using__(_opts \\ nil) do
    quote do
      use ExUnit.Case

      import SinglePage

      def fixture(path) do
        File.read!(fixture_path(path))
      end

      def fixture_lines(path) do
        path  
        |> fixture_path 
        |> File.stream!
        |> Stream.map(&String.trim_trailing(&1, "\n"))
      end

      def fixture_path(path) do
        Path.join("test/fixtures", path)
      end
    end
  end
end
# SPDX-License-Identifier: AGPL-3.0-or-later
