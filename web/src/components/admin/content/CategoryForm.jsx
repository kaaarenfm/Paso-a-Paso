import { useState } from "react"
import { Plus } from "lucide-react"

export default function CategoryForm({ onAdd }) {
  const [name, setName] = useState("")
  const [focused, setFocused] = useState(false)

  const handleSubmit = () => {
    const trimmed = name.trim()
    if (!trimmed) return
    onAdd(trimmed)
    setName("")
  }

  return (
    <div className="bg-white rounded-2xl border border-gray-200 shadow-sm overflow-hidden">
      {/* Header */}
      <div className="bg-[var(--color-blue-light)] border-b border-[var(--color-blue-dark)] px-5 py-3">
        <h3 className="text-xs font-semibold text-[var(--color-blue-dark)] uppercase tracking-widest">
          Nueva categoría
        </h3>
      </div>

      {/* Body */}
      <div className="p-5">
        <div className={`flex gap-3 transition-all duration-200`}>
          {/* Input */}
          <div className="relative flex-1">
            <input
              type="text"
              placeholder="Nombre de la categoría..."
              value={name}
              onChange={(e) => setName(e.target.value)}
              onFocus={() => setFocused(true)}
              onBlur={() => setFocused(false)}
              onKeyDown={(e) => e.key === "Enter" && handleSubmit()}
              className={`
                w-full border rounded-xl px-4 py-2.5 text-sm
                bg-[var(--color-neutral-light)] text-[var(--color-dark)]
                placeholder-gray-400 outline-none transition-all duration-200
                ${focused
                  ? "border-[var(--color-blue-dark)] ring-2 ring-[var(--color-blue-light)] bg-white"
                  : "border-gray-200"
                }
              `}
            />
            {/* Preview tag mientras escribe */}
            {name.trim() && (
              <div className="absolute right-3 top-1/2 -translate-y-1/2">
                <span className="text-xs font-semibold bg-[var(--color-blue-light)] text-[var(--color-blue-dark)] px-2 py-0.5 rounded-full">
                  preview
                </span>
              </div>
            )}
          </div>

          {/* Botón crear */}
          <button
            onClick={handleSubmit}
            disabled={!name.trim()}
            className={`
              flex items-center gap-1.5 px-4 py-2.5 rounded-xl text-xs font-semibold text-white
              transition-all duration-200 active:scale-95
              ${name.trim()
                ? "bg-[var(--color-green-dark)] shadow-md hover:brightness-110 cursor-pointer"
                : "bg-gray-300 cursor-not-allowed"
              }
            `}
          >
            <Plus size={14} />
            Crear
          </button>
        </div>

        {/* Hint */}
        <p className="text-xs text-[var(--color-gray-custom)] mt-2.5 ml-0.5">
          Presiona <kbd className="bg-[var(--color-neutral-bg)] border border-gray-200 rounded px-1.5 py-0.5 text-[var(--color-dark)] font-semibold text-xs">Enter</kbd> o click en "Crear" para agregar
        </p>
      </div>
    </div>
  )
}