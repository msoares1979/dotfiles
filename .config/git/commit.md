type: short description

Long description, context and additional information.

[optional footer(s)]
#
# https://www.conventionalcommits.org/en/v1.0.0/#specification
#
# Allowed types:
#
# - fix
#   a commit of the type fix patches a bug in your codebase (this correlates
#   with PATCH in Semantic Versioning).
#
# - feature name
#   a commit of the type feat introduces a new feature to the codebase (this
#   correlates with MINOR in Semantic Versioning).
#
# - build, chore, ci, docs, style, refactor, perf, test, and others.
#
# A longer commit *BODY* MAY be provided after the short description, with
# additional contextual information about the code changes. The body MUST begin
# one blank line after the description.
#
# BREAKING CHANGE: a commit that has a footer BREAKING CHANGE:, or appends a !
# after the type/scope, introduces a breaking API change (correlating with MAJOR
# in Semantic Versioning). A BREAKING CHANGE can be part of commits of any type.
# 
# footers other than BREAKING CHANGE: <description> may be provided and follow a
# convention similar to git trailer format.
# 
# Examples
# ------------------------------------------------------------------------------
# Commit message with description and breaking change footer
# feat: allow provided config object to extend other configs
# 
# BREAKING CHANGE: `extends` key in config file is now used for extending other
# config files
#
# ------------------------------------------------------------------------------
# Commit message with ! to draw attention to breaking change
# feat!: send an email to the customer when a product is shipped
#
# ------------------------------------------------------------------------------
# Commit message with scope and ! to draw attention to breaking change
# feat(api)!: send an email to the customer when a product is shipped
#
# ------------------------------------------------------------------------------
# Commit message with both ! and BREAKING CHANGE footer
# chore!: drop support for Node 6
# 
# BREAKING CHANGE: use JavaScript features not available in Node 6.
#
# ------------------------------------------------------------------------------
# Commit message with no body
# docs: correct spelling of CHANGELOG
#
# ------------------------------------------------------------------------------
# Commit message with scope
# feat(lang): add Polish language
#
# ------------------------------------------------------------------------------
# Commit message with multi-paragraph body and multiple footers
# fix: prevent racing of requests
#
# Introduce a request id and a reference to latest request. Dismiss
# incoming responses other than from latest request.
# 
# Remove timeouts which were used to mitigate the racing issue but are
# obsolete now.
# 
# Reviewed-by: Z
# Refs: #123
