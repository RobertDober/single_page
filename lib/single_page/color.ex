defmodule SinglePage.Color do
  @moduledoc false
  
  
  def blue(content) do
    [:blue, content, :reset]
  end
  
  def cyan(content) do
    [:magenta, content, :reset]
  end

  def mag(content) do
    [:magenta, content, :reset]
  end

  def nl do
    [:reset, "\n"]
  end

end
# SPDX-License-Identifier: AGPL-3.0-or-later
