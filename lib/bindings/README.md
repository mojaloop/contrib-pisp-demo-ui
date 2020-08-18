#### Bindings

* Bindings tell `Get` which controllers need to be active when a page is rendered. `Get` helps reduce the memory foorprint of our app by cleaning up controllers which are currently not in use.
* Inherit from **Bindings** class ans override the **dependencies** method. The rest is taken care by `Get` for us. 
* You should expect to see one binding for every widget listed in ui/pages .
