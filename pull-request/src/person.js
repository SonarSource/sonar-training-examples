function Person(first, last) {
    this.firstName = first;
    this.lastName = last;
    this.age = null;
    this.eyeColor = null;
    this.nationality = null;
}

Person.prototype.fullname = function() {
    return this.firstName + " " + this.lastName;
}

Person.prototype.wishHappyBirthday = function() {
    return "Happy birthday " + this.firstName;
    this.age++;
}
