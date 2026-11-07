#!/usr/bin/bash
#
# Elegí un proyecto con fzf y abrí su sesión de tmux, o saltá a ella si ya existe.
# Si existe scripts/<proyecto>.sh, se ejecuta al crear la sesión.
#
# Basado en tmux-sessionizer de ThePrimeagen: reescrito, pero conserva su lógica central.

tmux_dir="${HOME}/.config/tmux"

# Lista los proyectos y marca con "->" los que ya tienen sesión.
list_projects() {
  local dirs_file="${tmux_dir}/sessionizer.dirs"
  local dirs dir

  # Carpetas donde buscar: una por línea en sessionizer.dirs (no se versiona)
  if [[ -f $dirs_file ]]; then
    mapfile -t dirs < <(grep -v '^\s*#' "$dirs_file" | sed "s|^~|$HOME|" | grep .)
  else
    dirs=(~/Documentos ~/Documents ~/Projects)
  fi

  find "${dirs[@]}" -mindepth 1 -maxdepth 1 -type d 2>/dev/null | while read -r dir; do
    if echo "$active_sessions" | grep -Fxq -- "$(basename "$dir" | tr . _)"; then
      echo "-> $dir"
    else
      echo "   $dir"
    fi
  done
}

create_session() {
  tmux new-session -ds "$session" -c "$project"
  if [[ -f $project_script ]]; then
    tmux send-keys -t "$session" "bash $project_script" C-m
  fi
}

active_sessions=$(tmux list-sessions -F "#{session_name}" 2>/dev/null)

if [[ $# -eq 1 ]]; then
  project=$1
else
  project=$(list_projects | fzf | sed 's/-> //; s/   //')
fi

[[ -n $project ]] || exit 0

session=$(basename "$project" | tr . _)
project_script="${tmux_dir}/scripts/${session}.sh"

# Fuera de tmux y sin servidor corriendo: no hay cliente al que cambiar.
if [[ -z $TMUX && -z $(pgrep tmux) ]]; then
  create_session
  tmux attach-session -t "$session"
  exit 0
fi

tmux has-session -t="$session" 2>/dev/null || create_session
tmux switch-client -t "$session" 2>/dev/null || tmux attach-session -t "$session"
