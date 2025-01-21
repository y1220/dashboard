# Persona Management System

This is a Rails application for managing personas, including searching and exporting persona data.

## Table of Contents
- [Installation](#installation)
- [Usage](#usage)
- [Search and Filter](#search-and-filter)
- [Export Data](#export-data)

## Installation

1. **Clone the repository:**
    ```sh
    git clone https://github.com/y1220/dashboard.git
    cd dashboard
    ```

2. **Install the required gems:**
    ```sh
    bundle install
    ```

3. **Set up the database:**
    ```sh
    rails db:create
    rails db:migrate
    rails db:seed
    ```

## Usage

To start the Rails server:
```sh
rails server
```
Navigate to http://localhost:3000 in your web browser to use the application.

## Search and Filter

The application supports filtering personas based on the following criteria:
- **Name:** Search for personas by their name.
- **Gender:** Filter personas by gender.
- **Age:** Filter personas within a specific age range.

## Export Data

You can export persona data to a CSV file. To do this, navigate to the export page and click the "Export" button. The data will be downloaded to
