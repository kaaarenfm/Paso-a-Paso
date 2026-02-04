import { useState } from "react"
import { Plus } from "lucide-react"

export default function PhraseForm({ onAdd }) {
  const [text, setText] = useState("")
  const [focused, setFocused] = useState(false)

  const handleSubmit = () => {
    const trimmed = text.trim()
    if (!trimmed) return
    onAdd(trimmed)
    setText("")
  }

  return (
    <div className="bg-white rounded-2xl border border-gray-200 shadow-sm overflow-hidden">
      <div className="bg-[var(--color-blue-light)] border-b border-[var(--color-blue-dark)] px-5 py-3">
        <h3 className="text-xs font-semibold text-[var(--color-blue-dark)] uppercase tracking-widest">
          Nueva frase
        </h3>
      </div>

      <div className="p-5 space-y-3">
        {/* Textarea con comillas decorativas */}
        <div className="relative">
          <span className="absolute left-3 top-2.5 text-lg font-bold text-[var(--color-green-dark)] leading-none">❝</span>
          <textarea
            rows={2}
            placeholder="Escribe una frase motivacional..."
            value={text}
            onChange={(e) => setText(e.target.value)}
            onFocus={() => setFocused(true)}
            onBlur={() => setFocused(false)}
            onKeyDown={(e) => {
              if (e.key === "Enter" && !e.shiftKey) {
                e.preventDefault()
                handleSubmit()
              }
            }}
            className={`
              w-full border rounded-xl pl-8 pr-4 py-2.5 text-sm resize-none
              bg-[var(--color-neutral-light)] text-[var(--color-dark)]
              placeholder-gray-400 outline-none transition-all duration-200
              ${focused
                ? "border-[var(--color-green-dark)] ring-2 ring-[var(--color-green-light)] bg-white"
                : "border-gray-200"
              }
            `}
          />
        </div>

        {/* Footer: contador + botón */}
        <div className="flex items-center justify-between">
          <span className="text-xs text-[var(--color-gray-custom)]">
            {text.length} caracteres
          </span>
          <button
            onClick={handleSubmit}
            disabled={!text.trim()}
            className={`
              flex items-center gap-1.5 px-4 py-2 rounded-xl text-xs font-semibold text-white
              transition-all duration-200 active:scale-95
              ${text.trim()
                ? "bg-[var(--color-green-dark)] shadow-md hover:brightness-110 cursor-pointer"
                : "bg-gray-300 cursor-not-allowed"
              }
            `}
          >
            <Plus size={14} />
            Añadir frase
          </button>
        </div>

        {/* Hint */}
        <p className="text-xs text-[var(--color-gray-custom)]">
          Presiona <kbd className="bg-[var(--color-neutral-bg)] border border-gray-200 rounded px-1.5 py-0.5 text-[var(--color-dark)] font-semibold text-xs">Enter</kbd> para añadir rápido
        </p>
      </div>
    </div>
  )
}