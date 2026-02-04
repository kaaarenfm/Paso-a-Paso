import { Trash2 } from "lucide-react"
import { useState } from "react"

export default function CategoryList({ categories, onDelete, colors }) {
  const [confirmId, setConfirmId] = useState(null)

  // Reparte colores cíclicamente
  const getColor = (index) => colors[index % colors.length]

  if (categories.length === 0) {
    return (
      <div className="bg-white rounded-2xl border border-gray-200 shadow-sm overflow-hidden">
        <div className="bg-[var(--color-neutral-light)] border-b border-gray-100 px-5 py-3">
          <h3 className="text-xs font-semibold text-[var(--color-gray-custom)] uppercase tracking-widest">
            Categorías actuales
          </h3>
        </div>
        <div className="py-10 flex flex-col items-center gap-2">
          <span className="text-2xl">📭</span>
          <p className="text-sm text-[var(--color-gray-custom)]">No hay categorías aún</p>
          <p className="text-xs text-[var(--color-gray-custom)]">Crea una desde el formulario de arriba</p>
        </div>
      </div>
    )
  }

  return (
    <div className="bg-white rounded-2xl border border-gray-200 shadow-sm overflow-hidden">
      {/* Header */}
      <div className="bg-[var(--color-neutral-light)] border-b border-gray-100 px-5 py-3 flex items-center justify-between">
        <h3 className="text-xs font-semibold text-[var(--color-gray-custom)] uppercase tracking-widest">
          Categorías actuales
        </h3>
        <span className="text-xs font-semibold text-[var(--color-gray-custom)] bg-[var(--color-neutral-bg)] px-2.5 py-0.5 rounded-full">
          {categories.length} total
        </span>
      </div>

      {/* Items */}
      <div className="divide-y divide-gray-100">
        {categories.map((cat, i) => {
          const color = getColor(i)
          const isConfirming = confirmId === cat.id

          return (
            <div
              key={cat.id}
              className={`flex items-center justify-between px-5 py-3.5 transition-colors duration-150 ${
                isConfirming ? "bg-[var(--color-red-light)]" : "hover:bg-[var(--color-neutral-bg)]"
              }`}
            >
              {/* Izquierda: emoji + tag */}
              <div className="flex items-center gap-3">
                {/* Icono/emoji en caja */}
                <div className={`w-8 h-8 rounded-xl ${color.bg} flex items-center justify-center`}>
                  <span className="text-sm">{cat.emoji}</span>
                </div>

                {/* Nombre como tag */}
                <span
                  className={`text-xs font-semibold px-3 py-1 rounded-full border ${color.bg} ${color.text} ${color.border}`}
                >
                  {cat.name}
                </span>
              </div>

              {/* Derecha: botones */}
              <div className="flex items-center gap-2">
                {!isConfirming ? (
                  // Botón eliminar normal
                  <button
                    onClick={() => setConfirmId(cat.id)}
                    className="w-8 h-8 rounded-lg flex items-center justify-center text-[var(--color-gray-custom)] hover:bg-[var(--color-red-light)] hover:text-[var(--color-red-dark)] transition-all duration-200"
                  >
                    <Trash2 size={15} />
                  </button>
                ) : (
                  // Confirmar / Cancelar
                  <>
                    <button
                      onClick={() => {
                        onDelete(cat.id)
                        setConfirmId(null)
                      }}
                      className="text-xs font-semibold text-white bg-[var(--color-red-dark)] px-3 py-1 rounded-lg hover:brightness-110 active:scale-95 transition-all duration-200"
                    >
                      Confirmar
                    </button>
                    <button
                      onClick={() => setConfirmId(null)}
                      className="text-xs font-semibold text-[var(--color-gray-custom)] bg-[var(--color-neutral-bg)] px-3 py-1 rounded-lg hover:bg-gray-200 transition-all duration-200"
                    >
                      Cancelar
                    </button>
                  </>
                )}
              </div>
            </div>
          )
        })}
      </div>
    </div>
  )
}