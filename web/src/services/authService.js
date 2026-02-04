// Simple auth service placeholder
export async function login(email, password){ localStorage.setItem('token','demo'); return { token: 'demo' }; }
export async function logout(){ localStorage.removeItem('token'); }
export function isAuthenticated(){ return !!localStorage.getItem('token'); }
