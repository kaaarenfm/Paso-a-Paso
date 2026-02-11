import { useState } from "react"
import { Plus, X } from "lucide-react"

export default function CategoryHabits({
  category,
  onAddHabit,
  onDeleteHabit
}) {
  const [value, setValue] = useState("")

  const handleAdd = () => {
    if (!value.trim()) return
    onAddHabit(category.id, value)
    setValue("")
  }

  return (
    <div className="px-6 pb-4 pt-2 bg-[var(--color-neutral-light)]">
      <div className="flex gap-2 mb-3">
        <input
          value={value}
          onChange={(e) => setValue(e.target.value)}
          placeholder="Nuevo hábito..."
          className="flex-1 border rounded-lg px-3 py-2 text-xs"
        />
        <button
          onClick={handleAdd}
          className="px-3 py-2 rounded-lg bg-[var(--color-green-dark)] text-white"
        >
          <Plus size={14} />
        </button>
      </div>

      <div className="flex flex-wrap gap-2">
        {category.habits.map(h => (
          <span
            key={h.id}
            className="flex items-center gap-1 text-xs px-3 py-1 rounded-full bg-white border"
          >
            {h.name}
            <button onClick={() => onDeleteHabit(category.id, h.id)}>
              <X size={12} />
            </button>
          </span>
        ))}
      </div>
    </div>
  )
}
