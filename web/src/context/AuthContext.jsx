import React, { createContext, useState } from 'react';
import { isAuthenticated, login as svcLogin, logout as svcLogout } from '../services/authService';

export const AuthContext = createContext();

export function AuthProvider({ children }){
  const [user, setUser] = useState(isAuthenticated() ? { name: 'admin' } : null);

  async function login(email, password){ const res = await svcLogin(email,password); setUser({ name: 'admin' }); return res; }
  function logout(){ svcLogout(); setUser(null); }

  return <AuthContext.Provider value={{ user, login, logout }}>{children}</AuthContext.Provider>
}
