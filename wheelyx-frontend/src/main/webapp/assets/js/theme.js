/**
 * Wheelyx Platform — Theme & UI Core Scripts
 * Handles Dark/Light Mode persistence, City-to-Place AJAX dropdowns, and UI micro-interactions.
 */

(function () {
    const THEME_STORAGE_KEY = 'wheelyx_theme_mode';

    // 1. Initialize Theme from localStorage or System Preference
    function initTheme() {
        const savedTheme = localStorage.getItem(THEME_STORAGE_KEY);
        if (savedTheme) {
            applyTheme(savedTheme);
        } else {
            const prefersDark = window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches;
            applyTheme(prefersDark ? 'dark' : 'light');
        }
    }

    function applyTheme(theme) {
        document.documentElement.setAttribute('data-theme', theme);
        localStorage.setItem(THEME_STORAGE_KEY, theme);
        updateThemeToggleButtons(theme);
    }

    function toggleTheme() {
        const currentTheme = document.documentElement.getAttribute('data-theme') || 'light';
        const newTheme = (currentTheme === 'dark') ? 'light' : 'dark';
        applyTheme(newTheme);
    }

    function updateThemeToggleButtons(theme) {
        document.querySelectorAll('.theme-toggle-btn').forEach(btn => {
            if (theme === 'dark') {
                btn.innerHTML = '<i class="bi bi-sun-fill text-warning"></i> <span>Light</span>';
                btn.setAttribute('title', 'Switch to Light Mode');
            } else {
                btn.innerHTML = '<i class="bi bi-moon-stars-fill text-primary"></i> <span>Dark</span>';
                btn.setAttribute('title', 'Switch to Dark Mode');
            }
        });
    }

    // Run theme initialization immediately on load to prevent flash of wrong theme
    initTheme();

    document.addEventListener('DOMContentLoaded', function () {
        // Attach click listener to any theme toggle buttons
        document.querySelectorAll('.theme-toggle-btn').forEach(btn => {
            btn.addEventListener('click', toggleTheme);
        });

        // 2. Dynamic City -> Places AJAX Cascader
        const citySelectors = document.querySelectorAll('select[data-cascade-places]');
        citySelectors.forEach(select => {
            const targetPlaceSelectId = select.getAttribute('data-cascade-places');
            const targetSelect = document.getElementById(targetPlaceSelectId);

            if (targetSelect) {
                select.addEventListener('change', function () {
                    const cityId = this.value;
                    targetSelect.innerHTML = '<option value="">Loading locations...</option>';
                    targetSelect.disabled = true;

                    if (!cityId || cityId === 'ALL') {
                        targetSelect.innerHTML = '<option value="">All Locations</option>';
                        targetSelect.disabled = false;
                        return;
                    }

                    const placesApiUrl = (typeof window.getWheelyxApiUrl === 'function')
                        ? window.getWheelyxApiUrl(`/api/city-places?cityId=${cityId}`)
                        : `${window.WHEELYX_CONTEXT_PATH || ''}/api/city-places?cityId=${cityId}`;
                    fetch(placesApiUrl)
                        .then(res => res.json())
                        .then(places => {
                            targetSelect.innerHTML = '<option value="">Select Location / Place</option>';
                            places.forEach(p => {
                                const opt = document.createElement('option');
                                opt.value = p.id;
                                opt.textContent = p.placeName + (p.landmarkDetails ? ' (' + p.landmarkDetails + ')' : '');
                                targetSelect.appendChild(opt);
                            });
                            targetSelect.disabled = false;
                        })
                        .catch(err => {
                            console.error('Error fetching places:', err);
                            targetSelect.innerHTML = '<option value="">Failed to load locations</option>';
                            targetSelect.disabled = false;
                        });
                });
            }
        });

        // 3. Auto-dismiss alerts after 5 seconds
        document.querySelectorAll('.alert-auto-dismiss').forEach(alert => {
            setTimeout(() => {
                const bsAlert = bootstrap.Alert.getOrCreateInstance(alert);
                if (bsAlert) bsAlert.close();
            }, 5000);
        });
    });
})();
