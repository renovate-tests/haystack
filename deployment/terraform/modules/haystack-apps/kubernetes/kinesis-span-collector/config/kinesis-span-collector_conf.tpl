kafka {
  producer {
    topic = "proto-spans"
    props {
      bootstrap.servers = "${kafka_endpoint}"
    }
  }
}

kinesis {
  aws.region = "${kinesis_stream_region}"
  app.group.name = "haystack-kinesis-proto-span-collector"

  stream {
    name = "${kinesis_stream_name}"
    position = "LATEST"
  }

  checkpoint {
    interval.ms = 15000
    retries = 50
    retry.interval.ms = 250
  }

  task.backoff.ms = 200
  max.records.read = 2000
  idle.time.between.reads.ms = 500
  shard.sync.interval.ms = 30000

  metrics {
    level = "NONE"
    buffer.time.ms = 15000
  }
}