import { useState } from "react"
import { Tag } from "lucide-react"
import CategoryForm from "../../../components/admin/content/CategoryForm"
import CategoryList from "../../../components/admin/content/CategoryList"

const INITIAL_CATEGORIES = [
  { id: 1, name: "Salud", emoji: "🏥", habits: [] },
  { id: 2, name: "Estudio", emoji: "📚", habits: [] },
  { id: 3, name: "Bienestar", emoji: "🌿", habits: [] },
  { id: 4, name: "Ejercicio", emoji: "🏋️", habits: [] },
]

const TAG_COLORS = [
  { bg: "bg-[var(--color-green-light)]", text: "text-[var(--color-green-dark)]", border: "border-[var(--color-green-dark)]" },
  { bg: "bg-[var(--color-blue-light)]", text: "text-[var(--color-blue-dark)]", border: "border-[var(--color-blue-dark)]" },
  { bg: "bg-[var(--color-yellow-light)]", text: "text-[var(--color-dark)]", border: "border-[var(--color-yellow)]" },
  { bg: "bg-[var(--color-red-light)]", text: "text-[var(--color-red-dark)]", border: "border-[var(--color-red-dark)]" },
]

export default function Categories() {
  const [categories, setCategories] = useState(INITIAL_CATEGORIES)

  const addCategory = (name) => {
    setCategories(prev => [
      ...prev,
      { id: Date.now(), name, emoji: "🏷️", habits: [] }
    ])
  }

  const deleteCategory = (id) => {
    setCategories(prev => prev.filter(c => c.id !== id))
  }

  const addHabit = (catId, habitName) => {
    setCategories(prev =>
      prev.map(cat =>
        cat.id === catId
          ? { ...cat, habits: [...cat.habits, { id: Date.now(), name: habitName }] }
          : cat
      )
    )
  }

  const deleteHabit = (catId, habitId) => {
    setCategories(prev =>
      prev.map(cat =>
        cat.id === catId
          ? { ...cat, habits: cat.habits.filter(h => h.id !== habitId) }
          : cat
      )
    )
  }

  return (
    <div className="max-w-2xl mx-auto space-y-5">
      <div className="flex items-center gap-2">
        <div className="w-8 h-8 rounded-xl bg-[var(--color-green-light)] flex items-center justify-center">
          <Tag size={16} className="text-[var(--color-green-dark)]" />
        </div>
        <h2 className="text-xl font-bold text-[var(--color-dark)]">
          Categorías
        </h2>
      </div>

      <CategoryForm onAdd={addCategory} />

      <CategoryList
        categories={categories}
        onDelete={deleteCategory}
        onAddHabit={addHabit}
        onDeleteHabit={deleteHabit}
        colors={TAG_COLORS}
      />
    </div>
  )
}
