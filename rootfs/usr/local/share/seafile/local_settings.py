# Seahub reads this module before seahub_settings.py, so anything set there by
# hand still wins. 00_prepare.sh has already checked the variables.
import os

_suite = os.environ.get('OFFICE', 'off').lower()
_url = os.environ.get('OFFICE_SERVER_URL', '').rstrip('/')

# Euro-Office is a fork of the OnlyOffice document server and keeps its API.
if _suite in ('euro-office', 'onlyoffice'):
    ENABLE_ONLYOFFICE = True
    ONLYOFFICE_APIJS_URL = _url + '/web-apps/apps/api/documents/api.js'
    ONLYOFFICE_JWT_SECRET = os.environ.get('OFFICE_JWT_SECRET', '')
elif _suite == 'collabora':
    _extensions = ('odp', 'ods', 'odt', 'xls', 'xlsb', 'xlsm', 'xlsx', 'ppsx', 'ppt', 'pptm', 'pptx', 'doc', 'docm', 'docx')
    OFFICE_SERVER_TYPE = 'CollaboraOffice'
    OFFICE_WEB_APP_BASE_URL = _url + '/hosting/discovery'
    ENABLE_OFFICE_WEB_APP = True
    ENABLE_OFFICE_WEB_APP_EDIT = True
    OFFICE_WEB_APP_FILE_EXTENSION = _extensions
    OFFICE_WEB_APP_EDIT_FILE_EXTENSION = _extensions
    WOPI_ACCESS_TOKEN_EXPIRATION = 30 * 60
