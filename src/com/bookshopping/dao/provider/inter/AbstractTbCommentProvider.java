package com.bookshopping.dao.provider.inter;

import com.bookshopping.domain.TbComment;
import com.bookshopping.exception.CommentNotFoundException;

public interface AbstractTbCommentProvider {
	public void addComment(TbComment comment);
	TbComment getCommentByCommentId(Integer commentId)
            throws CommentNotFoundException;
}
