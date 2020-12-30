import { Component } from '@angular/core';

// This is a pretty generic component added for test purposes
// this is another comment line
@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent {
  title = 'angular-example';

  doStuff() {
    alert('I did stuff');
  }

  doOtherStuff() {
    alert('I did other stuff');
  }
}
