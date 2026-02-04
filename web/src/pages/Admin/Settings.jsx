import { useState } from "react"

export default function Settings() {
  const [settings, setSettings] = useState({
    mascot: true,
    recommendations: true,
    systemMessage: "",
  })
  const [published, setPublished] = useState(false)

  const toggleSetting = (key) => {
    setSettings((prev) => ({ ...prev, [key]: !prev[key] }))
  }

  const handlePublish = () => {
    if (!settings.systemMessage.trim()) return
    setPublished(true)
    setSettings((prev) => ({ ...prev, systemMessage: "" }))
    setTimeout(() => setPublished(false), 3000)
  }

  const toggleItems = [
    {
      key: "mascot",
      label: "Mascota virtual",
      desc: "Muestra la mascota interactiva en el panel",
      // colores: fondo del card header y del icono
      headerBg: "bg-[var(--color-green-light)]",
      headerText: "text-[var(--color-green-dark)]",
      borderColor: "border-[var(--color-green-light)]",
    },
    {
      key: "recommendations",
      label: "Recomendaciones",
      desc: "Sugiere contenido relevante al usuario",
      headerBg: "bg-[var(--color-blue-light)]",
      headerText: "text-[var(--color-blue-dark)]",
      borderColor: "border-[var(--color-blue-light)]",
    },
  ]

  return (
    <div className="bg-[var(--color-neutral-bg)] px-2 py-4">
      <div className="mx-auto space-y-2">

        {/* Toast */}
        <div
          className={`
            fixed top-5 right-5 z-50
            bg-[var(--color-green-dark)] text-white
            text-xs font-semibold px-5 py-2.5 rounded-lg shadow-lg
            flex items-center gap-2
            transition-all duration-300 ease-out
            ${published ? "translate-y-0 opacity-100" : "-translate-y-16 opacity-0"}
          `}
        >
          <span>✓</span> Aviso publicado exitosamente
        </div>

        {/* Header */}
        <div>
          <h2 className="text-xl font-bold text-[var(--color-dark)] tracking-tight">
            Configuración del sistema
          </h2>
          <p className="text-xs text-[var(--color-gray-custom)] mt-1">
            Administra las funciones globales de la plataforma
          </p>
        </div>

        {/* Card: Funciones globales */}
        <div className="bg-white rounded-2xl border border-gray-200 shadow-sm overflow-hidden">
          <div className="bg-[var(--color-neutral-light)] border-b border-gray-100 px-5 py-3">
            <h3 className="text-xs font-semibold text-[var(--color-gray-custom)] uppercase tracking-widest">
              Funciones globales
            </h3>
          </div>

          <div className="px-5">
            {toggleItems.map((item, i) => (
              <div
                key={item.key}
                className={`flex items-center justify-between py-4 ${i !== 0 ? "border-t border-gray-100" : ""}`}
              >
                {/* Icono colorido + texto */}
                <div className="flex items-center gap-3">
                  <div className={`w-9 h-9 rounded-xl ${item.headerBg} flex items-center justify-center`}>
                    <span className={`text-base ${item.headerText}`}>
                      {item.key === "mascot" ? "🐾" : "💡"}
                    </span>
                  </div>
                  <div>
                    <p className="text-sm font-medium text-[var(--color-dark)]">{item.label}</p>
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
                    ${settings[item.key] ? "bg-[var(--color-green-dark)]" : "bg-gray-300"}
                  `}
                >
                  <span
                    className={`
                      absolute top-0.5 left-0.5
                      w-5 h-5 bg-white rounded-full shadow
                      transition-transform duration-300 ease-out
                      ${settings[item.key] ? "translate-x-6" : "translate-x-0"}
                    `}
                  />
                </button>
              </div>
            ))}
          </div>
        </div>

        {/* Card: Aviso del sistema — fondo azul suave */}
        <div className="bg-[var(--color-blue-light)] rounded-2xl border border-[var(--color-blue-light)] shadow-sm overflow-hidden">
          <div className="bg-[var(--color-blue-dark)] px-5 py-3">
            <h3 className="text-xs font-semibold text-white uppercase tracking-widest">
              Aviso del sistema
            </h3>
          </div>

          <div className="p-5 space-y-3">
            <textarea
              rows={4}
              placeholder="Mensaje que verán todos los usuarios..."
              value={settings.systemMessage}
              onChange={(e) =>
                setSettings((prev) => ({ ...prev, systemMessage: e.target.value }))
              }
              className="
                w-full border border-white rounded-xl px-4 py-2.5 text-sm
                bg-white text-[var(--color-dark)]
                placeholder-gray-400 resize-none
                focus:outline-none focus:border-[var(--color-blue-dark)]
                focus:ring-2 focus:ring-white
                transition-all duration-200
              "
            />

            <div className="flex items-center justify-between">
              <span className="text-xs text-[var(--color-blue-dark)] font-medium">
                {settings.systemMessage.length} caracteres
              </span>

              <button
                onClick={handlePublish}
                disabled={!settings.systemMessage.trim()}
                className={`
                  px-5 py-2 rounded-lg text-xs font-semibold text-white
                  transition-all duration-200 active:scale-95
                  ${settings.systemMessage.trim()
                    ? "bg-[var(--color-blue-dark)] shadow-md hover:brightness-110 cursor-pointer"
                    : "bg-gray-300 cursor-not-allowed"}
                `}
              >
                Publicar aviso
              </button>
            </div>
          </div>
        </div>

      </div>
    </div>
  )
}