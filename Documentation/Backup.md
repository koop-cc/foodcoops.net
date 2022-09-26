Restore files from backup
=========================

We create daily backups of all databases and importamt system directories. You will find the backups at the following locations:
| Backup | Tool | Backup server | Location |
|--------|------|--------|----------|
| Databases | `automysqlbackup` | focone | `/var/lib/automysqlbackup` |
| System | `rsnapshot` | fc-helper | `/data/backups/rsnapshot` |
