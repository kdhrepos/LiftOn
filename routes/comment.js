const express = require("express");

const router = express.Router();

const commentController = require("../controllers/comment");
const isAuthed = require("../middleware/isAuthed");

router.use("/get-comment-process", commentController.getCommentProcess);
router.use("/post-comment-process", commentController.postCommentProcess);

router.use(
  "/delete-comment-process/postId=:postId&commentId=:commentId",
  isAuthed,
  commentController.deleteCommentProcess
);

module.exports = router;
