# **Mobile Software Engineer**

> Thank you for your interest in being part of the startup that is transforming the industry in Brazil. "Not knowing is no reason not to do it, on the contrary. It is the first step to expand your skills" - Bruno Felix, Co-Founder of TRACTIAN.
>

### Context

Assets are essential to the operation of the industry, it can include everything from manufacturing equipment to transportation vehicles to power generation systems. Proper management and maintenance is crucial to ensure that they continue to operate efficiently and effectively. A practical way to visualize the hierarchy of assets is through a tree structure.

### **Challenge**

<aside>
📌 **Build an Tree View Application that shows companies Assets.**

</aside>

The tree is basically composed with components, assets and locations.

**Components**

- Components are the parts that constitute an asset.
- Components are typically associated with an asset, but the customer **may** want to add components without an asset as a parent **or** with a location as a parent
- Components typically include **vibration** or **energy** sensors, and they have a **operating** or **alert** status
- On the tree, components are represented by this icon:

**Assets/Sub-Assets**

- Assets have a set of components
- Some assets are very large, like a conveyor belt and they **may** contain N sub-assets.
- Assets are typically associated with a location, but the customer **may** want to add assets without specifying a location as a parent.
- You can know that an item is a **asset**, if they have another assets or components as children.
- On the tree, assets are represented by this icon:


**Locations/Sub Locations**

- Locations represent the places where the assets are located. For very large locations, the customer may want to split them to keep their hierarchy more organized. Therefore, locations may contain N sub-locations.
- On the tree, locations are represented by this icon:

In summary, a tree may like look this:

```dart
- Root
  |
  └── Location A
  |     |
  |     ├── Asset 1
  |     |     ├── Component A1
  |     |     ├── Component A2
  |     |
  |     ├── Asset 2
  |           ├── Component B1
  |           ├── Component B2
  |
  ├── Location B
  |     ├── Location C
	| 	  |     |
	|		  |     ├── Asset 3
	|		  |     |     ├── Component C1
	|		  |     |     ├── Component C2
	|		  |     |
	|			|			├── Component D1
  |
  └── Component X
```

## Features

### 1. **Home Page**

- Is the menu for users to navigate between different companies and access  their assets.

### 2. **Asset Page**

- The Asset Tree is the core feature, offering a visual Tree representation of the company's asset hierarchy.
- **Sub-Features:**
    1. **Visualization**
        - Present a dynamic tree structure displaying components, assets, and locations.
    2. **Filters**

       **Text Search**

        - Users can search for specific components/assets/locations within the asset hierarchy.

       **Energy Sensors**

        - Implement a filter to isolate energy sensors within the tree.

       **Critical Sensor Status**

        - Integrate a filter to identify assets with critical sensor status.
    - When the filters are applied, the asset parents **can't** be hidden. The user must know the entire asset path. The items that are not related to the asset path, must be hidden

### Technical Data

- You have a collection of Assets and a collection of Locations, you need to relate both of them to build the Tree

- **Locations Collection**
    - Contains only Locations and sub locations
    - Composed with name, id and a optional parentId

    ```json
    {
            "name": "PRODUCTION AREA - RAW MATERIAL",
            "parentId": null,
            "id": "65674204664c41001e91ecb4"
     }
    ```

    - If the Location has a parentId, it means it is a sub location

    ```json
    {
            "name": "CHARCOAL STORAGE SECTOR",
            "parentId": "65674204664c41001e91ecb4",
            "id": "656a07b3f2d4a1001e2144bf"
        },
    ```

  The visual representation:

    ```json
    - PRODUCTION AREA - RAW MATERIAL
      |
      ├── CHARCOAL STORAGE SECTOR
    ```

- **Assets collection**

  Contains assets, sub assets and components

    - Composed by name, id and a optional locationId, parentId and sensorType
    - If the item has a sensorType, it means it is a component. If it does not have a location or a parentId, it means he is unliked from any asset or location in the tree.

    ```
    {
      "name": "Fan - External",
    	 "parentId": null,
      "sensorType": "energy",
      "status": "operating",
      "locationId": null,
      "id": "656734821f4664001f296973"
    },
    ```

    - If the item has a location and does not have a sensorId, it means he is an asset with a location as parent, from the location collection

    ```json
    {
      "name": "CONVEYOR BELT ASSEMBLY",
      "locationId": "656a07b3f2d4a1001e2144bf",
      "id": "656a07bbf2d4a1001e2144c2"
    },
    ```

    - If the item has a parentId and does not have a sensorId, it means he is an asset with another asset as a parent

    ```
    {
        "name": "MOTOR TC01 COAL UNLOADING AF02",
        "parentId": "656a07bbf2d4a1001e2144c2",
        "id": "656a07c3f2d4a1001e2144c5"
    },
    ```

    - If the item has a sensorType, it means it is a component. If it does have a location or a parentId, it means he has an asset or Location as parent

        ```json
        {
          "name": "MOTOR RT COAL AF01",
          "parentId": "656a07c3f2d4a1001e2144c5",
          "sensorType": "vibration",
          "status": "operating",
          "id": "656a07cdc50ec9001e84167b"
        }
        ```


To summarize, this is the visual representation of this items on the Tree

```json
- ROOT
  |
  ├── PRODUCTION AREA - RAW MATERIAL [Location]
  |     |
  |     ├── CHARCOAL STORAGE SECTOR [Location]
  |     |     |
  |     |     ├── CONVEYOR BELT ASSEMBLY [Asset]
  |     |     |     |
  |     |     |     ├── MOTOR TC01 COAL UNLOADING AF02 [Asset]
	|			|			|			|  |
	|			|			|			|  ├── MOTOR RT COAL AF01 [Component - Vibration]
  |
  ├── Fan - External [Component - Vibration]
```

## Figma

https://www.figma.com/file/IP50SSLkagXsUNWiZj0PjP/%5BCareers%5D-Flutter-Challenge-v2?type=design&node-id=0%3A1&mode=design&t=puUgGuBG9v8leaSQ-1

<aside>
💡 You don't have to exactly match figma's design! Please, be able to abstract well the presented problem and define it yourself what you consider most important and think with the user's head!

</aside>

## Datasets

The datasets represent respective companies in the Figma UI. Each dataset contains information about locations and assets.

### Jaguar Unit

[Jaguar Unit.zip](https://prod-files-secure.s3.us-west-2.amazonaws.com/e7dfe0e0-208b-498d-9031-2a735786c019/3ee8c505-cfd2-4586-a71f-75db07025a0d/Jaguar_Unit.zip)

### Tobias Unit

[Tobias Unit.zip](https://prod-files-secure.s3.us-west-2.amazonaws.com/e7dfe0e0-208b-498d-9031-2a735786c019/1fdfcd9f-14f8-4d42-bba9-6863525e0bd0/Tobias_Unit.zip)

### Apex unit

[Apex Unit.zip](https://prod-files-secure.s3.us-west-2.amazonaws.com/e7dfe0e0-208b-498d-9031-2a735786c019/6e835188-e32b-451b-aab6-28e3bbc387b7/Apex_Unit.zip)

### Extra Rules

You may use libraries for anything you find essential, **except** for the Asset Tree and the UI.

In this challenge, performance and usability count as **bonus** points.

At the end publish your code on GitHub.