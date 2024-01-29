defmodule Phy.GeneratorTest do
  use ExUnit.Case, async: true
  import Mox

  setup :verify_on_exit!

  setup do
    stub(Phy.FileMock, :mkdir_p, fn _ -> :ok end)
    stub(Phy.FileMock, :write!, fn _, _ -> :ok end)

    :ok
  end

  test "it returns ok" do
    assert Phy.Generator.run("path", "template", %{}) == :ok
  end

  test "it saves the file" do
    expect(Phy.FileMock, :write!, fn "path", "template" -> :ok end)

    Phy.Generator.run("path", "template", %{})
  end

  test "it creates the file's directory" do
    expect(Phy.FileMock, :mkdir_p, fn "path/to" -> :ok end)

    Phy.Generator.run("path/to/file", "template", %{})
  end

  test "it processes the template via EEx" do
    expect(Phy.FileMock, :write!, fn _, "2" -> :ok end)

    assert Phy.Generator.run("path", "<%= 1 + 1 %>", %{}) == :ok
  end
end
