# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ByensHus.Repo.insert!(%ByensHus.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias ByensHus.Repo

{_, seededEvents} = Repo.insert_all(ByensHus.Events.Event, [
  %{
    title: "Event 1",
    description: "Description of event 1",
    location: "Location of event 1",
    start_time: ~U[2025-01-09 00:00:00Z],
    end_time: ~U[2025-01-09 23:30:00Z],
    image: "https://picsum.photos/512/512",
    published_at: DateTime.utc_now(:second)
  },
  %{
    title: "Event 2",
    description: "Description of event 2",
    location: "Location of event 2",
    start_time: ~U[2025-02-09 00:00:00Z],
    end_time: ~U[2025-02-09 23:30:00Z],
    image: "https://picsum.photos/512/512",
    published_at: DateTime.utc_now(:second)
  }
], returning: true);
[ev1, ev2] = seededEvents
Repo.insert_all(ByensHus.Accounts.Posts, [
  %{
    title: "Post 1",
    content: "Content of post 1",
    user_id: 1,
    event_id: ev2.id,
    published_at: DateTime.utc_now(:second)
  },
  %{
    title: "Post 2",
    content: "Content of post 2",
    user_id: 1,
    event_id: ev2.id,
    published_at: DateTime.utc_now(:second)
  }
], returning: true);
