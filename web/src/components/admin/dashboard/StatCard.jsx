import { TrendingUp, TrendingDown } from "lucide-react"

export default function StatCard({ title, value, change, positive, bg, headerBg, icon }) {
  return (
    <div className={`${bg} rounded-2xl shadow-sm overflow-hidden border border-gray-100`}>
      {/* Header colorido */}
      <div className={`${headerBg} px-4 py-2 flex items-center justify-between`}>
        <span className="text-xs font-semibold text-white uppercase tracking-widest">{title}</span>
        <span className="text-base">{icon}</span>
      </div>

      {/* Cuerpo */}
      <div className="px-4 py-4 flex items-end justify-between">
        {/* Valor grande */}
        <div>
          <p className="text-3xl font-bold text-[var(--color-dark)] leading-tight">{value.toLocaleString()}</p>
          <p className="text-xs text-[var(--color-gray-custom)] mt-1">Total acumulado</p>
        </div>

        {/* Badge de cambio */}
        <div
          className={`flex items-center gap-1 text-xs font-semibold px-2 py-1 rounded-full ${
            positive
              ? "bg-[var(--color-green-light)] text-[var(--color-green-dark)]"
              : "bg-[var(--color-red-light)] text-[var(--color-red-dark)]"
          }`}
        >
          {positive ? <TrendingUp size={12} /> : <TrendingDown size={12} />}
          {positive ? "+" : "-"}{change}%
        </div>
      </div>
    </div>
  )
}