import { useState } from "react"
import ReportItem from "../../../components/admin/moderation/ReportItem"

export default function Reports() {
  const [reports, setReports] = useState([
    { id: 1, type: "Rutina", reason: "Contenido inapropiado" },
    { id: 2, type: "Comentario", reason: "Lenguaje ofensivo" },
  ])

  const resolveReport = (id) => {
    setReports(reports.filter(r => r.id !== id))
  }

  return (
    <div className="space-y-6">
      <h2 className="text-2xl font-bold text-gray-800">
        Reportes de usuarios
      </h2>

      <div className="bg-white rounded-xl border shadow-sm">
        {reports.map(report => (
          <ReportItem
            key={report.id}
            report={report}
            onResolve={() => resolveReport(report.id)}
          />
        ))}
      </div>
    </div>
  )
}
