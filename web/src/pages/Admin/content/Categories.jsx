import { useState } from "react"
import { Tag } from "lucide-react"
import CategoryForm from "../../../components/admin/content/CategoryForm"
import CategoryList from "../../../components/admin/content/CategoryList"

const INITIAL_CATEGORIES = [
  { id: 1, name: "Salud",       emoji: "🏥" },
  { id: 2, name: "Estudio",     emoji: "📚" },
  { id: 3, name: "Bienestar",   emoji: "🌿" },
  { id: 4, name: "Ejercicio",   emoji: "🏋️" },
]

// Paleta ciclo para las tags nuevas
const TAG_COLORS = [
  { bg: "bg-[var(--color-green-light)]",  text: "text-[var(--color-green-dark)]",  border: "border-[var(--color-green-dark)]" },
  { bg: "bg-[var(--color-blue-light)]",   text: "text-[var(--color-blue-dark)]",   border: "border-[var(--color-blue-dark)]" },
  { bg: "bg-[var(--color-yellow-light)]", text: "text-[var(--color-dark)]",        border: "border-[var(--color-yellow)]" },
  { bg: "bg-[var(--color-red-light)]",    text: "text-[var(--color-red-dark)]",    border: "border-[var(--color-red-dark)]" },
]

export default function Categories() {
  const [categories, setCategories] = useState(INITIAL_CATEGORIES)
  const [toast, setToast] = useState({ show: false, text: "", type: "success" })

  const showToast = (text, type = "success") => {
    setToast({ show: true, text, type })
    setTimeout(() => setToast({ show: false, text: "", type: "success" }), 2500)
  }

  const addCategory = (name) => {
    setCategories((prev) => [...prev, { id: Date.now(), name, emoji: "🏷️" }])
    showToast(`Categoría "${name}" creada`)
  }

  const deleteCategory = (id) => {
    const cat = categories.find((c) => c.id === id)
    setCategories((prev) => prev.filter((c) => c.id !== id))
    showToast(`Categoría "${cat?.name}" eliminada`, "error")
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
            <div className="w-8 h-8 rounded-xl bg-[var(--color-green-light)] flex items-center justify-center">
              <Tag size={16} className="text-[var(--color-green-dark)]" />
            </div>
            <h2 className="text-xl font-bold text-[var(--color-dark)] tracking-tight">
              Categorías
            </h2>
          </div>
          <p className="text-xs text-[var(--color-gray-custom)] mt-1 ml-10">
            Administra las categorías de rutinas disponibles
          </p>
        </div>

        {/* Badge contador */}
        <span className="text-xs font-semibold text-[var(--color-green-dark)] bg-[var(--color-green-light)] px-3 py-1 rounded-full">
          {categories.length} categorías
        </span>
      </div>

      {/* Formulario */}
      <CategoryForm onAdd={addCategory} />

      {/* Lista */}
      <CategoryList
        categories={categories}
        onDelete={deleteCategory}
        colors={TAG_COLORS}
      />
    </div>
  )
}