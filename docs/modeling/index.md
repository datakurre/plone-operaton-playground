# Basic modeling exercises

These exercises should familiarize you with the basic BPMN elements and flows, and using [BPMN.io](https://bpmn.io/) based BPMN modeling tools, like [Miranum Modeler](https://marketplace.visualstudio.com/items?itemName=miragon-gmbh.vs-code-bpmn-modeler) included in the playground.


## Sequence flow

1. Start with a **simple flow** with multiple {bpmn}`../bpmn/task` tasks in sequence from {bpmn}`../bpmn/start-event` start to {bpmn}`../bpmn/end-event` end.
2. Toggle **Token Simulation** to observe how each token flows through the process one task at a time.
3. While on the simulator, hover on a task to **toggle pause** on a task.
4. Observe how the token stops and tasks wait for you to **release it with the play** button on a task.

```{bpmn-figure} simple-flow
{download}`simple-flow.bpmn`
```


## Exclusive paths

1. Model a flow that splits and joins with {bpmn}`../bpmn/exclusive-gateway` **exclusive gateways** (plain diamond symbol on the palette).
2. Find out how to make a flow path default through its context toolbar.
3. **Toggle Simulation** to observe how tokens choose their path on splits and joins.
4. While on the simulator, use **switch button** on the gateways to change the path.
5. See also, how the {bpmn}`../bpmn/start-event` start event and the {bpmn}`../bpmn/end-event` end event are vertically aligned with the **happy path** of the process. This usually makes the process easier to understand.

```{bpmn-figure} exclusive-paths
{download}`exclusive-paths.bpmn`
```


## Concurrent paths

1. Re-use the model from the previous exercise.
2. One at a time, choose the {bpmn}`../bpmn/exclusive-gateway` exclusive gateways on your diagram and use their **context modeling palettes** to turn them into {bpmn}`../bpmn/parallel-gateway` parallel gateways.
3. **Toggle Simulation** to observe how tokens multiply on splits and merge back in joins.
4. While on the simulator, **toggle pause** on tasks to observe how joining gateways wait for all incoming paths before letting the merged token continue.
5. Turn the first {bpmn}`../bpmn/parallel-gateway` parallel gateway back to {bpmn}`../bpmn/exclusive-gateway` exclusive gateway and simulate. What happens at the joining gateways? Why?
6. Revert the last step, and turn one of the latter {bpmn}`../bpmn/parallel-gateway` parallel gateways back to {bpmn}`../bpmn/exclusive-gateway` exclusive gateway and simulate. What happens now? Why?

```{bpmn-figure} concurrent-paths
{download}`concurrent-paths.bpmn`
```
{download}`concurrent-paths-locked.bpmn`<br/>
{download}`concurrent-paths-doubled.bpmn`<br/>
{download}`concurrent-paths-mixed.bpmn`


## Multiple end-events

1. Re-use the model from the previous exercise.
2. Replace some of the joining {bpmn}`../bpmn/parallel-gateway` parallel gateways with additional {bpmn}`../bpmn/end-event` end events.
3. **Toggle Simulation** to observe how the process completes only when all parallelized tokens have reached at least some of the end events.
4. While on the simulator, **toggle pause** on tasks to observe even more easily how completion of the process is delayed, even when some tokens reach end events on their paths.

```{bpmn-figure} multiple-end-events
{download}`multiple-end-events.bpmn`
```


## Embedded sub-process

1. Re-use the model from the previous exercise.
2. Wrap some of the {bpmn}`../bpmn/task.png` tasks with an embedded subprocess by looking up **Sub-process (expanded)**  from modeling palette.
3. **Toggle Simulation** to ensure that your process is still integrated (all tokens reach end events and process completes).

All this should just refactor your model with an abstraction useful for the next practice. Tasks or their execution order should not change.

```{bpmn-figure} embedded-sub-process
{download}`embedded-sub-process.bpmn`
```

```{note}
Embedded sub-processes could later be exported into separate processes, and called as external sub-processes using {bpmn}`../bpmn/call-activity-task` **call activity**.
```{bpmn-figure} embedded-sub-process-externalized
{download}`embedded-sub-process-externalized.bpmn`
```


## Boundary event

1. Re-use the model from the previous exercise.
2. Allow the tasks within the embedded sub-process to be cancelled with a timeout using {bpmn}`../bpmn/interrupting-timer-boundary-event` interrupting timer boundary event.
3. Add path from the {bpmn}`../bpmn/interrupting-timer-boundary-event` boundary event to a new joining {bpmn}`../bpmn/exclusive-gateway` to properly merge tokens before the {bpmn}`../bpmn/end-event` end event.
4. **Toggle Simulation** and **toggle pause** for a task within the sub-process to let you manually simulate the timer event and confirm that the process is completed properly also when triggering the timeout.
5. Investigate what happens if you had used {bpmn}`../bpmn/non-interrupting-timer-boundary-event` non-interrupting timer boundary event instead?

```{bpmn-figure} boundary-event
{download}`boundary-event.bpmn`
```

{download}`wrong-boundary-event.bpmn`


## More boundary events

1. Re-use the model from the previous exercise.
2. Add at least two more boundary events into the model with necessary paths and other elements. Make at least one of these to be a {bpmn}`../bpmn/non-interrupting-timer-boundary-event` non-interrupting timer boundary event.
3. **Toggle Simulation** to ensure your model's integrity. Make sure to try out your new boundary events.

```{bpmn-figure} more-boundary-events
{download}`more-boundary-events.bpmn`
```

```{note}
The example solution introduces the {bpmn}`../bpmn/terminate-end-event` **terminate end event**, which terminates all remaining tokens in the containing process tree.
```