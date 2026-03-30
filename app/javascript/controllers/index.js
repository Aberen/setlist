import { application } from "./application"
import SetlistEditorController from "./setlist_editor_controller"
import InlineEditController    from "./inline_edit_controller"
import SetlistSyncController   from "./setlist_sync_controller"

application.register("setlist-editor", SetlistEditorController)
application.register("inline-edit",    InlineEditController)
application.register("setlist-sync",   SetlistSyncController)
