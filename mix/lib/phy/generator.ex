defmodule Phy.Generator do
  def from_templates(output_path_template, template_path, assigns) do
    output_path = EEx.eval_string(output_path_template, assigns: assigns)
    template = File.read!(template_path)
    build(output_path, template, assigns)
  end

  def build(path, template, assigns) do
    content = EEx.eval_string(template, assigns: assigns)
    directory = Path.dirname(path)
    Phy.File.mkdir_p!(directory)
    Phy.File.write!(path, content)
  end
end
