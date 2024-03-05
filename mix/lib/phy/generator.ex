defmodule Phy.Generator do
  defmacro __using__(opts) do
    templates = opts[:templates]
    quote do
      alias Phy.Generator

      @templates_path Path.join([File.cwd!(), "priv", "templates"])
      @templates unquote(templates)

      for %{template: template} <- @templates do
        @external_resource Path.join(@templates_path, template)
      end

      def generate(assigns) do
        @templates
        |> Enum.each(fn %{path: path, template: template} ->
          template_path = Path.join(@templates_path, template)
          Generator.from_templates(path, template_path, assigns)
        end)
      end

    end
  end

  def from_templates(output_path_template, template_path, assigns) do
    output_path = EEx.eval_string(output_path_template, assigns: assigns)
    template = File.read!(template_path)
    build(output_path, template, assigns)
  end

  def build(path, template, assigns) do
    content = EEx.eval_string(template, assigns: assigns)
    directory = Path.dirname(path)
    File.mkdir_p!(directory)
    File.write!(path, content)
  end
end
