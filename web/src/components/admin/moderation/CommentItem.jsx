export default function CommentItem({ comment, onDelete }) {
  return (
    <div className="flex justify-between items-center p-4 border-b">
      <div>
        <p className="font-medium text-gray-700">
          {comment.user}
        </p>
        <p className="text-sm text-gray-600">
          {comment.text}
        </p>
      </div>

      <button
        onClick={onDelete}
        className="text-sm text-red-500 hover:underline"
      >
        Eliminar
      </button>
    </div>
  )
}
