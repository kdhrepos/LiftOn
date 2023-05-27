const express = require("express");

const router = express.Router();

const postController = require("../controllers/post");
const isAuthed = require("../middleware/isAuthed");

router.get("/posts", postController.getAllPosts);

router.get("/write-post", isAuthed, postController.writePost);

router.get("/write-post/postId=:postId", isAuthed, postController.updatePost);

router.post("/update-process/postId=:postId", postController.updatePostProcess);

router.post("/post-process", postController.postProcess);

router.post(
  "/delete-post-process/postId=:postId",
  isAuthed,
  postController.deletePostProcess
);

module.exports = router;
