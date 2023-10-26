/** Convert the object's keys from snake_case to camelCase
 * https://stackoverflow.com/a/75927783/13796309
*/
export const paramsToCamelCase = (obj: unknown): unknown => {
	// TODO: make typesafe as a template function
	if (Array.isArray(obj)) {
		return obj.map((el) => paramsToCamelCase(el));
	} else if (typeof obj === 'function' || obj !== Object(obj)) {
		return obj;
	}
	return Object.fromEntries(
		Object.entries(obj as Record<string, unknown>)
		.map(([key, value]: [string, unknown]) => [
			key.replace(/([-_][a-z])/gi, c => c.toUpperCase().replace(/[-_]/g, '')),
			paramsToCamelCase(value),
		]),
	);
};
