export default function RecommendationEditor() {
  return (
    <div className="space-y-4">
      <label className="block text-sm text-gray-600">
        Texto base de recomendaciones
      </label>

      <textarea
        rows={5}
        placeholder="Ejemplo: Intenta comenzar con hábitos pequeños..."
        className="w-full border rounded-md p-3 text-sm focus:ring-2 focus:ring-indigo-500"
      />

      <button
        className="bg-indigo-600 text-white px-4 py-2 rounded-md text-sm hover:bg-indigo-700"
      >
        Guardar
      </button>
    </div>
  )
}
