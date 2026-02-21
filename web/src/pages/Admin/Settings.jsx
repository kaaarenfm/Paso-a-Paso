import { useState, useRef, useEffect } from "react"
import { animate, stagger } from "animejs"
import { Dog, Lightbulb, Settings as SettingsIcon, Bell } from "lucide-react"

export default function Settings() {
  const [settings, setSettings] = useState({
    mascot: true,
    recommendations: true,
    systemMessage: "",
  })
  const [published, setPublished] = useState(false)
  const [toast, setToast] = useState(false)

  const headerRef = useRef(null)
  const cardsRef = useRef(null)

  useEffect(() => {
    // Header Animation
    animate(headerRef.current, {
      translateY: [-20, 0],
      opacity: [0, 1],
      duration: 600,
      easing: "easeOutExpo"
    })

    // Cards Animation
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

  const toggleSetting = (key) => {
    setSettings((prev) => ({ ...prev, [key]: !prev[key] }))
  }

  const handlePublish = () => {
    if (!settings.systemMessage.trim()) return
    setPublished(true)
    setSettings((prev) => ({ ...prev, systemMessage: "" }))
    setToast(true)
    setTimeout(() => setToast(false), 3000)
  }

  const toggleItems = [
    {
      key: "mascot",
      label: "Mascota virtual",
      desc: "Muestra la mascota interactiva en el panel",
      icon: Dog,
      // colores
      headerBg: "bg-[var(--color-green-light)]",
      headerText: "text-[var(--color-green-dark)]",
    },
    {
      key: "recommendations",
      label: "Recomendaciones",
      desc: "Sugiere contenido relevante al usuario",
      icon: Lightbulb,
      headerBg: "bg-[var(--color-blue-light)]",
      headerText: "text-[var(--color-blue-dark)]",
    },
  ]

  return (
    <div className="mx-auto space-y-6">

      {/* Toast Notificación */}
      <div
        className={`
          fixed top-5 right-5 z-50
          bg-[var(--color-green-dark)] text-white
          text-xs font-semibold px-5 py-2.5 rounded-lg shadow-lg
          flex items-center gap-2
          transition-all duration-300 ease-out
          ${toast ? "translate-y-0 opacity-100" : "-translate-y-16 opacity-0"}
        `}
      >
        <span className="bg-white/20 rounded-full w-4 h-4 flex items-center justify-center text-[10px]">✓</span>
        Aviso publicado exitosamente
      </div>

      {/* Header */}
      <div ref={headerRef} className="flex items-center gap-2">
        <div className="w-8 h-8 rounded-xl bg-[var(--color-yellow-light)] flex items-center justify-center">
          <SettingsIcon size={18} className="text-[var(--color-yellow-dark)]" />
        </div>
        <div>
          <h2 className="text-xl font-bold text-[var(--color-dark)] tracking-tight">
            Configuración
          </h2>
          <p className="text-xs text-[var(--color-gray-custom)]">
            Administra las funciones globales de la plataforma
          </p>
        </div>
      </div>

      <div ref={cardsRef} className="space-y-6">
        {/* Card: Funciones globales */}
        <div className="bg-white rounded-2xl border border-gray-200 shadow-sm overflow-hidden">
          <div className="bg-[var(--color-neutral-light)] border-b border-gray-100 px-5 py-3 flex items-center gap-2">
            <SettingsIcon size={14} className="text-[var(--color-gray-custom)]" />
            <h3 className="text-xs font-semibold text-[var(--color-gray-custom)] uppercase tracking-widest">
              Funciones del Sistema
            </h3>
          </div>

          <div className="px-5">
            {toggleItems.map((item, i) => {
              const Icon = item.icon
              return (
                <div
                  key={item.key}
                  className={`flex items-center justify-between py-5 ${i !== 0 ? "border-t border-gray-100" : ""}`}
                >
                  {/* Icono colorido + texto */}
                  <div className="flex items-center gap-4">
                    <div className={`w-10 h-10 rounded-xl ${item.headerBg} flex items-center justify-center transition-transform hover:scale-105 duration-200`}>
                      <Icon size={18} className={item.headerText} />
                    </div>
                    <div>
                      <p className="text-sm font-bold text-[var(--color-dark)]">{item.label}</p>
                      <p className="text-xs text-[var(--color-gray-custom)] mt-0.5">{item.desc}</p>
                    </div>
                  </div>

                  {/* Toggle pill */}
                  <button
                    onClick={() => toggleSetting(item.key)}
                    aria-label={`Toggle ${item.label}`}
                    className={`
                      relative w-12 h-6 rounded-full transition-colors duration-300 ease-out
                      focus:outline-none focus:ring-2 focus:ring-[var(--color-green-light)] focus:ring-offset-2
                      ${settings[item.key] ? "bg-[var(--color-green-dark)]" : "bg-gray-200 hover:bg-gray-300"}
                    `}
                  >
                    <span
                      className={`
                        absolute top-0.5 left-0.5
                        w-5 h-5 bg-white rounded-full shadow-sm
                        transition-transform duration-300 ease-out
                        ${settings[item.key] ? "translate-x-6" : "translate-x-0"}
                      `}
                    />
                  </button>
                </div>
              )
            })}
          </div>
        </div>

        {/* Card: Aviso del sistema */}
        <div className="bg-white rounded-2xl border border-gray-200 shadow-sm overflow-hidden">
          <div className="bg-[var(--color-blue-light)] border-b border-[var(--color-blue-dark)]/10 px-5 py-3 flex items-center gap-2">
            <Bell size={14} className="text-[var(--color-blue-dark)]" />
            <h3 className="text-xs font-semibold text-[var(--color-blue-dark)] uppercase tracking-widest">
              Aviso Global
            </h3>
          </div>

          <div className="p-5 flex flex-col md:flex-row gap-6">
            <div className="flex-1 space-y-4">
              <div>
                <label className="text-sm font-semibold text-[var(--color-dark)] mb-1 block">Mensaje del sistema</label>
                <p className="text-xs text-[var(--color-gray-custom)] mb-3">
                  Este mensaje aparecerá en la parte superior del dashboard de todos los usuarios activos.
                </p>
              </div>

              <textarea
                rows={3}
                placeholder="Escribe un anuncio importante..."
                value={settings.systemMessage}
                onChange={(e) =>
                  setSettings((prev) => ({ ...prev, systemMessage: e.target.value }))
                }
                className="
                  w-full border border-gray-200 rounded-xl px-4 py-3 text-sm
                  bg-[var(--color-neutral-light)] text-[var(--color-dark)]
                  placeholder-gray-400 resize-none
                  focus:outline-none focus:border-[var(--color-blue-dark)]
                  focus:ring-2 focus:ring-[var(--color-blue-light)]
                  transition-all duration-200
                "
              />

              <div className="flex items-center justify-between pt-2">
                <span className="text-xs text-[var(--color-gray-custom)] font-medium">
                  {settings.systemMessage.length} caracteres
                </span>

                <button
                  onClick={handlePublish}
                  disabled={!settings.systemMessage.trim()}
                  className={`
                    px-6 py-2.5 rounded-xl text-xs font-bold text-white
                    transition-all duration-200 active:scale-95 flex items-center gap-2
                    ${settings.systemMessage.trim()
                      ? "bg-[var(--color-blue-dark)] shadow-md shadow-blue-200 hover:brightness-110 cursor-pointer"
                      : "bg-gray-200 text-gray-400 cursor-not-allowed"}
                  `}
                >
                  <Bell size={14} />
                  Publicar
                </button>
              </div>
            </div>

            {/* Preview Visual */}
            <div className="w-full md:w-64 bg-gray-50 rounded-xl p-4 border border-gray-100 flex flex-col justify-center items-center text-center">
              <span className="text-[10px] text-gray-400 uppercase tracking-wider font-bold mb-2">Vista Previa</span>
              {settings.systemMessage.trim() ? (
                <div className="bg-[var(--color-blue-dark)] text-white text-xs px-4 py-2 rounded-lg shadow-sm w-full">
                  {settings.systemMessage}
                </div>
              ) : (
                <div className="text-gray-300 text-xs italic">
                  Escribe un mensaje para ver cómo quedará...
                </div>
              )}
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}
