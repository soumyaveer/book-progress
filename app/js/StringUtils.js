export default class StringUtils {
  static isBlank(value) {
    return !this.isPresent(value);
  }

  static isPresent(value) {
    value = "" + value;
    return value && value.trim().length > 0;
  }
}
