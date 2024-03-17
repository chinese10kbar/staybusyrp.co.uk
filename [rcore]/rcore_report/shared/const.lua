ANIM_FLAG_NORMAL = 0
ANIM_FLAG_REPEAT = 1
ANIM_FLAG_STOP_LAST_FRAME = 2
ANIM_FLAG_UPPERBODY = 16
ANIM_FLAG_ENABLE_PLAYER_CONTROL = 32
ANIM_FLAG_CANCELABLE = 120

--consts
REPORT_STATE = {
    OPENED = 'OPENED',
    IN_RESOLVE = 'IN_RESOLVE',
    RESOLVED = 'RESOLVED',
}

REPORTS_HISTORY_PER_CALL_COUNT = 10

SECONDS = 1000
MINUTE = 60 * SECONDS
HOUR = 60 * MINUTE


Errors = {
    ValidationError = 'VALIDATION_ERROR',
    ReportCreateFailed = 'REPORT_CREATE_FAILED',
    AddTagFailed = 'ADD_TAG_FAILED',
    ReportMissing = 'REPORT_MISSING',
    AlreadyInState = 'REPORT_ALREADY_IN_STATE',
    MissingPerms = 'MISSING_PERMS',
}

LogType = {
    CREATE_REPORT = 'CREATE_REPORT',
    SET_IN_RESOLVE = 'SET_IN_RESOLVE',
    SET_TITLE = 'SET_TITLE',
    CLOSED_REPORT = 'CLOSED_REPORT',
    ADD_MESSAGE = 'ADD_MESSAGE',
    HIDE_MESSAGE = 'HIDE_MESSAGE',
    SHOW_MESSAGE = 'SHOW_MESSAGE',
    ADD_PLAYER_TO_REPORT = 'ADD_PLAYER_TO_REPORT',
    KICK_FROM_REPORT = 'KICK_FROM_REPORT',
    ADMIN_ENTERS_REPORT = 'ADMIN_ENTERS_REPORT',
    ADMIN_LEAVES_REPORT = 'ADMIN_LEAVES_REPORT',
    SET_TAG = 'SET_TAG',
    CLEAR_TAG = 'CLEAR_TAG',
}

Permissions = {
    OPEN_REPORT = 'page.open',
    OPEN_CONTROL = 'page.open_control', 
    OPEN_STATISTICS = 'page.open_statistics',
}

ReportUpdateType = {
    UPDATE_PLAYER_INFO_IN_REPORTS = 'updatePlayerInfoInReports',
    ADD_MESSAGE = 'addMessage',
    HIDE_MESSAGE = 'hideMessage',
    SHOW_MESSAGE = 'showMessage',
    CREATE_REPORT = 'createReport',
    LOAD_REPORT = 'loadReport',
    SET_REPORT_TITLE = 'setReportTitle',
    SET_REPORT_IN_RESOLVE = 'setReportInResolve',
    SET_REPORT_TAG = 'setReportTag',
    CLEAR_REPORT_TAG = 'clearReportTag',
    KICK_PLAYER_FROM_REPORT = 'kickPlayerFromReport',
    ADD_PLAYER_TO_REPORT = 'addPlayerToReport',
    MOVE_TO_HISTORY = 'moveToHistory',
}