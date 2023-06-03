const express = require("express");
const router = express.Router();
const commentController = require("../controllers/comment");

router.use("/get-comment-process", commentController.getPostComments);
router.use("/post-comment-process", commentController.postComment);
router.use("/get-user-comment", commentController.getUserComments);
router.use("/delete-comment", commentController.deleteComment);

module.exports = router;
