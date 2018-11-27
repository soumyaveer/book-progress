function isBlank(value) {
  return !isPresent(value);
}

function isPresent(value) {
  if (value === null || value === undefined) {
    return false;
  }

  if (typeof value === "string") {
    return value.trim().length > 0;
  } else if (value instanceof Array) {
    return value.length > 0;
  } else {
    return true;
  }
}

export { isBlank, isPresent };
