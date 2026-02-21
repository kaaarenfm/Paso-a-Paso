import { X, User, ClipboardList, Globe, Gem } from "lucide-react"
import { useEffect, useRef } from "react"
import { animate } from "animejs"
import DataTable from "./DataTable"

const MOCK_DATA = {
    users: {
        columns: [
            { header: "ID", accessor: "id" },
            { header: "Nombre", accessor: "name" },
            { header: "Email", accessor: "email" },
            {
                header: "Rol", accessor: "role", render: (val) => (
                    <span className={`px-2 py-0.5 rounded-full text-[10px] font-bold ${val === 'Admin' ? 'bg-purple-100 text-purple-600' : 'bg-blue-100 text-blue-600'}`}>
                        {val}
                    </span>
                )
            },
        ],
        data: [
            { id: "#001", name: "Anita", email: "anita@pasoapaso.com", role: "Admin" },
            { id: "#002", name: "Juan Pérez", email: "juan@gmail.com", role: "Usuario" },
            { id: "#003", name: "Maria L.", email: "maria@outlook.com", role: "Usuario" },
        ]
    },
    routines: {
        columns: [
            { header: "Nombre", accessor: "title" },
            { header: "Autor", accessor: "author" },
            { header: "Likes", accessor: "likes" },
            { header: "Fecha", accessor: "date" },
        ],
        data: [
            { title: "Yoga Matutino", author: "Roberto G.", likes: 45, date: "20/02/2026" },
            { title: "HIIT Intenso", author: "Carlos Gym", likes: 128, date: "19/02/2026" },
            { title: "Estiramiento", author: "Lucia S.", likes: 23, date: "18/02/2026" },
        ]
    },
    publicRoutines: {
        columns: [
            { header: "Rutina", accessor: "title" },
            { header: "Categoría", accessor: "category" },
            { header: "Vistas", accessor: "views" },
        ],
        data: [
            { title: "Meditación Guiada", category: "Mindfulness", views: 1240 },
            { title: "Core 15 min", category: "Fitness", views: 890 },
            { title: "Power Yoga", category: "Yoga", views: 3400 },
        ]
    },
    premiumUsers: {
        columns: [
            { header: "Usuario", accessor: "name" },
            { header: "Plan", accessor: "plan" },
            { header: "Vencimiento", accessor: "expiry" },
        ],
        data: [
            { name: "Sonia Fit", plan: "Anual", expiry: "12/12/2026" },
            { name: "Marco Polo", plan: "Mensual", expiry: "05/03/2026" },
            { name: "Elena Q.", plan: "Anual", expiry: "20/01/2027" },
        ]
    }
}

const ICONS = {
    users: User,
    routines: ClipboardList,
    publicRoutines: Globe,
    premiumUsers: Gem
}

export default function StatDetailsModal({ type, title, onClose }) {
    const modalRef = useRef(null)
    const contentRef = useRef(null)
    const Icon = ICONS[type] || Users

    useEffect(() => {
        animate(modalRef.current, {
            opacity: [0, 1],
            duration: 300,
            easing: "easeOutQuad"
        })

        animate(contentRef.current, {
            scale: [0.95, 1],
            opacity: [0, 1],
            translateY: [20, 0],
            duration: 400,
            easing: "easeOutExpo"
        })
    }, [])

    const details = MOCK_DATA[type] || { columns: [], data: [] }

    return (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4">
            {/* Backdrop */}
            <div
                ref={modalRef}
                onClick={onClose}
                className="absolute inset-0 bg-black/40 backdrop-blur-sm"
            />

            {/* Content */}
            <div
                ref={contentRef}
                className="relative bg-white rounded-3xl shadow-2xl w-full max-w-2xl overflow-hidden flex flex-col max-h-[85vh]"
            >
                {/* Header */}
                <div className="p-6 flex items-center justify-between border-b border-gray-100 bg-gray-50/10">
                    <div className="flex items-center gap-4">
                        <div className="p-3 bg-[var(--color-neutral-bg)] rounded-2xl text-[var(--color-dark)] shadow-sm">
                            <Icon size={24} />
                        </div>
                        <div>
                            <h2 className="text-xl font-bold text-[var(--color-dark)]">{title}</h2>
                            <p className="text-xs text-[var(--color-gray-custom)] font-medium uppercase tracking-wider mt-0.5">
                                Detalle de registros recientes
                            </p>
                        </div>
                    </div>
                    <button
                        onClick={onClose}
                        className="p-2.5 hover:bg-gray-100 text-gray-400 hover:text-gray-600 rounded-xl transition-all"
                    >
                        <X size={20} />
                    </button>
                </div>

                {/* Scrollable Table */}
                <div className="flex-1 overflow-y-auto p-4">
                    <div className="rounded-2xl border border-gray-100 overflow-hidden shadow-sm bg-white">
                        <DataTable columns={details.columns} data={details.data} />
                    </div>
                </div>

                {/* Footer */}
                <div className="p-4 bg-gray-50/50 border-t border-gray-100 text-center">
                    <p className="text-[10px] text-[var(--color-gray-custom)] font-medium">
                        Paso-a-Paso Admin Panel • 2026
                    </p>
                </div>
            </div>
        </div>
    )
}
