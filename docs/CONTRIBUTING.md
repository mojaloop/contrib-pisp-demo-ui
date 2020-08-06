# Contribution Guide 

## Adding New Features to Mojapay

This is a general list of steps one can follow to implement a new feature in mojapay. However if the feature doesn't require the use of persistence, all steps which refer to repository or firestore can be skipped.

1. Start at the lowermost layer. Understand what new models are needed to make this feature.
2. If you need persistence, design the schema for the new models. Create new collections in firebase based on this schema.
3. Create your model classes and use JsonSerializer to generate the code for making models out of json objects. Add validation logic if any. Try to use dart's strong typing system for validation.
4. Write the rough interface for your repository implementation.
5. Lay out the ui for your feature.
6. Make the ephemeral controller for your ui page to hold business logic.
7. Identify any app controllers if needed and build them.
8. By this point you'll be certain about the interface you'll need in your repository. Make a concrete implementation of the interface you created earlier and fill in the methods to CRUD the model from firestore.
9. Link your ui to your controllers and your controllers to your repositories.
10. See if the feature works as you wanted.
11. A stub repository might help someone later if they don't really want to talk to firebase during development. Build it if needed. Implement the same interface you implemented for the concrete repository implementation.
12. Check if your classes follow the architecture as described in the architecture section. Refactor if necessary.
13. Write unit tests for your business logic.
14. Write widget tests for your ui components.
15. Check if code coverage meets standard. Steps to check coverage for flutter tests are listed [here](https://stackoverflow.com/questions/50789578/how-can-the-code-coverage-data-from-flutter-tests-be-displayed).
16. Submit for review :)
