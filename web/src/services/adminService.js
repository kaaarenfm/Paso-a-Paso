const KEY = 'admin-mock-v1';

const defaultState = {
  metrics: {
    totalUsers: 123,
    totalRoutines: 456,
    publicRoutines: 300,
    privateRoutines: 156,
    freeUsers: 90,
    premiumUsers: 33
  },
  recent: [
    { id:1, text: 'Usuario X creó rutina "Mañana en 5"', date: Date.now() - 1000*60*60 },
    { id:2, text: 'Rutina pública aprobada: "Cardio 10"', date: Date.now() - 1000*60*30 }
  ],
  categories: ['Cardio','Mindfulness'],
  types: ['Mañana','Tarde','Noche'],
  phrases: [{id:1, text:'Sigue así', active:true}],
  freemium: { trialDays: 14, freeLimits: { routinesPerDay: 3 }, activeFeatures: {} },
  system: { virtualPet: true, recommendations: true, notices: [] }
};

function read() {
  const raw = localStorage.getItem(KEY);
  if (!raw) localStorage.setItem(KEY, JSON.stringify(defaultState));
  return JSON.parse(localStorage.getItem(KEY));
}

function write(state) {
  localStorage.setItem(KEY, JSON.stringify(state));
  return state;
}

export function getMetrics() { return Promise.resolve(read().metrics); }
export function getRecentActivity() { return Promise.resolve(read().recent); }

export function getCategories(){ return Promise.resolve(read().categories); }
export function addCategory(item){ const s = read(); s.categories.push(item); write(s); return Promise.resolve(); }
export function deleteCategory(idx){ const s = read(); s.categories.splice(idx,1); write(s); return Promise.resolve(); }

export function getTypes(){ return Promise.resolve(read().types); }
export function addType(t){ const s = read(); s.types.push(t); write(s); return Promise.resolve(); }

export function getPhrases(){ return Promise.resolve(read().phrases); }
export function addPhrase(p){ const s = read(); s.phrases.push(p); write(s); return Promise.resolve(); }
export function togglePhrase(id){ const s = read(); const ph = s.phrases.find(x=>x.id===id); if(ph) ph.active = !ph.active; write(s); return Promise.resolve(); }

export function getFreemium(){ return Promise.resolve(read().freemium); }
export function updateFreemium(payload){ const s = read(); s.freemium = {...s.freemium,...payload}; write(s); return Promise.resolve(); }

export function getSystem(){ return Promise.resolve(read().system); }
export function updateSystem(payload){ const s = read(); s.system = {...s.system,...payload}; write(s); return Promise.resolve(); }

// add more helpers for moderation if needed