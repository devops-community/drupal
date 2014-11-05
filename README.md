# Drupal

Build and deploy a simple Drupal blog on [devo.ps](http://devo.ps).

## Install

Simply use the link below:

[![Fork on devo.ps](https://app.devo.ps/assets/images/fork.png)](https://app.devo.ps/#/fork?git_url=https://github.com/devops-community/drupal)

Once you've forked the repository, open it in devo.ps and you will be prompted for a few settings, including the Git URL for the code of your application.

To deploy your app, you will need to navigate to the tasks page of the repo and run the task manually (click on "play" icon, right of the "Install Drupal blog" task).

## What's in the box?

This setup contains one server (`nodes/drupal.yml`) with **Nginx**, **PHP** and **MySQL 5.5** (with a "drupal" user and a "drupal" database)

We have included as well a task (`tasks/install-drupal.yml`) that:

1. Run an install script (`scripts/install-drupal.sh`) that will:
  1. Fetch the latest Drupal package from drupal.org
  1. Unpack the Drupal package
  1. Write the configuration file (to connect it to MySQL)
  1. Update the upload folders

The current repo provides a very simple setup. Hack at will!

## Questions?

If you have any question, come ask us on the [devo.ps chat](https://www.hipchat.com/gyHEHtsXZ) or shoot us an email at [help@devo.ps](mailto:help@devo.ps) (though, you should really just [ask us in the chat](https://www.hipchat.com/gyHEHtsXZ)).

# Reference

- [Nodes in devo.ps](http://docs.devo.ps/manual/nodes)
- [Tasks in devo.ps](http://docs.devo.ps/manual/tasks)

