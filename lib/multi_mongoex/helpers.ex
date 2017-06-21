defmodule MultiMongoex.Helpers do
  def to_object_id(id) do
    {_, idbin} = Base.decode16(id, case: :mixed)
    %BSON.ObjectId{value: idbin}
  end

  def from_object_id(id) do
    Base.encode16(id.value, case: :lower)
  end
end