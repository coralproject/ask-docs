# Ask


## Why use Ask?

Journalists often use forms to invite suggestions, tips, or ideas for their stories. Ask builds on existing tools in a number of ways:

Better for journalism: 
* **Ask encourages more people to respond to your form.** The Gallery feature makes it easy to showcase the best responses, applying the psychological principle of ['Social Proof'](http://www.obanalytics.com/images/Cialdini_2001.pdf) to journalistic practice.
* **Ask allows journalists to tag and search responses to follow up.**<br/>
* **Ask maintains the text of the original submission.** Editors can edit submissions for length, clarity, grammar while maintaining the reader's original response.<br/>
* **Data visualizations based on submissions are easy to build using the API.** <br/><br/>

Improved design and accessibility:
* **Ask forms are fully compatible across devices.**
* **Ask form designs are fully customizable.** By utilizing a script tag, Ask automatically matches your site design.
* **Ask forms are fully accessible.**<br/><br/>

More efficient response management:
* **Ask contains full Slack integration**
* **Ask makes it possible to track respondees across forms.**
* **The Ask submissions manager makes it easy to filter out abusive or meaningless responses, and to share the most helpful contributions.**<br/><br/>

Stronger user privacy: 
* **Ask doesn't share user data with anyone.** <br/><br/>

Ask is also open source and fully customizable. You own your install of Ask, and can optimize it for your needs.

## Creating A Form

Surveys and forms are productive tools to engage your audience in your work. Before you make a form, you need to think about what you’re asking and how you're asking it. [This article on our blog](https://blog.coralproject.net/forms-audience-engagement/) can help you write more effective form text. 

### Getting Started

![Form-builder](https://raw.githubusercontent.com/losowsky/docs/master/docs_dir/images/formbuilder1.gif) 

#### Naming Your Form 

To get started, give your form a name. This name is for internal use, in order to identify it later. We recommend using unique descriptive form names (eg. 'Camera Factory Closure Form').

#### Creating a Headline and Description

With each Ask form, you can create a headline and subheadline that will be displayed to your readers at the top of the form. The headline describes what the form is for, while the subheadline can include instructions or provide an additional description. *This step is optional.*

#### Saving and Previewing Your Form

As you begin creating your form, we encourage you to save early and save often by clicking "Save" (we will be adding auto-save in the future). Also, you can preview your form by clicking the "Preview" button.

### Building Your Form

#### Adding Questions

![Form-builder](https://raw.githubusercontent.com/losowsky/docs/master/docs_dir/images/formbuilder2.gif) 

To add a question, click on a question type located in the left panel or drag and drop that question into the form builder. You can rearrange questions by dragging a question by its number and dropping it into the correct location, or by using the up and down action buttons on a question.

#### Understanding Question Types
<p align="center">
<img src="https://raw.githubusercontent.com/losowsky/docs/ask-user-guide/docs_dir/images/questiontypes.png" width="400"> 
</p>
Ask offers 7 question types to choose from, giving your readers a variety of ways to answer and share their stories.
- **Short Answer**: Ideal for answers such as a name, city, favorite dog breed, etc. This will give your readers a single-line text input area for their response. You have the option to set a character limit (or minimum).
- **Long Answer**: Use this question type for more open-ended questions that may result in reponses of a few sentences or paragraphs. You can also enable minimum and maximum character limits for this question type.
- **Numbers**: Use this when you are asking for an answer that is a numerical value. (If you are looking for readers to submit their phone numbers for follow up, we have a separate question type for that!) You have the option to set a value minimum or maximum.
- **Multiple Choice**: Give your readers a few answers to choose from. You can also enable an "other" option to let them provide an answer in a text field.
- **Email**: Looking to follow up with some of your readers? Ask for their email address with this field. This field is designated as ["Reader Info"]() by default.
- **Date**: You can use this field to verify an age minimum. Readers will be able to choose the date with a calendar picker or by entering the date manually. 
- **Phone Number**: Make it easy to follow up by phone. This field is designated as ["Reader Info"]() by default.

#### Creating Your Question

![Form-builder](https://raw.githubusercontent.com/losowsky/docs/ask-user-guide/docs_dir/images/createquestion.png)

After you have selected your question type and added it to the form builder you can begin writing your question. There are two fields you may complete:

- **Write your question:** After you add a question type from the left, you can type your question for your readers in the first text field. 
- **Instructions:** You can use this field to provide an additional explanation for the question or provide example responses to help give your readers an idea of what type of answer you are looking for. *This is optional*

#### Question Options

After you have written your question you are presented with additional settings for your question. While some may be question-type specific, such as creating character or value limits (see information on Question Types above), every question will have the following options:

- **Required:** If a question is very important you may want to make it required. You can make any question required by clicking the checkbox in the expanded question.

- **Reader Info:** One key feature of Ask is the ability to designate certain questions as personal information, connecting contributions to your users’ existing on-site identity. Enabling a question as "Reader Info" also makes it easier for you to connect a response to its author when [creating your gallery](). Questions that have been selected as Reader Info will display the 'icon needed' icon when collapsed.

Ask also allows you to **ADD AGGREGATION** totals to the API.

Selecting this option in certain question types adds totals to the [API](https://medium.freecodecamp.com/what-is-an-api-in-english-please-b880a3214a82#.cxbmkltik) of your Ask form, which you can then use to create visualizations of the data. If you'd like more information about this, [get in touch.](https://coralproject.net/contact.html)


#### Reordering, Duplicating, and Deleting Questions

![Form-builder](https://raw.githubusercontent.com/losowsky/docs/master/docs_dir/images/formbuilder3.gif) 

**Reording** a question can be accomplished by either dragging and dropping a question by its number to the correct position, or by using the up and down arrows on the question's action bar.

You may also **delete** a question by clicking the <img src="https://raw.githubusercontent.com/losowsky/docs/ask-user-guide/docs_dir/images/trash.png" width="30" align="middle"> icon or **duplicate** a question by clicking the <img src="https://raw.githubusercontent.com/losowsky/docs/ask-user-guide/docs_dir/images/duplicate.png" width="30" align="middle"> icon.

#### Saying thank you

![Form-builder](https://raw.githubusercontent.com/losowsky/docs/ask-user-guide/docs_dir/images/thankyoumessage.png)

After readers submit a response, they will receive a confirmation message thanking them for their time. You can easily customize this meesage to fit with your organizations style and voice by editing the message in the Thank You Message text area.

#### Linking your privacy policy

![Form-builder](https://raw.githubusercontent.com/losowsky/docs/ask-user-guide/docs_dir/images/privacypolicy.png)

Using Markdown, you can add a link to your organizations privacy policy. This link will prominantly appear above the "Submit" button on the form. 

> *Not familiar with Markdown?* You can use this format to add a link: 
> `[link text](http://webaddresshere.com)`

### Publishing Your Form

![Form-builder](https://raw.githubusercontent.com/losowsky/docs/ask-user-guide/docs_dir/images/publish.gif)

Ask offers flexibility as to how you can publish and share the forms you create. By clicking the "Publish Options" button you can choose which option is best for you.

#### Embed Options

One method you may choose to for publishing is embedding the form into an article on your CMS.

- With iFrame: This code will work across more sites as soon as it is pasted into your CMS. However, it will require the help of a developer to customize the styles.
- Without iFrame: By pasting this code into your CMS, this javascript tag with adopt the styles of your website. Be sure to double check that your site allows this.

#### Standalone form

When your form is published it also is published to its own page that can be linked to or shared.

### Begin Collecting Submission
To begin collecting submissions from your readers you will need to set your form to "Live." By default,forms are set to "Closed." 

![Form-builder](https://raw.githubusercontent.com/losowsky/docs/ask-user-guide/docs_dir/images/live-close-form.gif)

#### Setting Form Status
You can change the status of your form in two ways: 
- **Form Status Menu:** This menu, located in the upper right corner of ask, makes it easy to change form status regardless of what screen you are on.
- **Publish Options:** Quickly change your form status as you are retrieving your embed codes or form links.

#### Closed Form Message

Ask provides you with a default message that is displayed to readers when your form is closed. To customize the message simply make sure your form is set to closed and then change the message in the text area that appears.

## Managing Submissions

![Form-builder](https://raw.githubusercontent.com/losowsky/docs/ask-user-guide/docs_dir/images/submissionmanager.png)

### Navigating Your Submissions

After you form has collected a number of submission you can review them by clicking on the form name from the View Forms page. From there you will be brought to Ask's submission manager. 
<p align="center">
<img src="https://raw.githubusercontent.com/losowsky/docs/ask-user-guide/docs_dir/images/submissionnavigator.png" width="300">
</p>
By default, Ask's submission navigator will show you all submissions you have received with the newest first and displaying that newest submission in the reading area. From the navigator you can:

- **sort** your submissions by oldest or newest first;
- **filter** to focus on items that have been bookmarked or remove items that have been flagged; and, 
- **search** your submissions for specific words and phrases.

### Reading and Working With Submissions

![Form-builder](https://raw.githubusercontent.com/losowsky/docs/ask-user-guide/docs_dir/images/submission.png)

#### The Reader Info Area

Any questions you have designated as containing "Reader Info" will be displayed at the top of each submission. This allows you to quickly identify the submission's author, and other important information you may have requested -- including their contact info if you need to follow up.

#### Bookmarking

If you receive a submission that you'd like to come back to or would like to have another person take a look at you can **bookmark** the submission. You can quickly return to this item by filtering the submission navigator to "Bookmarked" items.

#### Flagging

Similarly, if you have received a submission that has offensive or harassing content you may choose to **flag** this item. This item then can be reviewed by a community manager by filtering to "Flagged" items in the submission navigator, or you can avoid continuing to see flagged submissions by filtering to "Flagged Submissions Hidden". 

#### Adding Tags

![Form-builder](https://raw.githubusercontent.com/losowsky/docs/ask-user-guide/docs_dir/images/tagging.gif)

You can create a tag and add it to a submission to help you stay organized and add short notes.
- To **add** a tag simply type a short word or phrase in the tag text area and press `enter` to add it.
- You can **remove** a tag by clicking the "X" next to the tag you would like to remove.

#### Sending to Gallery

![Form-builder](https://raw.githubusercontent.com/losowsky/docs/ask-user-guide/docs_dir/images/sendtogallery.gif)

One key feature of Ask is the ability to quickly create publishable gallaries of selected responses from a form. By clicking "Send to Gallery" on a selected response the response along with its Reader Info is sent to the form's gallary manager for editing and publishing.

### Downloading the Submissions <img src="https://raw.githubusercontent.com/losowsky/docs/ask-user-guide/docs_dir/images/downloadcsv.png" width="30" align="middle">

You can download a CSV of the submissions you form has received by clicking the `icon needed` icon.

## Creating and Publishing Gallaries

`introductory material here`

### Selecting and Displaying Reader Information

Ask makes it easy to attribute gallery submissions to their correct authors without any copy and pasting. 
- **Placement**: Choose if you would like the reader information to appear above or below the submission
- **Reader Info Fields**: Select which Reader Info fields you would like to appear alongside each submissions.
- **Preview**: To see how this will be displayed simply press the Preview button. This will also save your gallery.

### Save Early and Often

As with the Form Builder, we recommend you save changes to your gallery early and often. You can save your changes by clicking the "Save" button. 

### Editing Responses

There may be times when you will need to make edits to submissions for length, style, etc. Ask makes it easy to do this while also still preserving the original response. To get started click the `icon needed` button on the submission you wish to edit.

A submission editor will appear with the original on the left along with the reader information you had selected to appear in your gallery. The right side of the editor allows you to make your changes both to the submission and the reader information

If you need to **start over** with your changes click **"Reset Changes"** to undo all your changes and go back to using the original.

Once you have completed making your changes click **Save Edits** and your changes as well as the whole gallery will be saved.

###  Rearranging and Deleting Responses

You can change the order of the responses in your gallery by clicking the `icon needed` and `icon needed` buttons.

To remove a response from your gallery simply click the `icon needed` button.

###  Publishing Your Gallery

Ask offers flexibility as to how you can publish and share the gallaries you've created. By clicking the "Publish Options" button you can choose which option is best for you.

#### Embed Options

One method you may choose to publish your gallery is embedding the gallery into an article on your CMS.

- With iFrame: This code will work across more sites as soon as it is pasted into your CMS. However, it will require the help of a developer to customize the styles.
- Without iFrame: By pasting this code into your CMS, this javascript tag with adopt the styles of your website. Be sure to double check that your site allows this.

####Standalone Gallery

When you publish your gallery, it creates a standalone webpage that can be linked to or shared.
