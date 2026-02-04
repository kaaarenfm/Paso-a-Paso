import { Routes, Route, Navigate } from "react-router-dom"

import Landing from "./pages/Landing"
import Login from "./pages/admin/AdminLogin"
import Registro from "./pages/admin/Register"

import AdminLayout from "./layouts/AdminLayout"
import Dashboard from "./pages/admin/Dashboard"
import Categories from "./pages/admin/content/Categories"
import RoutineTypes from "./pages/admin/content/RoutineTypes"
import Recommendations from "./pages/admin/content/Recommendations"
import MotivationalPhrases from "./pages/admin/content/MotivationalPhrases"
import PublicRoutines from "./pages/admin/moderation/PublicRoutines"
import Comments from "./pages/admin/moderation/Comments"
import Reports from "./pages/admin/moderation/Reports"  
import Freemium from "./pages/admin/Freemium"
import Settings from "./pages/admin/Settings"

export default function App() {
  return (
    <Routes>
      {/* Public */}
      <Route path="/" element={<Landing />} />
      <Route path="/login" element={<Login />} />
      <Route path="/registro" element={<Registro />} />

      {/* Admin */}
      <Route path="/admin" element={<AdminLayout />}>
        <Route path="dashboard" element={<Dashboard />} />
        <Route path="content/categories" element={<Categories />} />
        <Route path="content/types" element={<RoutineTypes />} />
        <Route path="content/recommendations" element={<Recommendations />} />
        <Route path="content/phrases" element={<MotivationalPhrases />} />
        <Route path="moderation/routines" element={<PublicRoutines />} />
        <Route path="moderation/comments" element={<Comments />} />
        <Route path="moderation/reports" element={<Reports />} />
        <Route path="freemium" element={<Freemium />} />
        <Route path="settings" element={<Settings />} />

      </Route>
    </Routes>
  )
}
