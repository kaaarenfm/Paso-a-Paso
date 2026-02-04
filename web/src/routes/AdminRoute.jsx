import React from 'react';
import { Routes, Route } from 'react-router-dom';
import AdminLayout from '../layouts/AdminLayout';

import Dashboard from '../pages/admin/Dashboard';
import ContentManagement from '../pages/admin/content/Categories';
import PublicModeration from '../pages/admin/moderation/PublicRoutines';
import Freemium from '../pages/admin/Freemium';
import Settings from '../pages/admin/Settings';

export default function AdminRoute(){
  return (
    <Routes>
      <Route element={<AdminLayout />}>
        <Route path="dashboard" element={<Dashboard />} />
        <Route path="content" element={<ContentManagement />} />
        <Route path="moderation" element={<PublicModeration />} />
        <Route path="freemium" element={<Freemium />} />
        <Route path="system" element={<Settings />} />
      </Route>
    </Routes>
  );
}
