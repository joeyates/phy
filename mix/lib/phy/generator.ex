defmodule Phy.Generator do

  def build(path, template, assigns) do
    content = EEx.eval_string(template, assigns: assigns)
    directory = Path.dirname(path)
    Phy.File.mkdir_p!(directory)
    Phy.File.write!(path, content)
  end
end
