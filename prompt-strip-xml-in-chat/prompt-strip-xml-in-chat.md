Lets write a golang application that will do inplace edit on a file path and the purpose is to remove the my_initial_request element from the file. 

Our application will gather up all the section within the open and close my_initial_request element and remove it.

Our application will offer a --dry-run option to show what would be done but not actually do it.

Our application will offer the option to parse 0 or more file paths or 0 or more directories.

If the arguments are directories then our application will recurse into them and in place update the files it finds that contains this my_initial_request element.  

If our application is recursing through a directory and encounters an error opening or parsing a file then our application will not fail, it will write a warning and continue.

Our application should have proper tests using golden files.  I've included a description of golden file testing within the golden_file_testing_docs element

```
<golden_file_testing_docs>
{{ snippet "golden-file-testing-doc.txt" | trim }}"
</golden_file_testing_docs>
```

I've included chat_text xml which is the contents of a file.  It is a sample of the file that we will be updating to remove the my_initial_request xml.

```
<chat_text>
{{ snippet "chat.txt" | trim }}"
</chat_text>
```

{{ include "../golang-app/golang-app.md" . | trim }}"
