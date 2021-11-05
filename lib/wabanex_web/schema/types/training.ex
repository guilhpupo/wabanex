defmodule WabanexWeb.Schema.Types.Training do
  use Absinthe.Schema.Notation

  import_types WabanexWeb.Schema.Types.Exercise

  @desc "Logic training representation"
  object :training do
    field :id, non_null(:uuid4)
    field :start_date, non_null(:string)
    field :end_date, non_null(:string)
    field :exercises, list_of(:exercise)
  end

  input_object :create_training_input do
    field :start_date, non_null(:string), description: "Start training date"
    field :end_date, non_null(:string), description: "End training date"
    field :user_id, non_null(:uuid4), description: "User that owns this training"
    field :exercises, list_of(:create_exercise_input), description: "List of exercises"
  end
end
