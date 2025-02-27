import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterOutlet } from '@angular/router';

@Component({
    selector: 'app-root',
    imports: [CommonModule, RouterOutlet],
    templateUrl: './app.component.html',
    styleUrl: './app.component.scss'
})
export class AppComponent {
  title = 'angular-example';

  doStuff() {
    const numbers = [10, 2, 30, 1, 5];
    numbers.sort(); // Noncompliant: lexicographic sort
    console.log(numbers); // Output: [1, 10, 2, 30, 5]
    alert('I did stuff');
    function concatenate() {
      let args = Array.prototype.slice.call(arguments);  // Noncompliant
      return args.join(', ');
    }

    function doSomething(isTrue) {
      var args = Array.prototype.slice.call(arguments, 1); // Noncompliant
      if (!isTrue) {
        for (var arg of args) {
        }
      }
    }
  }

  doOtherStuff() {
    alert('I did other stuff');

    function f() {
      try {
      } catch (err) {
      }
    }
  }
}
