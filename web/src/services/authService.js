// Simple auth service placeholder
export const login = () => {}
export async function logout(){ localStorage.removeItem('token'); }
export function isAuthenticated(){ return !!localStorage.getItem('token'); }
