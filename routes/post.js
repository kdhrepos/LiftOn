const express = require("express");
const dirPath = "C:\\Users\\ehdgu\\Desktop\\Dart\\server";
const router = express.Router();
const postController = require("../controllers/post");

router.get("/get-image", (req, res, next) => {
  if (req.query.filePath) {
    const filePath = `${dirPath}\\${req.query.filePath}`;
    console.log("get-image", filePath);
    return res.sendFile(filePath);
  }
  return res.json({ success: true });
});

router.get("/posts", postController.getAllPosts);
router.post("/post-process", postController.postProcess);
router.get("/get-post-by-id", postController.getPostById);
router.get("/get-user-posts", postController.getUserPosts);
router.post("/delete-post", postController.deletePost);

module.exports = router;
