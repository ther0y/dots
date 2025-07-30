function qnote
    # 1. Trigger Obsidian to create the note in the background.
    open --background "obsidian://adv-uri?vault=Notes&commandid=quickadd%3Achoice%3A2b7ae7d0-df59-4c63-a012-e054a0331d08&openmode=silent"

    # Wait for Obsidian to create the file.
    sleep 0.5

    # 2. Find the newest file created in the inbox.
    set inbox ~/Notes/+/inbox
    # Note: Using `eza`'s full path option `--absolute` can simplify the next steps.
    # However, to keep changes minimal, we'll stick to the original logic.
    set file (eza --sort=modified --reverse --oneline $inbox | head -n 1 | string trim -c "'")

    # Exit with an error if no file was found.
    if test -z "$file"
        echo "Error: Could not find new note in '$inbox'."
        return 1
    end

    set fullpath "$inbox/$file"
    set filename (string replace -r '\..*$' '' (basename "$file"))

    # --- THIS VARIABLE IS NOW DEFINED EARLIER ---
    # Define root path here so it's available in both 'if' and 'else' blocks.
    # `realpath` resolves `~` to the full home directory path.
    set root_path (realpath ~/Notes)

    # 3. Check if we are running outside of a tmux session.
    if not set -q TMUX
        # --- We are OUTSIDE tmux. Create or use the dedicated 'notes' session. ---

        set -l session_name "notes"

        if tmux has-session -t="$session_name" 2>/dev/null
            # Session exists: open the note in a new window within it.
            echo "Opening quick note in existing '$session_name' session..."
            # --- THIS LINE IS CORRECTED ---
            # Add -c flag to set the working directory for the new window.
            # Use single quotes around '$fullpath' for safety with special characters.
            tmux new-window -t "$session_name" -c "$root_path" -n "$filename" "nvim '$fullpath'"
        else
            # Session does not exist: create it with the note open.
            echo "Creating new '$session_name' session..."
            # This part was already correct. Added quotes for consistency.
            tmux new-session -ds "$session_name" -c "$root_path" -n "$filename" "nvim '$fullpath'"
        end

        # Attach to the dedicated 'notes' session.
        tmux attach-session -t "$session_name"
    else
        # --- We are INSIDE tmux. Replace the current shell with nvim. ---
        # --- THIS PART IS CORRECTED ---
        # Change to the notes directory first, then replace the shell with nvim.
        # Use quotes around "$fullpath" to handle spaces or special characters.
        cd "$root_path" && exec nvim "$fullpath"
    end
end
