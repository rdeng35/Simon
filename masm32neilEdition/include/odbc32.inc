; --------------------------------------------------------------------------------------------------
;                           odbc32.inc Copyright The MASM32 SDK 1998-2010
; --------------------------------------------------------------------------------------------------

IFNDEF ODBC32_INC
ODBC32_INC equ <1>

CloseODBCPerfData PROTO STDCALL
CollectODBCPerfData PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
CursorLibLockDbc PROTO STDCALL :DWORD,:DWORD
CursorLibLockDesc PROTO STDCALL :DWORD,:DWORD
CursorLibLockStmt PROTO STDCALL :DWORD,:DWORD
CursorLibTransact PROTO STDCALL :DWORD,:DWORD,:DWORD
DllBidEntryPoint PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
GetODBCSharedData PROTO STDCALL
LockHandle PROTO STDCALL :DWORD,:DWORD,:DWORD
MpHeapAlloc PROTO C :VARARG
MpHeapCompact PROTO C :VARARG
MpHeapCreate PROTO C :VARARG
MpHeapDestroy PROTO C :VARARG
MpHeapFree PROTO C :VARARG
MpHeapReAlloc PROTO C :VARARG
MpHeapSize PROTO C :VARARG
MpHeapValidate PROTO C :VARARG
ODBCGetTryWaitValue PROTO STDCALL

ODBCInternalConnectW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  ODBCInternalConnect equ <ODBCInternalConnectW>
ENDIF

ODBCQualifyFileDSNW PROTO STDCALL :DWORD
IFDEF __UNICODE__
  ODBCQualifyFileDSN equ <ODBCQualifyFileDSNW>
ENDIF

ODBCSetTryWaitValue PROTO STDCALL :DWORD
OpenODBCPerfData PROTO STDCALL :DWORD
PostComponentError PROTO STDCALL :DWORD
PostODBCComponentError PROTO STDCALL :DWORD
PostODBCError PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
SQLAllocConnect PROTO STDCALL :DWORD,:DWORD
SQLAllocEnv PROTO STDCALL :DWORD
SQLAllocHandle PROTO STDCALL :DWORD,:DWORD,:DWORD
SQLAllocHandleStd PROTO STDCALL :DWORD,:DWORD,:DWORD
SQLAllocStmt PROTO STDCALL :DWORD,:DWORD
SQLBindCol PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
SQLBindParam PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
SQLBindParameter PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD

SQLBrowseConnectA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  SQLBrowseConnect equ <SQLBrowseConnectA>
ENDIF

SQLBrowseConnectW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  SQLBrowseConnect equ <SQLBrowseConnectW>
ENDIF

SQLBulkOperations PROTO STDCALL :DWORD,:DWORD
SQLCancel PROTO STDCALL :DWORD
SQLCloseCursor PROTO STDCALL :DWORD

SQLColAttributeA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  SQLColAttribute equ <SQLColAttributeA>
ENDIF

SQLColAttributeW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  SQLColAttribute equ <SQLColAttributeW>
ENDIF


SQLColAttributesA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  SQLColAttributes equ <SQLColAttributesA>
ENDIF

SQLColAttributesW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  SQLColAttributes equ <SQLColAttributesW>
ENDIF


SQLColumnPrivilegesA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  SQLColumnPrivileges equ <SQLColumnPrivilegesA>
ENDIF

SQLColumnPrivilegesW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  SQLColumnPrivileges equ <SQLColumnPrivilegesW>
ENDIF


SQLColumnsA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  SQLColumns equ <SQLColumnsA>
ENDIF

SQLColumnsW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  SQLColumns equ <SQLColumnsW>
ENDIF


SQLConnectA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  SQLConnect equ <SQLConnectA>
ENDIF

SQLConnectW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  SQLConnect equ <SQLConnectW>
ENDIF

SQLCopyDesc PROTO STDCALL :DWORD,:DWORD

SQLDataSourcesA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  SQLDataSources equ <SQLDataSourcesA>
ENDIF

SQLDataSourcesW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  SQLDataSources equ <SQLDataSourcesW>
ENDIF


SQLDescribeColA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  SQLDescribeCol equ <SQLDescribeColA>
ENDIF

SQLDescribeColW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  SQLDescribeCol equ <SQLDescribeColW>
ENDIF

SQLDescribeParam PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
SQLDisconnect PROTO STDCALL :DWORD

SQLDriverConnectA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  SQLDriverConnect equ <SQLDriverConnectA>
ENDIF

SQLDriverConnectW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  SQLDriverConnect equ <SQLDriverConnectW>
ENDIF


SQLDriversA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  SQLDrivers equ <SQLDriversA>
ENDIF

SQLDriversW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  SQLDrivers equ <SQLDriversW>
ENDIF

SQLEndTran PROTO STDCALL :DWORD,:DWORD,:DWORD

SQLErrorA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  SQLError equ <SQLErrorA>
ENDIF

SQLErrorW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  SQLError equ <SQLErrorW>
ENDIF


SQLExecDirectA PROTO STDCALL :DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  SQLExecDirect equ <SQLExecDirectA>
ENDIF

SQLExecDirectW PROTO STDCALL :DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  SQLExecDirect equ <SQLExecDirectW>
ENDIF

SQLExecute PROTO STDCALL :DWORD
SQLExtendedFetch PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
SQLFetch PROTO STDCALL :DWORD
SQLFetchScroll PROTO STDCALL :DWORD,:DWORD,:DWORD

SQLForeignKeysA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  SQLForeignKeys equ <SQLForeignKeysA>
ENDIF

SQLForeignKeysW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  SQLForeignKeys equ <SQLForeignKeysW>
ENDIF

SQLFreeConnect PROTO STDCALL :DWORD
SQLFreeEnv PROTO STDCALL :DWORD
SQLFreeHandle PROTO STDCALL :DWORD,:DWORD
SQLFreeStmt PROTO STDCALL :DWORD,:DWORD

SQLGetConnectAttrA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  SQLGetConnectAttr equ <SQLGetConnectAttrA>
ENDIF

SQLGetConnectAttrW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  SQLGetConnectAttr equ <SQLGetConnectAttrW>
ENDIF


SQLGetConnectOptionA PROTO STDCALL :DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  SQLGetConnectOption equ <SQLGetConnectOptionA>
ENDIF

SQLGetConnectOptionW PROTO STDCALL :DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  SQLGetConnectOption equ <SQLGetConnectOptionW>
ENDIF


SQLGetCursorNameA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  SQLGetCursorName equ <SQLGetCursorNameA>
ENDIF

SQLGetCursorNameW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  SQLGetCursorName equ <SQLGetCursorNameW>
ENDIF

SQLGetData PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD

SQLGetDescFieldA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  SQLGetDescField equ <SQLGetDescFieldA>
ENDIF

SQLGetDescFieldW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  SQLGetDescField equ <SQLGetDescFieldW>
ENDIF


SQLGetDescRecA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  SQLGetDescRec equ <SQLGetDescRecA>
ENDIF

SQLGetDescRecW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  SQLGetDescRec equ <SQLGetDescRecW>
ENDIF


SQLGetDiagFieldA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  SQLGetDiagField equ <SQLGetDiagFieldA>
ENDIF

SQLGetDiagFieldW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  SQLGetDiagField equ <SQLGetDiagFieldW>
ENDIF


SQLGetDiagRecA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  SQLGetDiagRec equ <SQLGetDiagRecA>
ENDIF

SQLGetDiagRecW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  SQLGetDiagRec equ <SQLGetDiagRecW>
ENDIF

SQLGetEnvAttr PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
SQLGetFunctions PROTO STDCALL :DWORD,:DWORD,:DWORD

SQLGetInfoA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  SQLGetInfo equ <SQLGetInfoA>
ENDIF

SQLGetInfoW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  SQLGetInfo equ <SQLGetInfoW>
ENDIF


SQLGetStmtAttrA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  SQLGetStmtAttr equ <SQLGetStmtAttrA>
ENDIF

SQLGetStmtAttrW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  SQLGetStmtAttr equ <SQLGetStmtAttrW>
ENDIF

SQLGetStmtOption PROTO STDCALL :DWORD,:DWORD,:DWORD

SQLGetTypeInfoA PROTO STDCALL :DWORD,:DWORD
IFNDEF __UNICODE__
  SQLGetTypeInfo equ <SQLGetTypeInfoA>
ENDIF

SQLGetTypeInfoW PROTO STDCALL :DWORD,:DWORD
IFDEF __UNICODE__
  SQLGetTypeInfo equ <SQLGetTypeInfoW>
ENDIF

SQLMoreResults PROTO STDCALL :DWORD

SQLNativeSqlA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  SQLNativeSql equ <SQLNativeSqlA>
ENDIF

SQLNativeSqlW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  SQLNativeSql equ <SQLNativeSqlW>
ENDIF

SQLNumParams PROTO STDCALL :DWORD,:DWORD
SQLNumResultCols PROTO STDCALL :DWORD,:DWORD
SQLParamData PROTO STDCALL :DWORD,:DWORD
SQLParamOptions PROTO STDCALL :DWORD,:DWORD,:DWORD

SQLPrepareA PROTO STDCALL :DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  SQLPrepare equ <SQLPrepareA>
ENDIF

SQLPrepareW PROTO STDCALL :DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  SQLPrepare equ <SQLPrepareW>
ENDIF


SQLPrimaryKeysA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  SQLPrimaryKeys equ <SQLPrimaryKeysA>
ENDIF

SQLPrimaryKeysW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  SQLPrimaryKeys equ <SQLPrimaryKeysW>
ENDIF


SQLProcedureColumnsA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  SQLProcedureColumns equ <SQLProcedureColumnsA>
ENDIF

SQLProcedureColumnsW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  SQLProcedureColumns equ <SQLProcedureColumnsW>
ENDIF


SQLProceduresA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  SQLProcedures equ <SQLProceduresA>
ENDIF

SQLProceduresW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  SQLProcedures equ <SQLProceduresW>
ENDIF

SQLPutData PROTO STDCALL :DWORD,:DWORD,:DWORD
SQLRowCount PROTO STDCALL :DWORD,:DWORD

SQLSetConnectAttrA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  SQLSetConnectAttr equ <SQLSetConnectAttrA>
ENDIF

SQLSetConnectAttrW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  SQLSetConnectAttr equ <SQLSetConnectAttrW>
ENDIF


SQLSetConnectOptionA PROTO STDCALL :DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  SQLSetConnectOption equ <SQLSetConnectOptionA>
ENDIF

SQLSetConnectOptionW PROTO STDCALL :DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  SQLSetConnectOption equ <SQLSetConnectOptionW>
ENDIF


SQLSetCursorNameA PROTO STDCALL :DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  SQLSetCursorName equ <SQLSetCursorNameA>
ENDIF

SQLSetCursorNameW PROTO STDCALL :DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  SQLSetCursorName equ <SQLSetCursorNameW>
ENDIF


SQLSetDescFieldA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  SQLSetDescField equ <SQLSetDescFieldA>
ENDIF

SQLSetDescFieldW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  SQLSetDescField equ <SQLSetDescFieldW>
ENDIF

SQLSetDescRec PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
SQLSetEnvAttr PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
SQLSetParam PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
SQLSetPos PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
SQLSetScrollOptions PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD

SQLSetStmtAttrA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  SQLSetStmtAttr equ <SQLSetStmtAttrA>
ENDIF

SQLSetStmtAttrW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  SQLSetStmtAttr equ <SQLSetStmtAttrW>
ENDIF

SQLSetStmtOption PROTO STDCALL :DWORD,:DWORD,:DWORD

SQLSpecialColumnsA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  SQLSpecialColumns equ <SQLSpecialColumnsA>
ENDIF

SQLSpecialColumnsW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  SQLSpecialColumns equ <SQLSpecialColumnsW>
ENDIF


SQLStatisticsA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  SQLStatistics equ <SQLStatisticsA>
ENDIF

SQLStatisticsW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  SQLStatistics equ <SQLStatisticsW>
ENDIF


SQLTablePrivilegesA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  SQLTablePrivileges equ <SQLTablePrivilegesA>
ENDIF

SQLTablePrivilegesW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  SQLTablePrivileges equ <SQLTablePrivilegesW>
ENDIF


SQLTablesA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  SQLTables equ <SQLTablesA>
ENDIF

SQLTablesW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  SQLTables equ <SQLTablesW>
ENDIF

SQLTransact PROTO STDCALL :DWORD,:DWORD,:DWORD
SearchStatusCode PROTO STDCALL :DWORD,:DWORD
VFreeErrors PROTO STDCALL :DWORD
VRetrieveDriverErrorsRowCol PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
ValidateErrorQueue PROTO STDCALL :DWORD,:DWORD
  ; g_hHeapMalloc arg type unknown

ELSE
  echo -----------------------------------------
  echo WARNING duplicate include file odbc32.inc
  echo -----------------------------------------
ENDIF
