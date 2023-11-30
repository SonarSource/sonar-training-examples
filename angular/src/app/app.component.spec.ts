import { TestBed } from '@angular/core/testing';
import { AppComponent } from './app.component';

describe('AppComponent', () => {
  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AppComponent],
    }).compileComponents();
  });

  it('should create the app', () => {
    const fixture = TestBed.createComponent(AppComponent);
    const app = fixture.componentInstance;
    expect(app).toBeTruthy();
  });

  it(`should have the 'angular-example' title`, () => {
    const fixture = TestBed.createComponent(AppComponent);
    const app = fixture.componentInstance;
    expect(app.title).toEqual('angular-example');
  });

  it('should render title', () => {
    const fixture = TestBed.createComponent(AppComponent);
    fixture.detectChanges();
    const compiled = fixture.nativeElement as HTMLElement;
    expect(compiled.querySelector('h1')?.textContent).toContain('Welcome to angular-example!');
  });

  it('should handle doStuff method when the first list item is clicked', () => {
    const fixture = TestBed.createComponent(AppComponent);

    spyOn(window, 'alert').and.callThrough();

    const anchorElement = fixture.debugElement.nativeElement.querySelector('[class="first-item"]');
    // Do not use `anchorElement.click();`! Otherwise, infinite loop of Karma disconnect/connect
    // will occur. See fix: https://github.com/karma-runner/karma/issues/3267#issuecomment-564916205
    anchorElement.dispatchEvent(new Event('click'));

    expect(window.alert).toHaveBeenCalledWith('I did stuff');
  });
});
