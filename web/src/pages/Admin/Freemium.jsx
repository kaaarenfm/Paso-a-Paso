import { useState, useRef, useEffect } from "react"
import { animate, stagger } from "animejs"
import {
  Repeat,
  Bell,
  Users,
  Sparkles,
  DollarSign,
} from "lucide-react"

// ─── Datos ───────────────────────────────────────────────────
const FEATURES = [
  {
    key: "createRoutines",
    label: "Crear rutinas ilimitadas",
    icon: Repeat,
    bg: "bg-[var(--color-green-light)]",
    iconColor: "text-[var(--color-green-dark)]",
    activeBg: "bg-[var(--color-green-dark)]",
  },
  {
    key: "notifications",
    label: "Notificaciones avanzadas",
    icon: Bell,
    bg: "bg-[var(--color-yellow-light)]",
    iconColor: "text-[var(--color-dark)]",
    activeBg: "bg-[var(--color-yellow)]",
  },
  {
    key: "community",
    label: "Participación en comunidad",
    icon: Users,
    bg: "bg-[var(--color-blue-light)]",
    iconColor: "text-[var(--color-blue-dark)]",
    activeBg: "bg-[var(--color-blue-dark)]",
  },
  {
    key: "mascot",
    label: "Mascota virtual",
    icon: Sparkles,
    bg: "bg-[var(--color-red-light)]",
    iconColor: "text-[var(--color-red-dark)]",
    activeBg: "bg-[var(--color-red-dark)]",
  },
]

const MOCK_USERS = [
  { name: "Ana", plan: "Premium" },
  { name: "Luis", plan: "Free" },
  { name: "Sofía", plan: "Premium" },
  { name: "Carlos", plan: "Free" },
]

// ─── Freemium ────────────────────────────────────────────────
export default function Freemium() {
  const [trialDays, setTrialDays] = useState(14)
  const [features, setFeatures] = useState({
    createRoutines: false,
    notifications: false,
    community: false,
    mascot: false,
  })

  // Refs para animación
  const headerRef = useRef(null)
  const cardsRef = useRef(null)

  useEffect(() => {
    // Animación Header
    animate(headerRef.current, {
      translateY: [-20, 0],
      opacity: [0, 1],
      duration: 600,
      easing: "easeOutExpo"
    })

    // Animación Cards (Stagger)
    if (cardsRef.current) {
      animate(cardsRef.current.children, {
        translateY: [30, 0],
        opacity: [0, 1],
        delay: stagger(100, { start: 200 }),
        duration: 800,
        easing: "easeOutExpo"
      })
    }
  }, [])

  const toggleFeature = (key) => {
    setFeatures((prev) => ({ ...prev, [key]: !prev[key] }))
  }

  const increment = () => setTrialDays((d) => Math.max(1, Number(d) + 1))
  const decrement = () => setTrialDays((d) => Math.max(1, Number(d) - 1))

  return (
    <div className="mx-auto space-y-6">
      {/* Header */}
      <div ref={headerRef} className="flex items-center gap-2">
        <div className="w-8 h-8 rounded-xl bg-[var(--color-yellow-light)] flex items-center justify-center">
          <DollarSign size={18} className="text-[var(--color-yellow-dark)]" />
        </div>
        <div>
          <h2 className="text-xl font-bold text-[var(--color-dark)] tracking-tight">
            Modelo Freemium
          </h2>
          <p className="text-xs text-[var(--color-gray-custom)] mt-1">
            Configura límites y funciones del plan gratuito
          </p>
        </div>
      </div>

      <div className="grid grid-cols-1 sm:grid-cols-2 gap-5 px-2 py-2">
        {/* Card: Funciones Premium — fondo verde */}
        <div className="bg-white rounded-2xl border border-gray-200 shadow-sm overflow-hidden">
          <div className="bg-[var(--color-green-light)] border-b border-[var(--color-green-dark)] px-5 py-3 flex items-center gap-2">
            <Sparkles size={14} className="text-[var(--color-green-dark)]" />
            <h3 className="text-xs font-semibold text-[var(--color-green-dark)] uppercase tracking-widest">
              Funciones Premium
            </h3>
          </div>

          <div className="px-5">
            {FEATURES.map((feature, i) => {
              const Icon = feature.icon
              const active = features[feature.key]

              return (
                <div
                  key={feature.key}
                  className={`flex items-center justify-between py-4 ${i !== 0 ? "border-t border-gray-100" : ""}`}
                >
                  {/* Icono colorido + label */}
                  <div className="flex items-center gap-3">
                    <div className={`w-9 h-9 rounded-xl ${active ? feature.bg : "bg-[var(--color-neutral-bg)]"} flex items-center justify-center transition-colors duration-300`}>
                      <Icon
                        size={17}
                        className={`transition-colors duration-300 ${active ? feature.iconColor : "text-[var(--color-gray-custom)]"}`}
                      />
                    </div>
                    <p className="text-sm font-medium text-[var(--color-dark)]">{feature.label}</p>
                  </div>

                  {/* Toggle pill con color propio */}
                  <button
                    onClick={() => toggleFeature(feature.key)}
                    aria-label={`Toggle ${feature.label}`}
                    className={`
                relative w-12 h-6 rounded-full transition-colors duration-300 ease-out
                focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-[var(--color-green-light)]
                ${active ? feature.activeBg : "bg-gray-300"}
              `}
                  >
                    <span
                      className={`
                  absolute top-0.5 left-0.5
                  w-5 h-5 bg-white rounded-full shadow
                  transition-transform duration-300 ease-out
                  ${active ? "translate-x-6" : "translate-x-0"}
                `}
                    />
                  </button>
                </div>
              )
            })}
          </div>
        </div>

        {/* Card: Tabla de usuarios — fondo azul suave */}
        <div className="bg-white rounded-2xl border border-gray-200 shadow-sm overflow-hidden ">
          <div className="bg-[var(--color-blue-light)] border-b border-[var(--color-blue-dark)] px-5 py-3 flex items-center justify-between">
            <div className="flex items-center gap-2">
              <Users size={14} className="text-[var(--color-blue-dark)]" />
              <h3 className="text-xs font-semibold text-[var(--color-blue-dark)] uppercase tracking-widest">
                Usuarios
              </h3>
            </div>
            <span className="text-xs font-semibold text-[var(--color-blue-dark)] bg-white px-2.5 py-0.5 rounded-full shadow-sm">
              {MOCK_USERS.length} registrados
            </span>
          </div>

          <div className="overflow-x-auto">
            <table className="w-full">
              <thead>
                <tr className="border-b border-gray-100 bg-[var(--color-neutral-light)]">
                  <th className="text-left text-xs font-semibold text-[var(--color-gray-custom)] uppercase tracking-wider px-5 py-2.5">
                    Usuario
                  </th>
                  <th className="text-left text-xs font-semibold text-[var(--color-gray-custom)] uppercase tracking-wider px-5 py-2.5">
                    Plan
                  </th>
                </tr>
              </thead>
              <tbody>
                {MOCK_USERS.map((user, i) => {
                  const isPremium = user.plan === "Premium"
                  return (
                    <tr
                      key={i}
                      className={`border-b border-gray-100 last:border-0 hover:bg-[var(--color-blue-light)] transition-colors duration-150 ${i % 2 === 0 ? "bg-white" : "bg-[var(--color-neutral-light)]"
                        }`}
                    >
                      <td className="px-5 py-3">
                        <div className="flex items-center gap-2.5">
                          <div
                            className={`w-7 h-7 rounded-full flex items-center justify-center ${isPremium ? "bg-[var(--color-yellow-light)]" : "bg-[var(--color-blue-light)]"
                              }`}
                          >
                            <span
                              className={`text-xs font-bold ${isPremium ? "text-[var(--color-dark)]" : "text-[var(--color-blue-dark)]"
                                }`}
                            >
                              {user.name[0]}
                            </span>
                          </div>
                          <span className="text-sm font-medium text-[var(--color-dark)]">{user.name}</span>
                        </div>
                      </td>
                      <td className="px-5 py-3">
                        <span
                          className={`inline-flex items-center gap-1.5 text-xs font-semibold px-2.5 py-1 rounded-full ${isPremium
                            ? "bg-[var(--color-yellow-light)] text-[var(--color-dark)]"
                            : "bg-[var(--color-green-light)] text-[var(--color-green-dark)]"
                            }`}
                        >
                          {isPremium && <Sparkles size={10} />}
                          {user.plan}
                        </span>
                      </td>
                    </tr>
                  )
                })}
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  )
}