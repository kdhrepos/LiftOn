const User = require("../models/users");
const Comment = require("../models/comment");
const Post = require("../models/post");

exports.postComment = async (req, res, next) => {
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
exports.getPostComments = async (req, res, next) => {
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
exports.getUserComments = async (req, res, next) => {
  try {
    const userId = req.body.userId;
    let commentList = [];

    const comments = await Comment.findAll({
      where: { userId: userId },
      order: [["id", "DESC"]],
    });

    const commentPromises = comments.map(async (comment) => {
      const post = await Post.findByPk(comment.postId);
      const map = { comment: comment.dataValues, post: post.dataValues };
      return map;
    });

    const commentResults = await Promise.all(commentPromises);
    commentList = commentResults.filter((comment) => comment.post !== null);

    res.json(commentList);
  } catch (error) {
    res.json({ success: false });
  }
};
exports.deleteComment = async (req, res, next) => {
  const commentId = req.body.id;
  const userId = req.body.userId;

  await Comment.findByPk(commentId)
    .then(async (comment) => {
      console.log(comment);
      if (userId === comment.dataValues.userId) {
        await Comment.destroy({
          where: { id: commentId },
        });
        const post = await Post.findByPk(comment.dataValues.postId);
        return res.json({ success: true, post: post.dataValues });
      }
      return res.json({ success: false, message: "No Authority" });
    })
    .catch((err) => {
      console.log(err);
      return res.json({ success: false, message: "Error Occurred" });
    });
};
