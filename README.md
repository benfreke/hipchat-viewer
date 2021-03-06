#HipChat Log Export Viewer

GUI frontend viewer for [HipChat](https://www.hipchat.com/) chat log [API V2](https://www.hipchat.com/docs/apiv2) exports.
By Zhe Wang, zh3w4ng@gmail.com.
Released under the [MIT license](http://opensource.org/licenses/MIT).

## Exporting
Export your chat logs from the Admin screen of HipChat, download the zip archive and extract the `hipchat_export` folder to a happy place. It's recommended you put the contents of this folder (the `rooms` and `users` subfolders) in the `hipchat_export` folder of this tool, since it will be automatically recognised.

## Compiler
The compiler adds a `list.json` file in each room folder which can be used to look up the filenames of chat logs. Run it like so using Ruby:

	./compile.rb <hipchat_export directory>

If you've put the logs in the `hipchat_export` folder of this tool, you don't need to specify the directory argument.

You can't use the viewer without compiling, since JavaScript cannot traverse a directory :)

## Web Interface

The web interface allows you to view the compiled log directory. Place all the files for this tool in any web server (e.g. Apache) and view the hosted directory.

It will automatically load logs from the `hipchat_export` folder if found, otherwise you will need to specify the URL of this folder. For instance, you may run this tool here:

    http://localhost/hipchat-viewer/

And load the logs from here:

    http://localhost/some/other/path/hipchat_export
    
You will need to manually move the json files around, this isn't a production ready tool.

![image](https://raw.github.com/benfreke/hipchat-viewer/master/help/screenshot.png)