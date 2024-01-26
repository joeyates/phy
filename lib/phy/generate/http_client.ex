defmodule Phy.Generate.HTTPClient do
  @phy_file Application.compile_env(:phy, :file, Phy.File)
  @phy_mix_project Application.compile_env(:phy, :mix_project, Phy.Mix.Project)

  @callback run() :: :ok
  def run do
    app = @phy_mix_project.app()
    client_path = Path.join(["lib", "#{app}", "http_client.ex"])
    @phy_file.write!(client_path, client_content())
    test_path = Path.join(["test", "#{app}", "http_client_test.exs"])
    @phy_file.write!(test_path, test_content())
    :ok
  end

  defp client_content do
    module = @phy_mix_project.module()
    ~s"""
    defmodule #{module}.HTTPClient do
      @callback get(String.t()) :: {:ok, String.t()} | {:error, Atom.t()}
      @callback get(String.t(), any()) :: {:ok, String.t()} | {:error, Atom.t()}
      def get(url, req \\\\ Req) do
        case req.get(url) do
          {:ok, %Req.Response{status: 200} = response} ->
            {:ok, response.body}
          {:ok, %Req.Response{status: 404}} ->
            {:error, :not_found}
          {:error, _error} ->
            {:error, :not_found}
        end
      end
    end
    """
  end

  def test_content do
    module = @phy_mix_project.module()
    ~s"""
    defmodule MockHTTPClient do
      @behaviour #{module}.HTTPClient

      def get("https://www.example.com") do
        {:ok, %Req.Response{status: 200, body: "Some HTML"}}
      end

      def get("https://www.doesntexist.com/some/path") do
        {:ok, %Req.Response{status: 404}}
      end

      def get("https://return.error") do
        {:error, "Boom!"}
      end

      @doc \"\"\"
      It makes no sense to mock get/2, as it is simply for testing
      \"\"\"
      def get(_url, _mock), do: nil
    end

    defmodule #{module}.HttpClientTest do
      use #{module}.DataCase

      alias #{module}.HTTPClient

      test "get returns the body of the response" do
        {:ok, body} = HTTPClient.get("https://www.example.com", MockHTTPClient)
        assert String.contains?(body, "Some HTML")
      end

      test "get returns :not_found when the response is 404" do
        {:error, :not_found} = HTTPClient.get("https://www.doesntexist.com/some/path", MockHTTPClient)
      end

      test "get returns :not_found for other errors" do
        {:error, :not_found} = HTTPClient.get("https://return.error", MockHTTPClient)
      end
    end
    """
  end
end
