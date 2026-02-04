import { useState } from "react"
import CommentItem from "../../../components/admin/moderation/CommentItem"

export default function Comments() {
  const [comments, setComments] = useState([
    { id: 1, user: "Carlos", text: "Muy buena rutina" },
    { id: 2, user: "María", text: "No me funcionó mucho" },
  ])

  const deleteComment = (id) => {
    setComments(comments.filter(c => c.id !== id))
  }

  return (
    <div className="space-y-6">
      <h2 className="text-2xl font-bold text-gray-800">
        Moderación de comentarios
      </h2>

      <div className="bg-white rounded-xl border shadow-sm">
        {comments.map(comment => (
          <CommentItem
            key={comment.id}
            comment={comment}
            onDelete={() => deleteComment(comment.id)}
          />
        ))}
      </div>
    </div>
  )
}
