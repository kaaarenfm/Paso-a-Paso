export default function ReportItem({ report, onResolve }) {
  return (
    <div className="flex justify-between items-center p-4 border-b">
      <div>
        <p className="font-medium text-gray-700">
          Tipo: {report.type}
        </p>
        <p className="text-sm text-gray-600">
          Motivo: {report.reason}
        </p>
      </div>

      <button
        onClick={onResolve}
        className="text-sm text-indigo-600 hover:underline"
      >
        Marcar como resuelto
      </button>
    </div>
  )
}
