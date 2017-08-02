class AddHeartFields < ActiveRecord::Migration[5.1]
  def change
    add_column :hearts, :happiness_goals, :text
    add_column :hearts, :happiness_signals, :text
    add_column :hearts, :happiness_metrics, :text

    add_column :hearts, :engagement_goals, :text
    add_column :hearts, :engagement_signals, :text
    add_column :hearts, :engagement_metrics, :text

    add_column :hearts, :adoption_goals, :text
    add_column :hearts, :adoption_signals, :text
    add_column :hearts, :adoption_metrics, :text

    add_column :hearts, :retention_goals, :text
    add_column :hearts, :retention_signals, :text
    add_column :hearts, :retention_metrics, :text

    add_column :hearts, :task_goals, :text
    add_column :hearts, :task_signals, :text
    add_column :hearts, :task_metrics, :text

    add_column :hearts, :happiness_bool, :boolean, default: false
    add_column :hearts, :engagement_bool, :boolean, default: false
    add_column :hearts, :adoption_bool, :boolean, default: false
    add_column :hearts, :retention_bool, :boolean, default: false
    add_column :hearts, :task_bool, :boolean, default: false

  end
end
