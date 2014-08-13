
require 'mail'
require 'yajl'

class Email
  FIELDS_TO_EXPORT = [
    'subject', 'from', 'to'
  ]

  attr_reader :uid

  def initialize(uid, raw_mail)
    @uid = uid
    @mail = Mail.new raw_mail
  end

  def to_json
    json = {}

    FIELDS_TO_EXPORT.each { |f| json[f] = @mail[f] }

    Yajl::Encoder.encode(json)
  end

  def to_s
    # "#{@mail.from.first} --> #{@mail.to.join ', '}: #{@mail.subject}"
    @mail.to_s
  end
end

# Message formats
#
# 1st
# ===
#
# {
#   'headers': [
#     'header1': 'value1'
#   ],
#   'subject': '',
#   'encoding': '',
#   'from': { 'name': '', 'email': '' },
#   'to': [
#     { 'name': '', 'email': '' },
#     { 'name': '', 'email': '' }
#   ],
#   'cc': [
#     { 'name': '', 'email': '' },
#     { 'name': '', 'email': '' }
#   ],
#   'bcc': [
#     { 'name': '', 'email': '' },
#     { 'name': '', 'email': '' }
#   ],
#   'attachements': [
#     { 'filename': '', 'content_type': '', 'content': '' }
#   ],
#   'body': ''
# }
#
# 
# 2nd
# ===
#
# conversationId: (String) The conversation id of the message
# mailboxId: (String) The mailbox id of the mailbox the message is in.
# rawUrl: (String) A url to download the original RFC8222 message from.
# isUnread: (Boolean) Is the message unread?
# isFlagged: (Boolean) Is the message flagged/starred?
# isAnswered: (Boolean) Has the message been replied to?
# isDraft: (Boolean) Is the message a draft?
# hasAttachment: (Boolean) Does the message have any attachments?
# labels: (Array<String>) An array of labels/keywords applied to the message.
# from: (Array|null) An array of name/email objects (see below) representing the parsed From header, if present (otherwise null). Note, although normally of length 1, technically this could be of length 0 or 2+.
# to: (Array|null) An array of name/email objects (see below) representing the parsed To header, if present (otherwise null).
# cc: (Array|null) An array of name/email objects (see below) representing the parsed CC header, if present (otherwise null).
# bcc: (Array|null) An array of name/email objects (see below) representing the parsed BCC header, if present (otherwise null).
# replyTo: (Array|null) An array of name/email objects (see below) representing the parsed Reply-To header, if present (otherwise null).
# subject: (String) The subject of the message
# date: (Date) The date the message was sent (or saved, if a draft).
# size: (Number) The size in bytes of the whole message.
# preview: (String) The first 120 characters of a plain text version of the body. This is intended to be shown as a preview line on a mailbox listing, and the server may choose to skip quoted sections or salutations to return a more useful preview.
# textBody: (String|null) Returns the plain text body part for the message if present
# htmlBody: (String|null) Returns the html body part for the message if present
# body: This is special in that there’s no property called just “body” on the object returned. Instead, if there is an HTML part, it will return an “htmlBody” response, but if there is only a plain part, it will return a “textBody” response.
# attachments: (Array|null) An array of attachment objects (see below) describing all the attachments to the message.
# attachedMessages: (Object|null) Returns an object mapping attachment id (as found in the attachments response) to a message object with all the same properties requested for this message, for every attached message (flag properties are ignored).
#
# An attachment object looks like this:
# {
#   id: String,
#   url: String,  // A url to download the attachment
#                 // (requires same authentication mechanism)
#   type: String, // The MIME type of the attachment.
#   name: String, // The full file name, e.g. 'myworddocument.doc'
#   size: Number, // Size in bytes
#   isInline: Boolean, // True if the attachment is referenced by a cid link
#                      // from within the HTML body.
#   width: Number, // (optional) Width (in px) of image.
#   height: Number // (optional) Height (in px) of image.
# }