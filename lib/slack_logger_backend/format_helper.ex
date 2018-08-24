defmodule SlackLoggerBackend.FormatHelper do

  @moduledoc """
  Simple formatter for Slack messages.
  """

  import Poison, only: [encode: 1]

  @doc """
  Formats a log event for Slack.
  """
  def format_event({level, message, module, function, file, line}) do
    {:ok, event} = %{attachments: [%{
          fallback: "An #{level} level event has occurred: #{message}",
          pretext: message,
          color: get_color(level),
          fields: [%{
            title: "Level",
            value: level,
            short: true
          }, %{
            title: "Module",
            value: module,
            short: true
          }, %{
            title: "Function",
            value: function,
            short: true
          }, %{
            title: "File",
            value: file,
            short: true
          }, %{
            title: "Line",
            value: line,
            short: true
          }]
      }]}
      |> encode
    event
  end

  @doc """
  Formats a log event for Slack.
  """
  def format_event({level, message, application, module, function, file, line}) do
    {:ok, event} = %{attachments: [%{
          fallback: "An #{level} level event has occurred: #{message}",
          pretext: message,
          color: get_color(level),
          fields: [%{
            title: "Level",
            value: level,
            short: true
          }, %{
            title: "Application",
            value: application,
            short: true
          }, %{
            title: "Module",
            value: module,
            short: true
          }, %{
            title: "Function",
            value: function,
            short: true
          }, %{
            title: "File",
            value: file,
            short: true
          }, %{
            title: "Line",
            value: line,
            short: true
          }]
      }]}
      |> encode
    event
  end

  defp get_color(:info), do: "good"
  defp get_color(:debug), do: "#ffd77e"
  defp get_color(:warn), do: "warning"
  defp get_color(:error), do: "danger"
  defp get_color(_), do: "good"
end
