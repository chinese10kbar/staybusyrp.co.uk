PermissionMap = {
    ['group.admin'] = {
        Permissions.OPEN_CONTROL,
    },
    ['group.superadmin'] = {
        Permissions.OPEN_CONTROL,
        Permissions.OPEN_STATISTICS,
    },
    ['builtin.everyone'] = { --Everyone
        Permissions.OPEN_REPORT,
    }
}
