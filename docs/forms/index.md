# User Forms

This documentation introduces user forms, a powerful tool for creating and embedding forms in your applications. These forms are based on the `form-js` library, which provides a rich set of features for building dynamic and interactive user interfaces.

In Operaton, these forms are used in the tasklist application to display user tasks that require input. When a user task with a form is reached in a process, the form is rendered in the tasklist, allowing the user to enter the required data and complete the task.

## Features

User forms offer a variety of features to build complex forms with ease:

*   **Rich set of form elements:** Build your forms with a wide range of elements, including text fields, number inputs, checkboxes, radio buttons, and more.
*   **Layout control:** Arrange your form elements using columns and groups to create a clear and organized layout.
*   **Dynamic behavior:** Use expressions to control the visibility and state of form elements based on user input.
*   **Validation:** Ensure data quality with built-in validation rules and custom validation logic.
*   **Data binding:** Easily bind form data to your application's data model.

## Example

Here is a simple example of a form definition:

```json
{
  "components": [
    {
      "type": "textfield",
      "label": "Name",
      "key": "name"
    },
    {
      "type": "number",
      "label": "Age",
      "key": "age"
    }
  ],
  "type": "default"
}
```

This form contains two fields: a text field for the user's name and a number input for their age.

The above form is defined in `example.form` and can be rendered in this documentation using the `form-figure` directive:

```rst
.. form-figure:: example.form
```

which results in the following output:

.. form-figure:: example.form

## Form Components

The following components are available:

* `textfield`
* `textarea`
* `number`
* `checkbox`
* `radio`
* `select`
* `button`
* `group`
* `dynamiclist`
* `table`

(This list is not exhaustive.)