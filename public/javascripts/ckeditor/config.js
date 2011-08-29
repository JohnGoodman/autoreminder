﻿/*
Copyright (c) 2003-2011, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/

CKEDITOR.editorConfig = function( config )
{
  // Define changes to default configuration here. For example:
  // config.language = 'fr';
  // config.uiColor = '#AADC6E';

  /* Filebrowser routes */
  // The location of an external file browser, that should be launched when "Browse Server" button is pressed.
  config.filebrowserBrowseUrl = "/ckeditor/attachment_files";

  // The location of an external file browser, that should be launched when "Browse Server" button is pressed in the Flash dialog.
  config.filebrowserFlashBrowseUrl = "/ckeditor/attachment_files";

  // The location of a script that handles file uploads in the Flash dialog.
  config.filebrowserFlashUploadUrl = "/ckeditor/attachment_files";

  // The location of an external file browser, that should be launched when "Browse Server" button is pressed in the Link tab of Image dialog.
  config.filebrowserImageBrowseLinkUrl = "/ckeditor/pictures";

  // The location of an external file browser, that should be launched when "Browse Server" button is pressed in the Image dialog.
  config.filebrowserImageBrowseUrl = "/ckeditor/pictures";

  // The location of a script that handles file uploads in the Image dialog.
  config.filebrowserImageUploadUrl = "/ckeditor/pictures";

  // The location of a script that handles file uploads.
  config.filebrowserUploadUrl = "/ckeditor/attachment_files";

  /* Extra plugins */
  // works only with en, ru, uk locales
  config.extraPlugins = "embed,attachment";

  /* Toolbars */
  config.toolbar = 'Easy';

  // config.toolbar_Easy =
  //   [
  //       ['Source','-','Preview'],
  //       ['Cut','Copy','Paste','PasteText','PasteFromWord',],
  //       ['Undo','Redo','-','SelectAll','RemoveFormat'],
  //       ['Styles','Format'], ['Subscript', 'Superscript', 'TextColor'], ['Maximize','-','About'], '/',
  //       ['Bold','Italic','Underline','Strike'], ['NumberedList','BulletedList','-','Outdent','Indent','Blockquote'],
  //       ['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
  //       ['Link','Unlink','Anchor'], ['Image', 'Attachment', 'Flash', 'Embed'],
  //       ['Table','HorizontalRule','Smiley','SpecialChar','PageBreak']
  //   ];

  config.toolbar_Easy =
    [
        ['Source','-','Preview'],
        ['Bold','Italic','Underline','Strike'],
        ['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
        ['NumberedList','BulletedList','-','Outdent','Indent','Blockquote'], '/',
        ['Format'],
        ['Cut','Copy','Paste','PasteText','PasteFromWord',],
        ['Undo','Redo','-','SelectAll','RemoveFormat'],
        ['Link','Unlink','Image'],
        ['HorizontalRule','SpecialChar']
    ];

  config.toolbar_Simple =
    [
        ['Preview'],
        ['Bold','Italic','Underline','Strike'],
        ['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
        ['NumberedList','BulletedList','-','Outdent','Indent','Blockquote'], '/',
        ['Format'],
        ['Cut','Copy','Paste','PasteText','PasteFromWord',],
        ['Undo','Redo','-','SelectAll','RemoveFormat'],
        ['Link','Unlink'],
        ['HorizontalRule','SpecialChar']
    ];
};
