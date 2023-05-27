const Post = require("../models/post");
const Comment = require("../models/comment");

// const POSTS_PER_PAGE = 3;

exports.getAllPosts = async (req, res, next) => {
  const getPosts = await Post.findAll({});
  const postList = await getPosts.map((post) => {
    return post.dataValues;
  });

  let isPostExisted = true;
  if (postList.length === 0) isPostExisted = false;
  else isPostExisted = true;

  res.json(postList);
};

exports.writePost = (req, res, next) => {
  const author = req.session.userName;
  res.render("writePost", { pageTitle: "Write Post", author: author });
};
exports.updatePost = async (req, res, next) => {
  const postId = req.params.postId;
  let postData;
  await Post.findByPk(postId).then((res) => {
    postData = res.dataValues;
  });
  // res.render("updatePost", {
  //   pageTitle: "Update Post",
  //   postId: postData.id,
  //   authorName: postData.author,
  //   postTitle: postData.title,
  //   postContent: postData.content,
  // });
};
exports.postProcess = async (req, res, next) => {
  try {
    const author = req.body.author;
    const title = req.body.title;
    const content = req.body.content;
    const userId = req.body.userId;
    // const filePath = req.file ? req.file.path : undefined;
    await Post.create({
      title: title,
      content: content,
      author: author,
      userId: userId,
      file_path: null,
    });
    return res.json({ success: true });
  } catch {
    return res.json({ success: false });
  }
  // res.redirect("/posts/postPage=1");
};
exports.updatePostProcess = async (req, res, next) => {
  const author = req.body.authorName;
  const title = req.body.postTitle;
  const content = req.body.postContent;
  const id = req.params.postId;
  const userId = req.session.userId;
  await Post.update(
    {
      author: author,
      content: content,
      title: title,
      userId: userId,
    },
    { where: { id: id } }
  );
  // res.redirect(`/post/postId=${id}`);
};
exports.deletePostProcess = async (req, res, next) => {
  const deletedPostId = req.params.postId;
  console.log(deletedPostId);
  await Post.destroy({
    where: { id: deletedPostId },
  });
  res.redirect("/posts");
};

// exports.downloadPostFile = async (req, res, next) => {
// };
