import { useState } from "react"
import { Clock } from "lucide-react"
import CategoryForm from "../../../components/admin/content/CategoryForm"
import CategoryList from "../../../components/admin/content/CategoryList"

const INITIAL_TYPES = [
  { id: 1, name: "Mañana",  emoji: "🌅" },
  { id: 2, name: "Tarde",   emoji: "☀️" },
  { id: 3, name: "Noche",   emoji: "🌙" },
]

const TAG_COLORS = [
  { bg: "bg-[var(--color-yellow-light)]", text: "text-[var(--color-dark)]",        border: "border-[var(--color-yellow)]" },
  { bg: "bg-[var(--color-blue-light)]",   text: "text-[var(--color-blue-dark)]",   border: "border-[var(--color-blue-dark)]" },
  { bg: "bg-[var(--color-red-light)]",    text: "text-[var(--color-red-dark)]",    border: "border-[var(--color-red-dark)]" },
  { bg: "bg-[var(--color-green-light)]",  text: "text-[var(--color-green-dark)]",  border: "border-[var(--color-green-dark)]" },
]

export default function RoutineTypes() {
  const [types, setTypes] = useState(INITIAL_TYPES)
  const [toast, setToast] = useState({ show: false, text: "", type: "success" })

  const showToast = (text, type = "success") => {
    setToast({ show: true, text, type })
    setTimeout(() => setToast({ show: false, text: "", type: "success" }), 2500)
  }

  const addType = (name) => {
    setTypes((prev) => [...prev, { id: Date.now(), name, emoji: "⏰" }])
    showToast(`Tipo "${name}" creado`)
  }

  const deleteType = (id) => {
    const type = types.find((t) => t.id === id)
    setTypes((prev) => prev.filter((t) => t.id !== id))
    showToast(`Tipo "${type?.name}" eliminado`, "error")
  }

  return (
    <div className="max-w-2xl mx-auto space-y-5">
      {/* Toast */}
      <div
        className={`
          fixed top-5 right-5 z-50 flex items-center gap-2
          text-xs font-semibold px-5 py-2.5 rounded-lg shadow-lg text-white
          transition-all duration-300 ease-out
          ${toast.show ? "translate-y-0 opacity-100" : "-translate-y-16 opacity-0"}
          ${toast.type === "success" ? "bg-[var(--color-green-dark)]" : "bg-[var(--color-red-dark)]"}
        `}
      >
        <span>{toast.type === "success" ? "✓" : "✕"}</span>
        {toast.text}
      </div>

      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <div className="flex items-center gap-2">
            <div className="w-8 h-8 rounded-xl bg-[var(--color-yellow-light)] flex items-center justify-center">
              <Clock size={16} className="text-[var(--color-dark)]" />
            </div>
            <h2 className="text-xl font-bold text-[var(--color-dark)] tracking-tight">
              Tipos de rutina
            </h2>
          </div>
          <p className="text-xs text-[var(--color-gray-custom)] mt-1 ml-10">
            Define los horarios disponibles para las rutinas
          </p>
        </div>
        <span className="text-xs font-semibold text-[var(--color-dark)] bg-[var(--color-yellow-light)] px-3 py-1 rounded-full">
          {types.length} tipos
        </span>
      </div>

      <CategoryForm onAdd={addType} headerBg="bg-[var(--color-yellow)]" headerText="text-[var(--color-dark)]" focusColor="border-[var(--color-yellow)]" focusRing="ring-[var(--color-yellow-light)]" buttonBg="bg-[var(--color-yellow)]" buttonText="text-[var(--color-dark)]" placeholder="Nombre del tipo de rutina..." label="Crear tipo" />
      <CategoryList categories={types} onDelete={deleteType} colors={TAG_COLORS} />
    </div>
  )
}