const User = require("../models/users");
const Comment = require("../models/comment");

// later, I will make this with socket.io
exports.postCommentProcess = async (req, res, next) => {
  try {
    console.log("Comment Arrived!", req.body);
    const postId = req.body.postId;
    const comment = req.body.comment;
    const userId = req.body.userId;
    let author;
    await User.findByPk(userId).then((data) => {
      author = data.dataValues.name;
    });
    Comment.create({
      content: comment,
      author: author,
      userId: userId,
      postId: postId,
    });
    res.json({ success: true });
  } catch {
    res.json({ success: false });
  }
};
exports.getCommentProcess = async (req, res, next) => {
  try {
    console.log("Comment Sending!", req.body);
    const postId = req.body.postId;
    let commentList = [];
    await Comment.findAll({ where: { postId: postId } }).then((data) => {
      data.map((comment) => {
        commentList.push(comment.dataValues);
      });
      res.json(commentList);
    });
  } catch {
    res.json({ success: false });
  }
};
exports.deleteCommentProcess = async (req, res, next) => {
  const postId = req.params.postId;
  const commentId = req.params.commentId;
  const userId = req.session.userId;

  await User.findOne({ commentId: commentId })
    .then((user) => {
      if (userId === user.id) {
        Comment.destroy({
          where: { id: commentId },
        });
      }
    })
    .catch((err) => {
      console.log(err);
    });
  res.redirect(`/post/postId=${postId}`);
};
