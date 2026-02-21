import { useState } from "react"
import { Plus, X, ListTodo } from "lucide-react"

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
    <div className="px-6 py-5 bg-gray-50 border-t border-gray-100">

      {/* Título de sección */}
      <div className="flex items-center gap-2 mb-3">
        <ListTodo size={14} className="text-[var(--color-gray-custom)]" />
        <span className="text-xs font-semibold text-[var(--color-gray-custom)] uppercase tracking-wide">
          Hábitos de la categoría
        </span>
      </div>

      {/* Input de agregar hábito */}
      <div className="flex gap-2 mb-4">
        <div className="flex-1 relative">
          <input
            value={value}
            onChange={(e) => setValue(e.target.value)}
            onKeyDown={(e) => e.key === "Enter" && handleAdd()}
            placeholder="Escribe un nuevo hábito..."
            className="w-full border border-gray-200 rounded-xl pl-4 pr-4 py-2 text-sm bg-white focus:outline-none focus:border-[var(--color-green-dark)] focus:ring-1 focus:ring-[var(--color-green-dark)] transition-all"
          />
        </div>
        <button
          onClick={handleAdd}
          disabled={!value.trim()}
          className={`
            px-4 py-2 rounded-xl text-white transition-all duration-200 flex items-center justify-center
            ${value.trim()
              ? "bg-[var(--color-green-dark)] hover:brightness-110 shadow-sm cursor-pointer"
              : "bg-gray-300 cursor-not-allowed"}
          `}
        >
          <Plus size={18} />
        </button>
      </div>

      {/* Lista de hábitos (Chips) */}
      {category.habits.length > 0 ? (
        <div className="flex flex-wrap gap-2">
          {category.habits.map(h => (
            <div
              key={h.id}
              className="group flex items-center gap-2 pl-3 pr-2 py-1.5 rounded-lg bg-white border border-gray-200 shadow-sm hover:border-[var(--color-green-light)] transition-all duration-200"
            >
              <span className="text-sm text-[var(--color-dark)] font-medium">
                {h.name}
              </span>
              <button
                onClick={() => onDeleteHabit(category.id, h.id)}
                className="p-1 rounded-md text-gray-400 hover:text-red-500 hover:bg-red-50 transition-colors opacity-0 group-hover:opacity-100"
              >
                <X size={14} />
              </button>
            </div>
          ))}
        </div>
      ) : (
        <div className="text-center py-4 border-2 border-dashed border-gray-200 rounded-xl">
          <p className="text-xs text-gray-400">No hay hábitos asignados aún.</p>
        </div>
      )}
    </div>
  )
}
