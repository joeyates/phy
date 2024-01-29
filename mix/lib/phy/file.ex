defmodule Phy.File do
  @moduledoc """
  This module is responsible for all file operations.

  Each function has a second implementation that is used for testing.
  This second implementation accepts a File mock module that implements the file-system
  related function that is being tested.
  """
  @callback exists?(path :: String.t) :: boolean()
  @callback exists?(path :: String.t, any()) :: boolean()
  def exists?(path, file \\ File) do
    file.exists?(path)
  end

  @callback mkdir_p(path :: String.t) :: :ok
  @callback mkdir_p(path :: String.t, any()) :: :ok
  def mkdir_p(path, file \\ File) do
    file.mkdir_p(path)
  end

  @callback write!(String.t, String.t) :: :ok
  @callback write!(String.t, String.t, any()) :: :ok
  def write!(path, content, file \\ File) do
    file.write!(path, content)
  end
end
