function Employee(first, last) {
    this.firstName = first;
    this.lastName = last;
    this.age = null;
    this.eyeColor = null;
    this.nationality = null;
    this.gender = null;
    this.religion = null;
    this.compensation = undefined;
}

Employee.prototype.fullname = function() {
    return this.firstName + " " + this.lastName;
}

Employee.prototype.setCompensation = function() {
    if (this.gender === "Male") {
        this.compensation = SOME_VALUE;
    } else if (this.gender === "Female") {
        this.compensation = ANOTHER_VALUE;
    }
}

Employee.prototype.storeReligion = function(religion) {
    this.religion = religion
}

