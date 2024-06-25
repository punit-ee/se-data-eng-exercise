provider "google" {
  project     = "ee-india-se-data"
}

resource "google_storage_bucket" "bucket" {
  name          = "se-data-landing-punit"
  location      = "US"
  storage_class = "STANDARD"
  public_access_prevention = "enforced"
  uniform_bucket_level_access = true
}

resource "google_bigquery_dataset" "dataset" {
  dataset_id                  = "movies_data_punit"
  friendly_name               = "movies_data"
  description                 = "Movies Data"
  location                    = "US"

  labels = {
    env = "default"
  }

  access {
    role          = "OWNER"
    user_by_email = google_service_account.bqowner.email
  }

  access {
    role   = "READER"
    domain = "hashicorp.com"
  }
}

resource "google_service_account" "bqowner" {
  account_id = "bqowner"
}

resource "google_bigquery_table" "default" {
  dataset_id = google_bigquery_dataset.dataset.dataset_id
  table_id   = "movies_raw"


  labels = {
    env = "default"
  }

  schema = <<EOF
[
  {
    "name": "adult",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "Described movie is adult or not"
  },
  {
    "name": "belongs_to_collection",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "movie collection belongs"
  },
  {
    "name": "genres",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "genres"
  },
  {
    "name": "homepage",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "homepage"
  },
  {
    "name": "id",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "id"
  },
  {
    "name": "imdb_id",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "imdb_id"
  },
  {
    "name": "original_language",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "original language"
  },
  {
    "name": "original_title",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "original title"
  },
  {
    "name": "overview",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "overview"
  },
  {
    "name": "popularity",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "popularity"
  },
  {
    "name": "poster_path",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "poster path"
  },
  {
    "name": "production_companies",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "production companies"
  },
  {
    "name": "production_countries",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "production countries"
  },
  {
    "name": "release_date",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "release date"
  },
  {
    "name": "revenue",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "revenue"
  },
  {
    "name": "runtime",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "runtime"
  },
  {
    "name": "spoken_languages",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "spoken_languages"
  },
  {
    "name": "tagline",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "tagline"
  },
  {
    "name": "title",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "Title"
  },
  {
    "name": "video",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "video"
  },
  {
    "name": "vote_average",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "vote average"
  },
  {
    "name": "vote_count",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "vote count"
  },
  {
    "name": "load_date",
    "type": "TIMESTAMP",
    "mode": "REQUIRED",
    "description": "Load Date",
    "defaultValueExpression": "CURRENT_TIMESTAMP()"
  }
]
EOF

}