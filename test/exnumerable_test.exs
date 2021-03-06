defmodule ExnumeratorTest do
  use ExUnit.Case

  @values [:sent, :read, :received, :delivered]

  defmodule Message do
    use Exnumerator,
      values: [:sent, :read, :received, :delivered]
  end

  test "should store given values",
    do: assert Message.values == @values

  test "should return a random value",
    do: assert Message.sample in @values

  test "should augment given types" do
    assert Message.cast("sent")      == {:ok, :sent}
    assert Message.cast(:read)       == {:ok, :read}
    assert Message.load("received")  == {:ok, :received}
    assert Message.dump("delivered") == {:ok, "delivered"}
    assert Message.dump(:sent)       == {:ok, "sent"}
  end

  test "should not cast unknown argument" do
    assert Message.cast("invalid") == :error
    assert Message.cast(:invalid)  == :error
    assert Message.load("invalid") == :error
    assert Message.load(:invalid)  == :error
    assert Message.dump("invalid") == :error
    assert Message.dump(:invalid)  == :error
  end
end
