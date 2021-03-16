defmodule Viewplex.Renderer do
  @moduledoc false

  # This code was partially forked from Phoenix LiveView:
  # https://github.com/phoenixframework/phoenix_live_view/blob/v0.15.4/lib/phoenix_live_view/renderer.ex

  defmacro __before_compile__(env) do
    render? = Module.defines?(env.module, {:render, 1})

    root = Path.dirname(env.file)

    filename = template_filename(env)
    templates = Phoenix.Template.find_all(root, filename)

    case {render?, templates} do
      {true, [template | _]} ->
        message = template_ignored_message(env, template)
        IO.warn(message, Macro.Env.stacktrace(env))

      {true, []} ->
        :ok

      {false, [template]} ->
        ast = template_ast(template, filename)

        quote do
          def render(var!(assigns)) when is_map(var!(assigns)) do
            unquote(ast)
          end
        end

      {false, [_ | _]} ->
        message = multiple_templates_found_message(env, templates)
        IO.warn(message, Macro.Env.stacktrace(env))

      {false, []} ->
        message = no_render_or_template_found_message(env)

        quote do
          def render(_assigns) do
            raise unquote(message)
          end
        end
    end
  end

  defp template_ignored_message(env, template) do
    ~s"""
    Ignoring the template #{inspect(template)}...
    The component #{inspect(env.module)} is already defining a render/1 function.
    """
  end

  defp multiple_templates_found_message(env, templates) do
    ~s"""
    Multiple templates were found for component #{inspect(env.module)}:
    #{inspect(templates)}"
    """
  end

  defp no_render_or_template_found_message(env) do
    ~s"""
    No render function or template found for component #{inspect(env.module)}.
    Make sure that you have a template with the same name as the component or has defined a `render/1` function.
    """
  end

  defp template_ast(template, filename) do
    extension = template_extension(template)
    engine = Map.fetch!(Phoenix.Template.engines(), extension)
    engine.compile(template, filename)
  end

  defp template_extension(template) do
    template
    |> Path.extname()
    |> String.trim_leading(".")
    |> String.to_atom()
  end

  defp template_filename(env) do
    env.module
    |> Module.split()
    |> List.last()
    |> Macro.underscore()
    |> Kernel.<>(".html")
  end
end
