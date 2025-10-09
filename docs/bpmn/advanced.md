# Advanced BPMN concepts

This section continues from the [BPMN basics](./index.md) and introduces more advanced BPMN concepts.


## Alternative start events

```{bpmn-figure} more-start-events
While the plain {bpmn}`start-event` **start event** could be triggered through APIs to start processes in custom ways, also BPMN itself supports multiple ways to start processes. For example, {bpmn}`timer-start-event` **timer start event** can start a new process instance periodically, or {bpmn}`message-start-event` **message start event** from a BPMN message (even from an another process instance). {download}`more-start-events.bpmn`
```

The above example introduced the following new event type:

* {bpmn}`message-start-event` **message events**, for sending and receiving targeted messages, e.g. for inter-process communication


## Intermediate events

```{bpmn-figure} intermediate-events
In addition to {bpmn}`start-event` **start event**, {bpmn}`end-event` **end event**, and {bpmn}`empty-boundary-event` **boundary event**, BPMN has {bpmn}`intermediate-throw-event` **intermediate event** too. The simplest use case for them is to use empty intermediate events for marking relevant business states in the process (as metrics like KPIs in later data analysis). {download}`intermediate-events.bpmn`
```


## Even more events

```{bpmn-figure} more-events
Events in BPMN 2.0: start events, interrupting and non-interrupting start events, intermediate throw events, intermediate catch events, interrupting and non-interrupting boundary events, and end events. All in many different types. 
{download}`more-events.bpmn`
```

The above example introduced the following new event types:

* {bpmn}`signal-start-event` **signal event**, for sending and receiving broadcasted signals, e.g. for mass-cancellation of processes
* {bpmn}`conditional-start-event` **conditional event**, for being triggered on a condition, e.g. a process variable value change
* {bpmn}`compensation-event` **compensation event**, for triggering compensation tasks for already completed, but now compensated tasks.


## Message events

Message events are used to send or receive messages within a process or between different processes. They are a way to achieve inter-process communication. A message has a name and can carry a payload.

*   A {bpmn}`message-start-event` **message start event** can trigger a new process instance when a message is received.
*   An {bpmn}`intermediate-throw-event` **intermediate message throw event** sends a message.
*   An {bpmn}`intermediate-catch-event` **intermediate message catch event** waits for a message to be received.
*   A {bpmn}`message-end-event` **message end event** sends a message at the end of a process path.

Messages are targeted, meaning they are sent to a specific recipient.

```{bpmn-figure} message-start-event
This example shows a process that is started by a message. {download}`message-start-event.bpmn`
```

## Signal events

Signal events are similar to message events, but they are for broadcasting information to multiple processes, rather than targeted communication. A signal is broadcasted and any process that is listening for that signal will react to it.

*   A {bpmn}`signal-start-event` **signal start event** can start a new process instance when a signal is received.
*   An {bpmn}`intermediate-throw-event` **intermediate signal throw event** broadcasts a signal.
*   An {bpmn}`intermediate-catch-event` **intermediate signal catch event** waits for a signal.
*   A {bpmn}`signal-end-event` **signal end event** broadcasts a signal at the end of a process path.

Signals are useful for scenarios like broadcasting a system-wide shutdown or notifying multiple processes of a specific event.

```{bpmn-figure} signal-start-event
This diagram shows a process that starts when a specific signal is broadcast. {download}`signal-start-event.bpmn`
```

## Compensation

It is usual in BPMN that the same result can be achieved in multiple ways. For example, in testing, one must usually setup the environment before running the tests and clean up after the tests. Obviously, this can be achieved with just [the basic BPMN constructs](./index.md):

```{bpmn-figure} without-compensation
In this example, the test requires cloud resources, which are provisioned and waited for before the actual execution. {download}`without-compensation.bpmn`

```{tip} BPMN pools and communication between the pools do not affect the execution of the model in the BPM engine but allow better visualization and documentation of the process in its context. 
```

Alternatively, the same can be achieved with a {bpmn}`compensation-event` **compensation event** and accompanying {bpmn}`task` **compensation tasks** {bpmn}`compensation-boundary-event` connected to the tasks they are about to compensate if tasks have been executed successfully:

```{bpmn-figure} with-compensation
When a process ends with {bpmn}`compensation-end-event` **compensation end event**, the process engine will automatically execute the {bpmn}`compensation-boundary-event` compensation tasks for the tasks that have been successfully executed. {download}`with-compensation.bpmn`
```


## Multi-instance

```{bpmn-figure} multi-instance-subprocess
**Tasks** and **embedded sub-processes** can be configured to be **multi-instance** -- the BPMN way to loop over a collection. The configuration can be either {bpmn}`parallel-multi-instance` **parallel** or {bpmn}`sequential-multi-instance` **sequential**. Multi-instance requires an input collection to be configured for it, but then it executes task or sub-process separately for every input item in the collection with one BPMN symbol. {download}`multi-instance-subprocess.bpmn`
```

## Script task


```{bpmn-figure} script-task
```

**Script task** {bpmn}`script-task` is a task that allows executing custom scripts directly in the process engine being used. The supported scripting languages depend on the engine but typically include JavaScript, Groovy, or Python (Jython or GraalPy, which has not been implemented yet).

In Operaton BPMN engine, a script task can manipulate multiple process variables using its `execution.setVariable` API, or assign its return value to a single result variable.


## Business rule task

```{bpmn-figure} ./business-rule-task
**Business rule task** {bpmn}`business-rule-task` is a special task type reserved for automated rule-based decision making in a process. It's typically configured to use DMN (Decision Model and Notation) decision tables, designed to describe business rules. Additionally, DMN tables can be maintained separately from the process models, allowing for faster iterations.
```

This test case selection example demonstrates how a business rule task with DMN decision table can be used to select test cases based on the test case selection criteria. Even in this simple example, the DMN table should be compact and easier to maintain than the equivalent conditional logic in classic programming languages.

```{dmn-html} test-case-selection
```
{download}`test-case-selection.dmn`