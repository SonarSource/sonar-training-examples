function Person(first, last) {
    this.firstName = first;
    this.lastName = last;
    this.age = null;
    this.eyeColor = undefined;
    this.nationality = null;
}

Person.prototype.fullname = function() {
    return this.firstName + " " + this.lastName;
}

Person.prototype.wishHappyBirthday = function() {
    this.age++;
    return "Happy birthday " + this.firstName;
}
