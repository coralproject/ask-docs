# Documentation style guide

The key thing to remember when writing documentation is to be extremely explicit and detailed. Do not assume knowledge!

### Writing style

* When in doubt about a grammatical or syntactical point, refer to the [Associated Press's (AP) Style Guide](http://en.wikipedia.org/wiki/AP_Stylebook).
* Though we value good style, please don’t get too hung up on using correct style. We’d rather have you submit good information that doesn’t conform to the guide than no information at all.
* In general, try to write simple, declarative prose. We prefer short, single-clause sentences and brief three-to-five sentence paragraphs. Try to choose vocabulary that is straightforward and precise.
* **Pronouns**:
    * Use gender-neutral pronouns (they/their/them) rather than "he or she".
    * First and second person pronouns are fine. Always use “we” to refer to Coral and “you” to refer to the user.
* Avoid excessive use of "i.e.".
* Section headers and page headers should follow sentence case formatting (first word capitalized, following words uncapitalized) rather than title case (each word in the header capitalized).
* Whenever possible, include a section at the beginning of the page that describes what is contained within that page (with hyperlinks to the relevant sections). Sure, usually this will also appear on the Table of Contents in the side navigation section, but it's also useful to have it displayed within the text itself.

### Do not assume knowledge

* Don't be afraid to explain something that might seem very basic or self-explanatory to you; it may not be so basic to someone else.
* Whenever possible, include an actual, specific instruction and (if required) command.
    * Bad: "Clone the repository to your machine."
    * Good: "Clone the docs repository to your local machine, using the command `git clone https://github.com/coralproject/docs.git`"
* If there are command line instructions involved, include the precise command line instruction. Instructions that users can copy/paste into the command line are great!
* Show "expected results" wherever possible. If a command line instruction should return a certain result, show that expected result. If there is a URL you can visit to test whether or not something is working, provide that URL as a link.
* If there are variables to configure, explicitly state the purpose of the variables. This should be explained in a comment in the configuration file, but you should also provide an explanation in your instructions.
* Do not merely explain HOW to do something, but also, whenever possible, WHY you are doing it in that way. This makes it easier for users to troubleshoot issues.

### Third-party components

Is there a third-party component the user needs to set up (for instance, MongoDB)?

* You don't have to include all setup instructions, but do link to the setup instructions on the website of the third-party app in question (hopefully the third-party app is well-documented; if not, you may have to fill in the gaps).
* Be sure to detail any specific instructions they will need to integrate this third-party component into the system.
* Currently, much of this "third party setup" information resides in the "Developer Setup" document. This reduces duplication if there is a component that needs to be set up for multiple items.

### Writing installation instructions

* Be sure to include _every single step_.
* Include screenshots when it makes sense to do so.
* If there are command line instructions, include the exact instruction in a code block so that users can copy/paste.

### Writing API documentation

When documenting a REST-style API, such as the [Pillar API](../../pillar/api), there are certain pieces of information to include. The [Pillar API documentation](../../pillar/api) is a useful template.

* Create an initial table that lists endpoints, which contains:
    * The endpoint URL.
    * The HTTP verb for that endpoint (GET, POST).
    * The basic functionality description for that endpoint. Make this into a targeted link that jumps to the full description for that endpoint.
* Create a full description for each endpoint. You can see the [Get Users](../../pillar/api/#get-users) Pillar endpoint for an example). Each description should include:
    * The parameters for the endpoint (include the parameter name, whether it is required or optional, the type, and the description).
    * An example call.
    * The response for the example call (whether that is a JSON object, or simply a status response).

### User Guide documentation

When documenting [User Guides](../user_guide), it is important to remember that the people reading them may not have in-depth technical knowledge. Keep your audience in mind.

### Writing User Guide tutorials

* Tutorials take the reader by the hand through a series of steps to create or achieve something.
* Tutorials should be _results oriented_: by the end of the tutorial, the user will have achieved something.
* The important thing in a tutorial is to help the reader achieve something useful, preferably as early as possible, in order to give them confidence.
* Explain the nature of the problem we’re solving, so that the reader understands what we’re trying to achieve. Don’t feel that you need to begin with explanations of how things work - what matters is what the reader does, not what you explain. It can be helpful to refer back to what you’ve done and explain afterwards.

#### Structure
* The tutorials for each product are all contained on a single page. View the [Trust tutorial page](../trust_tutorials) for an example.
* At the top of the tutorial page is a list of the tutorials available on that page. Each has a description in the form of a user story (i.e., "I would like to...").
* A tutorial is not a general overview of the functionality of the product, but a specific how-to that fulfills a user story. The general overview of the product's functionality belows on the Overview page for that product.
* The goal of a tutorial is to walk the user through a scenario (such as "identify trolls within the Business section"), that they can then tailor to their own needs ("identify trolls within the Health section").

#### Format
* Tutorials follow a numbered step-by-step format.
    * You do not have to use the Markdown "numbered list" formatting (in which the numbered list is written `1.` for auto-formatting). In fact, it is probably better if you don't: things get a bit wonky when you start inserting images in between the numbered steps.

#### Images
* Each step (or very nearly each step) should have an image illustrating that step, and potentially showing the location of a button or field. If you do not have an image illustrating that step, you should have a pretty good reason not to have it.

## Terminology

* Git is capitalized.
* GitHub capitalizes both the G and the H.

Here are some commonly used terms:

#### Software specific
* **Coral**: Refers to the Coral product, which includes the three components Trust, Ask, and Talk.
* **Coral Project**: Refers to the project of building and crafting the Coral product.
* **Coral Ecosystem**: Refers to all of the pieces that make up Coral from a more technical or development perspective: includes all the technical components such as Pillar, Sponge, and Cay.

#### Users

* **Developers**: Refers to the technical users of Coral who will be installing Coral and working with the backend. Also refers to open-source contributors.
* **End Users**: Refers to anyone who will be interacting with the Coral front end. Examples of end users are publishers, moderators, journalists, and readers.

## Markup specific style

### Graphics

When you need to add a graphic, try to make the file-size as small as possible. If you need help reducing file-size of a high-resolution image, feel free to contact us for help. Usually, graphics should go in the same directory as the .md file that references them, or in a subdirectory for images if one already exists.

The preferred file format for graphics is PNG, but GIF and JPG are also acceptable.

If you are referring to a specific part of the UI in an image, use call-outs (circles and arrows or lines) to highlight what you’re referring to. Line width for call-outs should not exceed five pixels. The preferred color for call-outs is red.

Be sure to include descriptive alt-text for the graphic. This greatly helps users with accessibility issues.

* The color used for highlighting rectangles and arrows is Hex Color #00C7FC. This offers a good contrast with the Coral theme colors.
* When taking screenshots to use as illustrative images, include a decent amount of "surrounding area" to provide context and geography for the feature you're discussing. A screenshot of a button, for instance, isn't very useful when you can't figure out where the button is located.


### Commands and code blocks

* Enclose commands and code blocks in triple-tick blocks (```). Yes, Markdown supports indentation to delineate code blocks, but the triple-ticks make things more explicit.
* Be sure you are using universal command line commands, not shortcuts available in some shells.
    * Good: `mkdir exampledirectory`
    * Bad: `md exampledirectory`

### Headers
* When adding headlines and section dividers, keep in mind that the Table of Contents displayed in the side navigation bar to the left is only two levels deep. So, H1 (#) and H2 (##) text will show up in the Table of Contents. H3 (###) and below will not.
* To avoid making the Table of Contents too cluttered, try to only use H2 (##) for key large sections.
