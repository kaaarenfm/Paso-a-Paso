import { useState } from "react"
import { Plus, Tag, Smile } from "lucide-react"

export default function CategoryForm({ onAdd }) {
  const [name, setName] = useState("")
  const [emoji, setEmoji] = useState("🏷️") // Default emoji
  const [focused, setFocused] = useState(false)

  const handleSubmit = () => {
    const trimmed = name.trim()
    if (!trimmed) return
    onAdd({ name: trimmed, emoji })
    setName("")
    setEmoji("🏷️")
  }

  return (
    <div className="bg-white rounded-2xl border border-gray-100 shadow-sm hover:shadow-md transition-all duration-300 p-1">
      <div className="p-4 flex flex-col sm:flex-row gap-4 items-center">

        {/* Emoji Preview / Selector (Simulado por ahora) */}
        <div className="flex-shrink-0 w-12 h-12 rounded-xl bg-[var(--color-green-light)] flex items-center justify-center text-2xl cursor-pointer hover:scale-105 transition-transform">
          {emoji}
        </div>

        {/* Input Area */}
        <div className="flex-1 w-full relative">
          <div className={`
                flex items-center gap-2 px-4 py-3 rounded-xl border transition-all duration-200 bg-[var(--color-neutral-bg)]
                ${focused
              ? "border-[var(--color-green-dark)] ring-2 ring-[var(--color-green-light)] bg-white"
              : "border-transparent hover:border-gray-200"
            }
            `}>
            <Tag size={18} className={focused ? "text-[var(--color-green-dark)]" : "text-gray-400"} />
            <input
              type="text"
              placeholder="Nombre de la nueva categoría..."
              value={name}
              onChange={(e) => setName(e.target.value)}
              onFocus={() => setFocused(true)}
              onBlur={() => setFocused(false)}
              onKeyDown={(e) => e.key === "Enter" && handleSubmit()}
              className="flex-1 bg-transparent border-none outline-none text-sm text-[var(--color-dark)] placeholder-gray-400"
            />
          </div>
        </div>

        {/* Button */}
        <button
          onClick={handleSubmit}
          disabled={!name.trim()}
          className={`
                flex-shrink-0 w-full sm:w-auto flex items-center justify-center gap-2 px-6 py-3 rounded-xl text-sm font-bold text-white transition-all duration-200
                ${name.trim()
              ? "bg-[var(--color-green-dark)] shadow-lg shadow-green-200 hover:-translate-y-0.5"
              : "bg-gray-200 text-gray-400 cursor-not-allowed"
            }
            `}
        >
          <Plus size={18} />
          <span>Crear</span>
        </button>
      </div>

      {/* Footer hint */}
      {focused && (
        <div className="px-4 pb-3 -mt-1">
          <p className="text-[10px] text-[var(--color-gray-custom)] font-medium pl-[4.5rem]">
            Presiona <span className="font-bold">Enter</span> para guardar
          </p>
        </div>
      )}
    </div>
  )
}
