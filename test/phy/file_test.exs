defmodule FileMock do
  def exists?(path) do
    send(self(), {__MODULE__, :exists?, path})
    true
  end

  def mkdir_p(path) do
    send(self(), {__MODULE__, :mkdir_p, path})
    {:ok}
  end

  def write!(path, content) do
    send(self(), {__MODULE__, :write!, path, content})
    :ok
  end
end

defmodule Phy.FileTest do
  use ExUnit.Case, async: true

  describe "write!" do
    test "it writes the file" do
      Phy.File.write!("path", "content", FileMock)

      assert_receive {FileMock, :write!, "path", "content"}
    end
  end
end
