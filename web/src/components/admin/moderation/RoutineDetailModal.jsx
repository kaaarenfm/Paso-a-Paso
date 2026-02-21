import { X, MessageCircle, Heart, User, Calendar } from "lucide-react"
import { useEffect, useRef } from "react"
import { animate } from "animejs"

export default function RoutineDetailModal({ routine, onClose }) {
    const modalRef = useRef(null)
    const contentRef = useRef(null)

    useEffect(() => {
        // Animación de entrada
        animate(modalRef.current, {
            opacity: [0, 1],
            duration: 300,
            easing: "easeOutQuad"
        })

        animate(contentRef.current, {
            scale: [0.9, 1],
            opacity: [0, 1],
            translateY: [20, 0],
            duration: 400,
            delay: 100,
            easing: "easeOutExpo"
        })
    }, [])

    const handleClose = () => {
        // Animación de salida (opcional, pero para simplicidad cerramos directo por ahora en React)
        onClose()
    }

    if (!routine) return null

    // Mock comments si no existen
    const comments = routine.commentsList || [
        { id: 1, user: "Juan Pérez", text: "¡Excelente rutina! Me sirvió mucho.", date: "Hace 10 min" },
        { id: 2, user: "Maria L.", text: "Un poco intensa para mi gusto, pero buena.", date: "Hace 1 hora" },
        { id: 3, user: "Carlos Gym", text: "¿Se puede hacer sin pesas?", date: "Hace 2 horas" },
    ]

    return (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4">
            {/* Backdrop */}
            <div
                ref={modalRef}
                onClick={handleClose}
                className="absolute inset-0 bg-black/40 backdrop-blur-sm transition-opacity"
            />

            {/* Modal Content */}
            <div
                ref={contentRef}
                className="relative bg-white rounded-2xl shadow-2xl w-full max-w-2xl max-h-[85vh] flex flex-col overflow-hidden"
            >
                {/* Header con Imagen de fondo/Gradiente */}
                <div className="relative h-32 bg-gradient-to-r from-[var(--color-blue-dark)] to-purple-600 flex items-end p-6">
                    <button
                        onClick={handleClose}
                        className="absolute top-4 right-4 p-2 bg-black/20 hover:bg-black/40 text-white rounded-full transition-colors"
                    >
                        <X size={20} />
                    </button>

                    <div className="flex items-center gap-4 text-white translate-y-8">
                        <div className="w-20 h-20 rounded-2xl bg-white p-1 shadow-lg">
                            <div className="w-full h-full rounded-xl bg-gray-100 flex items-center justify-center overflow-hidden">
                                {routine.authorAvatar ? (
                                    <img src={routine.authorAvatar} className="w-full h-full object-cover" />
                                ) : (
                                    <User size={32} className="text-gray-400" />
                                )}
                            </div>
                        </div>
                        <div className="mb-2">
                            <h2 className="text-2xl font-bold leading-none">{routine.title}</h2>
                            <p className="text-white/80 text-sm mt-1 flex items-center gap-2">
                                Por {routine.author} • <Calendar size={12} /> {routine.date}
                            </p>
                        </div>
                    </div>
                </div>

                {/* Body Scrollable */}
                <div className="flex-1 overflow-y-auto pt-10 px-6 pb-6">
                    {/* Stats Bar */}
                    <div className="flex gap-4 mb-6 border-b border-gray-100 pb-4">
                        <div className="flex items-center gap-1.5 text-pink-500 font-semibold text-sm">
                            <Heart size={16} fill="currentColor" />
                            {routine.likes} Likes
                        </div>
                        <div className="flex items-center gap-1.5 text-blue-500 font-semibold text-sm">
                            <MessageCircle size={16} />
                            {routine.comments} Comentarios
                        </div>
                    </div>

                    <div className="space-y-6">
                        <section>
                            <h3 className="text-sm font-bold text-[var(--color-gray-custom)] uppercase tracking-wider mb-2">
                                Descripción
                            </h3>
                            <p className="text-[var(--color-dark)] leading-relaxed">
                                {routine.description}
                            </p>
                        </section>

                        <section>
                            <h3 className="text-sm font-bold text-[var(--color-gray-custom)] uppercase tracking-wider mb-3">
                                Etiquetas
                            </h3>
                            <div className="flex flex-wrap gap-2">
                                {routine.tags?.map((tag, i) => (
                                    <span key={i} className="px-3 py-1 rounded-full bg-gray-100 text-gray-600 text-xs font-medium">
                                        #{tag}
                                    </span>
                                ))}
                            </div>
                        </section>

                        {/* Sección de Comentarios */}
                        <section className="pt-4 border-t border-gray-100">
                            <h3 className="text-sm font-bold text-[var(--color-gray-custom)] uppercase tracking-wider mb-4">
                                Comentarios recientes
                            </h3>

                            <div className="space-y-4">
                                {comments.map((comment) => (
                                    <div key={comment.id} className="flex gap-3 items-start">
                                        <div className="w-8 h-8 rounded-full bg-gray-200 flex items-center justify-center flex-shrink-0 text-gray-500">
                                            <User size={14} />
                                        </div>
                                        <div className="bg-gray-50 rounded-2xl rounded-tl-none p-3 flex-1">
                                            <div className="flex justify-between items-center mb-1">
                                                <span className="font-bold text-xs text-[var(--color-dark)]">{comment.user}</span>
                                                <span className="text-[10px] text-gray-400">{comment.date}</span>
                                            </div>
                                            <p className="text-sm text-gray-600">{comment.text}</p>
                                        </div>
                                    </div>
                                ))}
                            </div>
                        </section>
                    </div>
                </div>
            </div>
        </div>
    )
}
