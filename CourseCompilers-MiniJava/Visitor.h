#pragma once
class CProgram;
class CMainClass;
class CClassDecl;
class CClassDeclInheritance;
class CVarDecls;
class CMethodDecls;
class CVarDecl;
class CMethodDecl;
class CStatements;
class CFormalList;
class CFormalRests;
class CFormalRest;
class CType;
class CExpList;
class CExpRests;
class CExpRest;


class CStatementIF;
class CStatementBRACKETS;
class CStatementSQUEREASIGNMENT;
class CStatementASIGNMENT;
class CStatementPRINTLN;
class CStatementWHILE;

class CExpBinary;
class CExpInSquareBrackets;
class CExpPointLENGTH;
class CExpPointID;
class CExpINTEGER_LITERAL;
class CExpSingleOp;
class CExpID;
class CExpTHIS;
class CExpNEWINT;
class CExpNEWID;
class CExpExclamationMark;
class CExpCircleBrackets;
class CExpUnaryMinus;
class CClassDecls;

class IVisitor
{
public:
	virtual void visit(CStatementIF* n) = 0;
	virtual void visit(CStatementBRACKETS* n) = 0;

	virtual void visit(CStatementSQUEREASIGNMENT* n) = 0;

	virtual void visit(CStatementASIGNMENT* n) = 0;

	virtual void visit(CStatementPRINTLN* n) = 0;

	virtual void visit(CStatementWHILE* n) = 0;

	virtual void visit(CExpBinary* n) = 0;

	virtual void visit(CExpInSquareBrackets *n) = 0;

	virtual void visit(CExpPointLENGTH *n) = 0;

	virtual void visit(CExpPointID *n) = 0;

	virtual void visit(CExpINTEGER_LITERAL *n) = 0;

	virtual void visit(CExpSingleOp *n) = 0;
	virtual void visit(CExpID *n) = 0;
	virtual void visit(CExpTHIS *n) = 0;
	virtual void visit(CExpNEWINT *n) = 0;
	virtual void visit(CExpNEWID *n) = 0;
	virtual void visit(CExpExclamationMark *n) = 0;
	virtual void visit(CExpCircleBrackets *n) = 0;
	virtual void visit( CProgram *n ) = 0;
	virtual void visit( CMainClass *n ) = 0;
	virtual void visit( CClassDecl *n ) = 0;
	virtual void visit(CClassDecls *n) = 0;
	virtual void visit( CClassDeclInheritance *n ) = 0;
	virtual void visit( CVarDecls *n ) = 0;
	virtual void visit( CMethodDecls *n ) = 0;
	virtual void visit( CVarDecl *n ) = 0;
	virtual void visit( CMethodDecl *n ) = 0;
	virtual void visit( CStatements *n ) = 0;
	virtual void visit( CFormalList *n ) = 0;
	virtual void visit( CFormalRests *n ) = 0;
	virtual void visit( CFormalRest *n ) = 0;
	virtual void visit( CExpList *n ) = 0;
	virtual void visit( CType *n ) = 0;
	virtual void visit( CExpRest *n ) = 0;
	virtual void visit( CExpRests *n ) = 0;
	virtual void visit(CExpUnaryMinus *n) = 0;
}; 