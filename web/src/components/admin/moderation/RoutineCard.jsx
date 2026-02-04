export default function RoutineCard({ routine, onApprove, onReject, onDelete }) {
  return (
    <div className="bg-white border rounded-xl p-5 shadow-sm">
      <div className="flex justify-between items-start">
        <div>
          <h3 className="font-semibold text-gray-800">
            {routine.title}
          </h3>
          <p className="text-sm text-gray-500">
            Autor: {routine.author}
          </p>
          <span className="text-xs text-gray-400">
            Estado: {routine.status}
          </span>
        </div>

        <div className="flex gap-2">
          <button
            onClick={onApprove}
            className="text-sm text-green-600 hover:underline"
          >
            Aprobar
          </button>

          <button
            onClick={onReject}
            className="text-sm text-yellow-600 hover:underline"
          >
            Rechazar
          </button>

          <button
            onClick={onDelete}
            className="text-sm text-red-500 hover:underline"
          >
            Eliminar
          </button>
        </div>
      </div>
    </div>
  )
}
