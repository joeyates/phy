defmodule Phy.Generate.LiveView do
  require Logger

  @phy_file Application.compile_env(:phy, :file, Phy.File)
  @phy_mix_project Application.compile_env(:phy, :mix_project, Phy.Mix.Project)

  @callback run([String.t()]) :: :ok
  def run(name) do
    app = @phy_mix_project.config()[:app]
    view_path = Path.join(["lib", "#{app}_web", "live", "#{name}_live.ex"])
    view_directory = Path.dirname(view_path)
    @phy_file.mkdir_p(view_directory)
    @phy_file.write!(view_path, live_view_content(name))
    test_path = Path.join(["test", "#{app}_web", "live", "#{name}_live_test.exs"])
    test_directory = Path.dirname(test_path)
    @phy_file.mkdir_p(test_directory)
    @phy_file.write!(test_path, live_view_test_content(name))
    :ok
  end

  defp live_view_content(name) do
    module = module()
    web_module = "#{module}Web"
    live_view_name = live_view_name(name)

    ~s"""
    defmodule #{web_module}.#{live_view_name} do
      use #{web_module}, :live_view

      @impl true
      @spec mount(params :: map(), session :: map(), socket :: Phoenix.LiveView.Socket.t()) :: {:ok, Phoenix.LiveView.Socket.t()}
      def mount(_params, _session, socket) do
        socket
        |> ok()
      end

      @impl true
      @spec handle_params(params :: map(), url :: String.t(), socket :: Phoenix.LiveView.Socket.t()) :: {:noreply, Phoenix.LiveView.Socket.t()}
      def handle_params(_params, _url, socket) do
        socket
        |> noreply()
      end

      @impl true
      def render(assigns) do
        ~H\"\"\"
        <.header>
        <p>#{name}</p>
        </.header>
        \"\"\"
      end
    end
    """
  end

  defp live_view_test_content(name) do
    module =
      @phy_mix_project.config()[:app]
      |> Atom.to_string()
      |> Macro.camelize()

    web_module = "#{module}Web"
    live_view_name = "#{Macro.camelize(name)}Live"

    ~s"""
    defmodule #{web_module}.#{live_view_name}Test do
      use #{web_module}.ConnCase

      import Phoenix.LiveViewTest

      test "presents a view", %{conn: conn} do
        {:ok, _live, html} = live(conn, ~p"/#{name}")

        assert html =~ "#{name}"
      end
    end
    """
  end

  defp module do
    @phy_mix_project.config()[:app]
    |> Atom.to_string()
    |> Macro.camelize()
  end

  defp live_view_name(name) do
    "#{Macro.camelize(name)}Live"
  end
end
