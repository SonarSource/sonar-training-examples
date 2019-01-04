function Person(first, last) {
    this.firstName = first;
    this.lastName = last;
    this.age = null;
    this.eyeColor = null;
    this.nationality = null;
}

Person.prototype.fullname = function() {
    console.log("About to return full name");
    return this.firstName + " " + this.lastName;
}

Person.prototype.wishHappyBirthday = function() {
    console.log("About to wish someone a happy birthday at age " + this.age + "!");
    return "Happy birthday " + this.firstName;
    this.age++;
}
