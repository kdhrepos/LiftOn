const Post = require("../models/post");
const fs = require("fs");
const dirPath = "C:\\Users\\ehdgu\\Desktop\\Dart\\server";

exports.getAllPosts = async (req, res, next) => {
  const getPosts = await Post.findAll({ order: [["id", "DESC"]] }); //latest first
  const postList = await getPosts.map((post) => {
    return post.dataValues;
  });

  res.json(postList);
};
exports.getUserPosts = async (req, res, next) => {
  const userId = req.body.userId;
  const getPosts = await Post.findAll({
    where: { userId: userId },
    order: [["id", "DESC"]],
  }); //latest first
  const postList = await getPosts.map((post) => {
    return post.dataValues;
  });

  res.json(postList);
};
exports.getPostById = async (req, res, next) => {
  const postId = req.body.postId;
  await Post.findByPk({ postId })
    .then((post) => {
      return res.json({ success: false, post: post.dataValues });
    })
    .catch((err) => {
      console.log(err);
      return res.json({ success: false, message: "Error Occurred" });
    });
};
exports.postProcess = async (req, res, next) => {
  const author = req.body.author;
  const title = req.body.title;
  const content = req.body.content;
  const userId = Number(req.body.userId);

  console.log("Post Upload", req.body, req.file);
  // Handling file
  let fileName;
  if (req.file != null) {
    fileName = req.file.path;
  }
  const filePath = fileName === null ? null : `${fileName}`;
  await Post.create({
    title: title,
    content: content,
    author: author,
    userId: userId,
    file_path: filePath,
  });
  return res.json({ success: true });
};
exports.deletePost = async (req, res, next) => {
  const userId = req.body.userId;
  const postId = req.body.id;

  console.log("Delete Post", postId);

  try {
    const post = await Post.findByPk(postId);

    if (!post) {
      return res.json({ success: false, message: "Post not found" });
    }

    if (post.userId !== userId) {
      return res.json({ success: false, message: "No Authority" });
    }

    const filePath = `${dirPath}\\${post.file_path}`;

    // Delete the post from the database
    await Post.destroy({ where: { id: postId } });

    console.log(filePath);
    // Delete the file from the server
    if (filePath != null) {
      fs.unlink(filePath, (err) => {
        if (err) {
          console.log("Error deleting file:", err);
          return res.json({
            success: false,
            message: "Error occurred while deleting file",
          });
        }
        // File deleted successfully
        return res.json({ success: true, message: "Deleted" });
      });
    } else {
      // File path is null
      return res.json({ success: true, message: "Deleted" });
    }
  } catch (err) {
    console.log(err);
    return res.json({
      success: false,
      message: "Error occurred while deleting post",
    });
  }
};
