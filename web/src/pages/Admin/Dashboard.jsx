import { useState } from "react"
import StatCard from "../../components/admin/dashboard/StatCard"
import ActivityList from "../../components/admin/dashboard/ActivityList"

// ─── Mock data ───────────────────────────────────────────────
const STATS = [
  {
    key: "users",
    title: "Usuarios totales",
    value: 124,
    change: 12,        // porcentaje respecto al mes anterior
    positive: true,
    bg: "bg-[var(--color-green-light)]",
    headerBg: "bg-[var(--color-green-dark)]",
    icon: "👥",
  },
  {
    key: "routines",
    title: "Rutinas creadas",
    value: 342,
    change: 8,
    positive: true,
    bg: "bg-[var(--color-blue-light)]",
    headerBg: "bg-[var(--color-blue-dark)]",
    icon: "📋",
  },
  {
    key: "publicRoutines",
    title: "Rutinas públicas",
    value: 98,
    change: 3,
    positive: false,   // bajó un 3%
    bg: "bg-[var(--color-yellow-light)]",
    headerBg: "bg-[var(--color-yellow)]",
    icon: "🌐",
  },
  {
    key: "premiumUsers",
    title: "Usuarios Premium",
    value: 37,
    change: 21,
    positive: true,
    bg: "bg-[var(--color-red-light)]",
    headerBg: "bg-[var(--color-red-dark)]",
    icon: "💎",
  },
]

const ACTIVITY = [
  { id: 1, text: "Nuevo usuario registrado",          time: "Hace 2 min",  type: "user" },
  { id: 2, text: "Rutina pública publicada",          time: "Hace 15 min", type: "routine" },
  { id: 3, text: "Usuario activó prueba Premium",     time: "Hace 1 h",   type: "premium" },
  { id: 4, text: "Comentario reportado por usuario",  time: "Hace 3 h",   type: "report" },
  { id: 5, text: "Nueva categoría añadida",           time: "Hace 5 h",   type: "content" },
]

// ─── Dashboard ───────────────────────────────────────────────
export default function Dashboard() {

const [stats] = useState(STATS)
const [activity] = useState(ACTIVITY)


  if (!stats)
    return (
      <div className="min-h-screen bg-[var(--color-neutral-bg)] flex items-center justify-center">
        <div className="flex flex-col items-center gap-3">
          <div className="w-10 h-10 border-4 border-[var(--color-green-dark)] border-t-transparent rounded-full animate-spin" />
          <p className="text-sm text-[var(--color-gray-custom)]">Cargando dashboard...</p>
        </div>
      </div>
    )

  return (
    <div className="max-w-6xl mx-auto space-y-6">
      {/* Header */}
      <div>
        <h2 className="text-xl font-bold text-[var(--color-dark)] tracking-tight">Dashboard</h2>
        <p className="text-xs text-[var(--color-gray-custom)] mt-1">Resumen general de la plataforma</p>
      </div>

      {/* Grid de stats */}
      <div className="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-4 gap-4">
        {stats.map((stat) => (
          <StatCard key={stat.key} {...stat} />
        ))}
      </div>

      {/* Actividad reciente */}
      <ActivityList items={activity} />
    </div>
  )
}