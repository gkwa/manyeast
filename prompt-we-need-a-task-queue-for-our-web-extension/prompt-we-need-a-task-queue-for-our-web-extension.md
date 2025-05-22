{{ include "../add-google-search-links/add-links.md" . | trim }}"

I have a chrome extension that performs some task and then 
our next step is to wait for some response and perform some sequence according to the
response.

For this, I recognize we're in a "pipeline" and I expect we need some task queue.

One option is to setup aws sqs and add credentials and orchestrate the task queue accordingly.

We need durability in case a task fails.

Using AWS SQS seems a bit "heavy handed" and I expect there are more lite weight solutions that don't rely on setting up expensive arch on aws.

I guess ideally we'd have a task queue in local storage on the browser maybe.

Your thought?
