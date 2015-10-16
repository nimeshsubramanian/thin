thin
=================

This cookbook is used for installing and configuring a thin web server


Requirements
------------
* Chef 11 or higher
* Ruby 2.0.0 or higher

Platform
---------
CentOS, Red Hat 

Attributes
----------
In order to keep the README managable and in sync with the attributes, this cookbook documents attributes inline. 

The cookbook does its best to set you up with sane defaults out of the box. The only expectation is that you set the following attributes:
* `node['thin']['app_name']` # The cookbook will error out if this attribute is not set, this is also the name of your project.
* `node['thin']['git']['repository']` # The URI for the git repository

Usage
-----
Just add the default recipe `recipe[thin::default]` to the run_list

Contributing
---------------
* Source hosted at [GitHub](https://github.com/nimeshsubramanian/thin)
* Report issues/Questions/Feature requests on [GitHub Issues](https://github.com/nimeshsubramanian/thin/issues)

PR's are welcome! Make sure all the tests pass before submitting one :-). Create a new feature branch for each new feature!

License & Authors
-----------------

**Author:** [Nimesh Subramanian](https://github.com/nimeshsubramanian)

```
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
