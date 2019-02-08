function Person(first, last) {
    this.firstName = first;
    this.lastName = last;
    this.age = undefined;
    this.eyeColor = null;
    this.nationality = undefined;
}

Person.prototype.fullname = function() {
    return this.firstName + " " + this.lastName;
}

Person.prototype.wishHappyBirthday = function() {
    return "Happy birthday " + this.firstName;
    this.age++;
}
