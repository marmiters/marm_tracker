# MarmTracker

## Installation

### Prerequisites

  * Build essential tools
  * Elixir 1.7 or above
  * PostgreSQL 9.6 or above
  * Initialise PostgreSQL database with an account for MarmTracker to use
  * Clone this git repository with `git clone https://github.com/marmiters/marm_tracker.git"

### Installation

  * Install Elixir dependencies with `mix deps.get`
  * For the next steps, the default will be to run MarmTracker in developer mode. To run using production mode, prefix each command with `MIX_ENV=prod`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start MarmTracker endpoint with `mix phx.server`

MarmTracker is now available at [`localhost:4000`](http://localhost:4000). In a production environment you will want a reverse proxy to pass traffic to the server. TODO: Finish section