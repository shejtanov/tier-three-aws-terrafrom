resource "aws_iam_user" "admin_user" {
  name = "marko.sejat"
  tags = {
    email = "marko.sejat@qcerris.com"
  }
}

resource "aws_iam_user_policy_attachment" "admin_user_policy" {
  user       = aws_iam_user.admin_user.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}