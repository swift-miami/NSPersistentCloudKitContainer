Imporant tips when using NSPersistentCloudKitContainer:

1. When initializing your NSPersistentCloudKitContainer (NSPersistentCloudKitContainer(name:)). The 'name' property MUST match the title of your Core Data model (.xcdatamodeld file).

2. You will need to add 'CloudKit & Background Modes' to your project in Targets/Signing & Capabilities to enable CK otherwise the fetching will not work.
