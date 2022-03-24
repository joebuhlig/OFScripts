# Weather Activation

This is one of the more involved scripts I use. It will activate or deactivate a project in OmniFocus based on tomorrow's weather forecast. The project will go from On Hold to Active if it's being activated. It will go from Active to On Hold if deactivated.

# Which File?

You'll find two versions of the script - `.scpt` and `.applescript`. In order to run it from OmniFocus, you'll want to use the `.scpt` version. The `.applescript` format is purely there so you can view the code online.

# JSON Helper

In order for this to work correctly, you'll need [JSON Helper from the Mac App Store](https://itunes.apple.com/us/app/json-helper-for-applescript/id453114608?mt=12). It's free, so no need to worry. This is what will allow the script to navigate the data returned from Weather Underground.

# Weather Underground API

You'll also need a developers API key from Weather Underground. You can [sign up for one here](https://www.weatherapi.com/).

Once you sign up you'll need to change these two lines in the script:

```
set apiKey to "XXXXXXXXXXXXXXXXXXXXXXXXX"
set location to "55555"
```

# Syntax

For the script to work, you need to use either `<Activate></Activate>` or `<Deactivate></Deactivate>` in the notes field for the project. Inside those tags, you can use either `LowTemp` or `HighTemp`. Those are the only two fields supported right now. Here's an example: 

```html
<Activate>
LowTemp: <=38;
</Activate>
```

In this example, the project will go from On Hold to Active if tomorrow's low temperature is less than or equal to 38 degrees.

You can also use both low and high temperature together.

```html
<Activate>
LowTemp: <=38;
HighTemp: >45;
</Activate>
```

Here, the project will go from On Hold to Active if tomorrow's low is less than or equal to 38 degrees AND the high temperature is greater than 45 degrees.

And for really complex situations, you can use both Activate and Deactivate at once:

```html
<Activate>
LowTemp: <=38;
HighTemp: >45;
</Activate
<Deactivate>
LowTemp: >38;
</Deactivate>
```

In this scenario, the project will go from On Hold to Active if tomorrow's low is less than or equal to 38 degrees AND the high is greater than 45. It will go back to On Hold if the low temperature is above 38 degrees.

# Development

I'm certainly open to the submission of Pull Requests to make this better. If you find issues and fix them, please let me know and I'll be happy to update and give you credit.
