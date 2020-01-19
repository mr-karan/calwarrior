<template>
  <v-app>
    <v-app-bar app color="green darken-4" dark>
      <v-toolbar-title>CalWarrior</v-toolbar-title>
    </v-app-bar>

    <v-content>
      <v-sheet tile color="grey lighten-3" class="d-flex">
        <v-btn icon class="ma-2" @click="$refs.calendar.prev()">
          <v-icon>mdi-chevron-left</v-icon>
        </v-btn>
        <v-select
          v-model="type"
          :items="types"
          dense
          outlined
          hide-details
          class="ma-2"
          label="View"
        ></v-select>
        <v-select
          v-model="weekday"
          :items="weekdays"
          dense
          outlined
          hide-details
          label="Weekday"
          class="ma-2"
        ></v-select>
        <v-spacer></v-spacer>
        <v-btn icon class="ma-2" @click="$refs.calendar.next()">
          <v-icon>mdi-chevron-right</v-icon>
        </v-btn>
      </v-sheet>
      <v-sheet height="600">
        <v-calendar
          ref="calendar"
          v-model="value"
          :weekdays="weekday"
          :type="type"
          :events="events"
          :event-overlap-mode="mode"
          :event-overlap-threshold="30"
          :event-color="getEventColor"
          @change="getEvents"
        ></v-calendar>
      </v-sheet>
    </v-content>
  </v-app>
</template>

<script>
/*eslint no-unused-vars: ["error", { "args": "none" }]*/

import tasks from "../data/tasks.json";

export default {
  data: () => ({
    tasks: tasks,
    type: "month",
    types: ["month", "week", "day", "4day"],
    mode: "stack",
    modes: ["stack", "column"],
    weekday: [0, 1, 2, 3, 4, 5, 6],
    weekdays: [
      { text: "Sun - Sat", value: [0, 1, 2, 3, 4, 5, 6] },
      { text: "Mon - Sun", value: [1, 2, 3, 4, 5, 6, 0] },
      { text: "Mon - Fri", value: [1, 2, 3, 4, 5] },
      { text: "Mon, Wed, Fri", value: [1, 3, 5] }
    ],
    value: "",
    events: [],
    colors: ["blue", "indigo", "deep-purple", "cyan", "green", "orange", "teal"]
  }),
  methods: {
    getEvents({ start, end }) {
      const events = [];

      for (let i = 0; i < tasks.length; i++) {
        if (
          (tasks[i].status == "pending" || tasks[i].status == "active") &&
          typeof tasks[i].due !== "undefined"
        ) {
          events.push({
            name: tasks[i].description,
            start: this.formatDate(tasks[i].due),
            end: this.formatDate(tasks[i].due),
            color: this.colors[this.rnd(0, this.colors.length - 1)]
          });
        }
      }

      this.events = events;
    },
    getEventColor(event) {
      return event.color;
    },
    rnd(a, b) {
      return Math.floor((b - a + 1) * Math.random()) + a;
    },
    formatDate(a) {
      if (!/^[0-9]{8}T[0-9]{6}Z$/.test(a)) {
        return null;
      }
      var year = a.substr(0, 4);
      var month = a.substr(4, 2);
      var day = a.substr(6, 2);
      var hour = a.substr(9, 2);
      var minute = a.substr(11, 2);
      var second = a.substr(13, 2);

      var d = new Date(Date.UTC(year, month - 1, day, hour, minute, second));
      return `${d.getFullYear()}-${d.getMonth() + 1}-${d.getDate()}`;
    }
  }
};
</script>