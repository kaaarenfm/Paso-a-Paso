import { useState } from "react"
import RoutineCard from "../../../components/admin/moderation/RoutineCard"

export default function PublicRoutines() {
  const [routines, setRoutines] = useState([
    { id: 1, title: "Rutina matutina", author: "Ana", status: "pending" },
    { id: 2, title: "Rutina de estudio", author: "Luis", status: "approved" },
  ])

  const updateStatus = (id, status) => {
    setRoutines(
      routines.map(r =>
        r.id === id ? { ...r, status } : r
      )
    )
  }

  const deleteRoutine = (id) => {
    setRoutines(routines.filter(r => r.id !== id))
  }

  return (
    <div className="space-y-6">
      <h2 className="text-2xl font-bold text-gray-800">
        Moderación de rutinas públicas
      </h2>

      <div className="grid gap-4">
        {routines.map(routine => (
          <RoutineCard
            key={routine.id}
            routine={routine}
            onApprove={() => updateStatus(routine.id, "approved")}
            onReject={() => updateStatus(routine.id, "rejected")}
            onDelete={() => deleteRoutine(routine.id)}
          />
        ))}
      </div>
    </div>
  )
}
