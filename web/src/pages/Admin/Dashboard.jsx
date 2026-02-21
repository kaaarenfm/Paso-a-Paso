import { useEffect, useRef, useState } from "react"
import { animate, stagger } from "animejs"
import { LayoutDashboard } from "lucide-react"
import StatCard from "../../components/admin/dashboard/StatCard"
import ActivityList from "../../components/admin/dashboard/ActivityList"
import StatDetailsModal from "../../components/admin/dashboard/StatDetailsModal"

// ─── Mock data ───────────────────────────────────────────────
import { Users, ClipboardList, Globe, Gem } from "lucide-react"

// ─── Mock data ───────────────────────────────────────────────
const STATS = [
  {
    key: "users",
    title: "Usuarios totales",
    value: 124,
    change: 12,
    positive: true,
    bg: "bg-[var(--color-green-light)]",
    headerBg: "bg-[var(--color-green-dark)]",
    icon: Users,
    iconColor: "text-[var(--color-green-dark)]",
  },
  {
    key: "routines",
    title: "Rutinas creadas",
    value: 342,
    change: 8,
    positive: true,
    bg: "bg-[var(--color-blue-light)]",
    headerBg: "bg-[var(--color-blue-dark)]",
    icon: ClipboardList,
    iconColor: "text-[var(--color-blue-dark)]",
  },
  {
    key: "publicRoutines",
    title: "Rutinas públicas",
    value: 98,
    change: 3,
    positive: false,
    bg: "bg-[var(--color-yellow-light)]",
    headerBg: "bg-[var(--color-yellow)]",
    icon: Globe,
    iconColor: "text-[var(--color-dark)]",
  },
  {
    key: "premiumUsers",
    title: "Usuarios Premium",
    value: 37,
    change: 21,
    positive: true,
    bg: "bg-[var(--color-red-light)]",
    headerBg: "bg-[var(--color-red-dark)]",
    icon: Gem,
    iconColor: "text-[var(--color-red-dark)]",
  },
]

const ACTIVITY = [
  { id: 1, text: "Nuevo usuario registrado", time: "Hace 2 min", type: "user" },
  { id: 2, text: "Rutina pública publicada", time: "Hace 15 min", type: "routine" },
  { id: 3, text: "Usuario activó prueba Premium", time: "Hace 1 h", type: "premium" },
  { id: 4, text: "Comentario reportado por usuario", time: "Hace 3 h", type: "report" },
  { id: 5, text: "Nueva categoría añadida", time: "Hace 5 h", type: "content" },
]

// ─── Dashboard ───────────────────────────────────────────────
export default function Dashboard() {

  const [stats] = useState(STATS)
  const [activity] = useState(ACTIVITY)
  const [selectedStat, setSelectedStat] = useState(null)

  const headerRef = useRef(null)
  const statsRef = useRef(null)
  const activityRef = useRef(null)

  // ─── Animaciones ───────────────────────────────────────────
  useEffect(() => {

    animate(headerRef.current, {
      translateY: [-20, 0],
      opacity: [0, 1],
      duration: 600,
      easing: "ease-out",
    })

    animate(statsRef.current?.children, {
      translateY: [40, 0],
      opacity: [0, 1],
      duration: 800,
      easing: "ease-out",
      delay: stagger(120),
    })

    animate(activityRef.current, {
      translateY: [30, 0],
      opacity: [0, 1],
      duration: 700,
      easing: "ease-out",
      delay: 400,
    })

  }, [])


  // ─── Loader ────────────────────────────────────────────────
  if (!stats)
    return (
      <div className="min-h-screen bg-[var(--color-neutral-bg)] flex items-center justify-center">
        <div className="flex flex-col items-center gap-3">
          <div className="w-10 h-10 border-4 border-[var(--color-green-dark)] border-t-transparent rounded-full animate-spin" />
          <p className="text-sm text-[var(--color-gray-custom)]">
            Cargando dashboard...
          </p>
        </div>
      </div>
    )

  // ─── UI ────────────────────────────────────────────────────
  return (
    <div className="max-w-6xl mx-auto space-y-6">

      {/* Header */}
      <div ref={headerRef} className="flex items-center gap-2">
        <div className="w-8 h-8 rounded-xl bg-[var(--color-yellow-light)] flex items-center justify-center">
          <LayoutDashboard size={18} className="text-[var(--color-yellow-dark)]" />
        </div>
        <div>
          <h2 className="text-xl font-bold text-[var(--color-dark)] tracking-tight">
            Dashboard
          </h2>
          <p className="text-xs text-[var(--color-gray-custom)] mt-1">
            Resumen general de la plataforma
          </p>
        </div>
      </div>

      {/* Grid de stats */}
      <div
        ref={statsRef}
        className="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-4 gap-4"
      >
        {stats.map(({ key, ...stat }) => (
          <StatCard
            key={key}
            {...stat}
            onClick={() => setSelectedStat({ type: key, title: stat.title })}
          />
        ))}
      </div>

      {/* Actividad reciente */}
      <div ref={activityRef}>
        <ActivityList items={activity} />
      </div>

      {/* Modal de detalles */}
      {selectedStat && (
        <StatDetailsModal
          type={selectedStat.type}
          title={selectedStat.title}
          onClose={() => setSelectedStat(null)}
        />
      )}

    </div>
  )
}
