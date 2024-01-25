defmodule Phy.Generator do
  @phy_file Application.compile_env(:phy, :file, Phy.File)

  def run(path, template, assigns) do
    content = EEx.eval_string(template, assigns: assigns)
    directory = Path.dirname(path)
    @phy_file.mkdir_p(directory)
    @phy_file.write!(path, content)
  end
end
