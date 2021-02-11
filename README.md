# Viewplex

A convenience library that allows you to further separate your views into scoped components.

## Installation

Add `viewplex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:viewplex, "~> 0.1.0"}
  ]
end
```

Documentation can be be found at [https://hexdocs.pm/viewplex](https://hexdocs.pm/viewplex).

## Usage

### Configuration

Configure where your components are located with:

```elixir
config :viewplex,
  path: "lib/my_app_web/components"
```

### Components

Create new components by `use`-ing the `Viewplex.Component` module and creating a corresponding template with the same name.

**lib/my_app_web/components/label_component.ex:**

```elixir
defmodule LabelComponent do
  use Viewplex.Component
end
```

**lib/my_app_web/components/label_component.html.eex:**

```html
Hello World!
```

You can also use inline templates:

```elixir
defmodule LabelComponent do
  use Viewplex.Component

  def call(_module, assigns), do: ~E"Hello World"
end
```

Then, call your component inside a template:

```elixir
<%= component LabelComponent %>
```

> Remember to `import Viewplex.Helpers` in your views.


#### Filtering assigns

Components can also define fields:

```elixir
defmodule LabelComponent do
  use Viewplex.Component, [:message]
end
```

```elixir
<%= component LabelComponent, message: "Hello World" %>
```

Fields defined in the component will be available as an assign in your template:

```
<label><%= @message %></label>
```

This should allow you to simply pass down a map of assigns that will be filtered before actually invoking the component:

```
<%= component LabelComponent, assigns %>
```
#### Content blocks and slots

You can also pass content to your components:

Inline:

```elixir
<%= component LabelComponent, "Hello World" %>
```

Or using do blocks:

```elixir
<%= component LabelComponent do %>
  Hello World
<% end %>
```

This will be available as an assign under the `:content` key:

```html
<label><%= @content ></label>
```

Using named slots:

```elixir
<%= component LabelComponent do %>
  <% slot(:message, "Hello World") %>
<% end %>
```

```html
<label><%= @slots.message ></label>
```

> Notice that we are using `<%` instead of `<%=`. This is necessary because if you output the return of the `slot/2` function, you'll actually be rendering its content inside the component's block.  
> This happens because Viewplex will scan the component block for `slot/2` function calls and then extract the slot content so it is available in the template.  

#### Mouting

You can also customize how components are mounted by overriding the `mount/1` function:

```elixir
defmodule LabelComponent do
  use Viewplex.Component, [:message]

  def mount(assigns) do
    user = Users.get_user(assigns.user_id)
    {:ok, Map.put(assigns, :user, user)}
  end

end
```

Or disabling the component entirely by returning an `{:error, reason}` tuple:

```elixir
defmodule LabelComponent do
  use Viewplex.Component, [:message]

  def mount(assigns) do
    case Users.get_user(assigns.user_id) do
      nil -> {:error, "could not fetch user"}
      user ->  {:ok, Map.put(assigns, :user, user)}
    end   
  end
end
```

---
## Todo's

- [ ] Improve documentation
- [ ] Add real use-cases as examples
- [ ] Improve function typespecs
- [ ] Support defining components inside group folder (aka "feature folder")
- [x] Publish to Hex
- [ ] Scaffold and setup tasks
- [ ] Component documentation generation
- [ ] Get default component path based on app name
- [ ] Add test samples on README
- [ ] Log mount errors using Logger
