function anote
    # ... (fzf selection logic remains the same) ...
    set -l selection (ag -i --ignore-dir .obsidian . ~/Notes | \
        fzf --delimiter=':' \
            --preview 'bat --style=numbers --color=always --highlight-line {2} {1}' \
            --preview-window 'right:50%:wrap')

    # ... (parsing logic remains the same) ...
    if test -z "$selection"
        echo "No selection made."
        return
    end
    set -l parts (string split ':' --max 2 "$selection")
    set -l file_path $parts[1]
    set -l line_number $parts[2]

    # --- THIS VARIABLE IS NOW DEFINED EARLIER ---
    set -l root_path (realpath ~/Notes)

    if not set -q TMUX
        # We are outside tmux
        set -l session_name "notes"
        if tmux has-session -t="$session_name" 2>/dev/null
            echo "Opening note in existing '$session_name' session..."
            # --- THIS LINE IS CORRECTED ---
            # Add -c flag to set the working directory for the new window
            tmux new-window -t "$session_name" -c "$root_path" -n "Note" "nvim +$line_number '$file_path'"
        else
            echo "Creating new '$session_name' session..."
            # The -c flag was already correctly used here
            tmux new-session -ds "$session_name" -c "$root_path" "nvim +$line_number '$file_path'"
        end
        tmux attach-session -t "$session_name"
    else
        # We are inside tmux
        # --- THIS PART IS CORRECTED ---
        # Change to the notes directory first, then replace the shell with nvim
        cd "$root_path" && exec nvim "+$line_number" "$file_path"
    end
end
