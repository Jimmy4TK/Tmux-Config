# Tmux-Config

Mi configuración de tmux. Forma parte de mis dotfiles de [BSPWM](https://github.com/Jimmy4TK/BSPWM), pero se puede usar sola.

![tmux con zsh](images/Tmux-Zsh.png)

## Incluye

- **Atajos con `Alt` y sin prefijo:** `Alt+c` nueva ventana, `Alt+w` cerrarla, `Alt+s` / `Alt+Shift+s` dividir, `Alt+h/j/k/l` moverse entre paneles, `Alt+flechas` redimensionar, `Alt+1..0` ir a una ventana y `Alt+r` recargar la config.
- **Modo copia estilo vi** con [tmux-yank](https://github.com/tmux-plugins/tmux-yank) para copiar al portapapeles.
- **Tema propio** con paleta Rosé Pine y barra de estado en dos píldoras: a la izquierda las ventanas, a la derecha el programa actual (o el tipo de archivo en Neovim, con [Nvim-Config](https://github.com/Jimmy4TK/Nvim-Config)) y la ruta. Los bordes redondeados requieren una Nerd Font.
- **Sessionizer** (`sessionizer.sh`): elegís un proyecto con `fzf` y abre o salta a su sesión. Si existe `scripts/<proyecto>.sh`, lo ejecuta al crear la sesión.

## Instalación

Requiere tmux 3.2 o superior, `git` y `fzf` (para el sessionizer).

```sh
git clone https://github.com/Jimmy4TK/Tmux-Config ~/.config/tmux
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
tmux
```

Adentro de tmux, `Alt+i` instala los plugins (`Alt+u` los actualiza, `Alt+Shift+u` borra los que ya no estén en la config).

## Sessionizer

Por defecto busca proyectos en `~/Documentos`, `~/Documents` y `~/Projects`. Para usar otras carpetas, creá `~/.config/tmux/sessionizer.dirs` con una por línea:

```
~/Documentos/Proyectos
~/trabajo
```

Ese archivo y la carpeta `scripts/` no se versionan, porque son de cada máquina.

## Créditos y licencia

Mi configuración está bajo la licencia [BSD 2-Clause](LICENSE), con esta salvedad:

- `sessionizer.sh` está basado en [tmux-sessionizer](https://github.com/ThePrimeagen/tmux-sessionizer) de ThePrimeagen, que no publica una licencia. Lo reescribí y le agregué funciones, pero conserva su lógica central. Ese material sigue siendo de su autor y BSD 2-Clause no da permisos sobre él.
