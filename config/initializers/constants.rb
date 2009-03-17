EMAIL_REG = /\A(([^\_@\s`~!\#\$%^&<>,:;'"+=|\\?\/\[\]\{\}*\(\)][^@\s`~!\#\$%^&<>,:;'"+=|\\?\/\[\]\{\}*\(\)]+)@([^,:;'"@\s\_`~!#\$%^&*\/+=?\(\)\\\[\]\{\}\-])*((?:[a-z0-9]+\.)+[a-z]{2,6}))\Z/i
FEEDS_DESCRIPTION_OPTIONS = ["Full", 'Short']
ROLES_NAMES = ["admin", "editor"]
PASSWORD = "changeme"
LOGIN = "admin"
EMAIL = "email@email.com"

#Exception notifier configuration
ExceptionNotifier.exception_recipients = %w(your@email.com)
ExceptionNotifier.sender_address = %("DomainName" <admin@domain.com>)
ExceptionNotifier.email_prefix = "[Application Error - DomainName]"