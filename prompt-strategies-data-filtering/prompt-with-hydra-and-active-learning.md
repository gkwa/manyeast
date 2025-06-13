I visit various retailers and searched for frozen salmon and got these results:

```
<frozen_samlmon_results>
{{ include "data-frozen-salmon.json" . | trim }}
</frozen_samlmon_results>
```

Only some of them are what I'm interested in.

Next, I searched for raw peanuts and got these results:

```
<raw_peanuts>
{{ include "data-raw-peanuts.json" . | trim }}
</raw_peanuts>
```

Again only some of them are what I'm interested in.

I need to employ NLP techniques to 

- filter to only the products that I'm interested in based off my particular interests

- detect price for the product

{{ include "categories.md" . | trim }}

I want to use NLP techniques to help find what I'm looking for in these results but I don't know how to get started.

I will use python with a package

{{include "../python-package/python-package.md" . | trim}}

Want to use a hybride approach using rule based filtering and supervised learning

- active learning to bootstrap using rules and then train and iterate

- python Hyrdra package to keep organized with various products/categories.  Each category will have its own space set aside along with config all controlled by hydra

We will have many categories so we will need to keep organized.  By this I mean we should 

- deduplicate regexes in our rule based filtering
- use the builder pattern in order to be able to reuse code while allowing for unique flows for particular categories

We will need to be able to specify our category of interest on the CLI.

I have got started earlier with this project in a getting started python script which I've included here, but we need to start moving into a package with hydra and proper configs in order to keep organized with multiple products/categories.

```
<old_salmon_filtering_py>
{{ include "salmon_filtering.py" . | trim }}
</old_salmon_filtering_py>
```

If hydra supports configuration inheritance or overlays then we should ues it in order to keep our configuration dry.

We should have the option to choose a group of filtering rules for different occasions.  What I mean by this is that we should be able to filter out the restriction that we need our salmon to be frozen for the case where we plan to consume it today, but for the case where we plan to travel for 8h on the plane we'd want to filter to only include frozen salmon.

That should be toggle-able using hydra config along with being able to activate/deactivate that from the cli.

I expect since we're using hydra we actually will not be able to use argparse and that's O.K.
