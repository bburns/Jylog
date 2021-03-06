// Autogenerated AST node
package org.python.antlr.ast;
import org.antlr.runtime.CommonToken;
import org.antlr.runtime.Token;
import org.python.antlr.AST;
import org.python.antlr.PythonTree;
import org.python.antlr.adapter.AstAdapters;
import org.python.antlr.base.excepthandler;
import org.python.antlr.base.expr;
import org.python.antlr.base.mod;
import org.python.antlr.base.slice;
import org.python.antlr.base.stmt;
import org.python.core.ArgParser;
import org.python.core.AstList;
import org.python.core.Py;
import org.python.core.PyObject;
import org.python.core.PyString;
import org.python.core.PyType;
import org.python.expose.ExposedGet;
import org.python.expose.ExposedMethod;
import org.python.expose.ExposedNew;
import org.python.expose.ExposedSet;
import org.python.expose.ExposedType;
import java.io.DataOutputStream;
import java.io.IOException;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.LinkedList;
import java.util.Queue;

import org.python.antlr.Visitor;
import org.python.compiler.CodeCompiler;
import org.python.core.PyList;
import org.python.core.PyTuple;

@ExposedType(name = "_ast.SIMQuery", base = AST.class)
public class SIMQuery extends expr {
public static final PyType TYPE = PyType.fromClass(SIMQuery.class);
    private expr dest;
    public expr getInternalDest() {
        return dest;
    }
    @ExposedGet(name = "dest")
    public PyObject getDest() {
        return dest;
    }
    @ExposedSet(name = "dest")
    public void setDest(PyObject dest) {
        this.dest = AstAdapters.py2expr(dest);
    }

    private java.util.List<expr> values;
    public java.util.List<expr> getInternalValues() {
        return values;
    }
    @ExposedGet(name = "values")
    public PyObject getValues() {
        return new AstList(values, AstAdapters.exprAdapter);
    }
    @ExposedSet(name = "values")
    public void setValues(PyObject values) {
        this.values = AstAdapters.py2exprList(values);
    }
    
    private arguments args;
    public arguments getInternalArgs() {
        return args;
    }
    @ExposedGet(name = "args")
    public PyObject getArgs() {
        return args;
    }
    @ExposedSet(name = "args")
    public void setArgs(PyObject args) {
        this.args = AstAdapters.py2arguments(args);
    }

    private expr body;
    public expr getInternalBody() {
        return body;
    }
    @ExposedGet(name = "body")
    public PyObject getBody() {
        return body;
    }
    @ExposedSet(name = "body")
    public void setBody(PyObject body) {
        this.body = AstAdapters.py2expr(body);
    }


    private final static PyString[] fields =
    new PyString[] {new PyString("args"), new PyString("body")};
    @ExposedGet(name = "_fields")
    public PyString[] get_fields() { return fields; }

    private final static PyString[] attributes =
    new PyString[] {new PyString("lineno"), new PyString("col_offset")};
    @ExposedGet(name = "_attributes")
    public PyString[] get_attributes() { return attributes; }

    public SIMQuery(PyType subType) {
        super(subType);
    }
    public SIMQuery() {
        this(TYPE);
    }
    @ExposedNew
    @ExposedMethod
    public void SIMQuery___init__(PyObject[] args, String[] keywords) {
        ArgParser ap = new ArgParser("SIMQuery", args, keywords, new String[]
            {"args", "body", "lineno", "col_offset"}, 2, true);
        setArgs(ap.getPyObject(0, Py.None));
        setBody(ap.getPyObject(1, Py.None));
        int lin = ap.getInt(2, -1);
        if (lin != -1) {
            setLineno(lin);
        }

        int col = ap.getInt(3, -1);
        if (col != -1) {
            setLineno(col);
        }

    }
    public static Queue<java.util.List> qlhs = new LinkedList<java.util.List>();
    public static Queue<java.util.List> qlops = new LinkedList<java.util.List>();
    public static Queue<java.util.List> qops = new LinkedList<java.util.List>();
    public static SIMQuery myself;
    public SIMQuery(Token token, expr dest, java.util.List<String> lhs,
                    java.util.List<String> lops, java.util.List<String> ops,
                    java.util.List<expr> values) {
        super(token);
        myself = this;
        qlhs.add(lhs);
        qlops.add(lops);
        qops.add(ops);
        this.dest = dest;
        addChild(dest);
        this.values = values;
        if (values == null) {
            this.values = new ArrayList<expr>();
        }
        for (PythonTree t : this.values) {
            addChild(t);
        }
        // this.nl = nl;
    }

    public static void kludge(java.util.List<PyObject> where) throws Exception{
        CodeCompiler.myself.kludge2();
        /*
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver").newInstance();
            Connection conn =
                DriverManager.getConnection("jdbc:oracle:thin:@aus-perfdb.central.sun.com:1525:perfdb",
                                            "cannata", "orcl");
            String sqlstmt = "select distinct eav.id from eav, entity where (";
            java.util.List l = qlhs.remove();
            java.util.List o = qops.remove();
            java.util.List c = qlops.remove();
            for (int i = 0; i < l.size(); i++) {
                if (i > 0 && i < l.size())
                    sqlstmt += " or ";
                sqlstmt += "attr = '" + l.get(i) + "' and ";
                String op = o.get(i).toString();
                if (op.equals("=")) {
                    sqlstmt += "value " + op;
                    sqlstmt += " '" + where.get(i) + "' ";
                } else {
                    sqlstmt += "to_number(value) " + op;
                    sqlstmt += " " + where.get(i) + " ";
                }
            }
            // The following line will have to be changed to something like the above comment to support joins
            sqlstmt += ") and eav.id = entity.id and entity.entity = '" + qfroms.remove().get(0) + "'";
            System.out.println(sqlstmt);
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sqlstmt);
            String result = "(";
            int count = 0;
            while (rs.next()) {
                if (count++ > 0) result += ", ";
                result += rs.getString(1);
            }
            result += ")";
            Hashtable project = new Hashtable();
            java.util.List a = qattrs.remove();
            for (int i = 0; i < a.size(); i++) {
                project.put(a.get(i).toString(), new Integer(1));
            }
            String query = "SELECT * ";
            query += " FROM eav WHERE id IN " + result;
            query += " order by id, attr";
            stmt = conn.createStatement();
            rs = stmt.executeQuery(query);
            String id = "", previd = "";
            while (rs.next()) {
                ResultSetMetaData rsmd = rs.getMetaData();
                int numCols = rsmd.getColumnCount();
                result = "";
                count = 0;
                if (project.containsKey(rs.getString(2)) || project.containsKey("*")) {
                    for (int i = 1; i <= numCols; i++) {
                        if (count++ == 0)
                            id = rs.getString(i);
                        else
                            result += rs.getString(i) + " ";
                    }
                }
                if (!id.equals(previd))
                    System.out.print("\n" +
                            id + ": ");
                previd = id;
                System.out.print(result);
            }
            System.out.println();
            rs.close();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (SQLException sqlException) {
            System.out.println("Exception: " + sqlException);
        }
        */
    }
    

    public SIMQuery(PyObject args, PyObject body) {
        setArgs(args);
        setBody(body);
    }

    public SIMQuery(Token token, arguments args, expr body) {
        super(token);
        this.args = args;
        this.body = body;
        addChild(body);
    }

    public SIMQuery(Integer ttype, Token token, arguments args, expr body) {
        super(ttype, token);
        this.args = args;
        this.body = body;
        addChild(body);
    }

    public SIMQuery(PythonTree tree, arguments args, expr body) {
        super(tree);
        this.args = args;
        this.body = body;
        addChild(body);
    }

/*
    @ExposedGet(name = "repr")
    public String toString() {
        return "SIMQuery";
    }
*/

    public String toStringTree() {
        StringBuffer sb = new StringBuffer("SIMQuery(");
        sb.append("args=");
        sb.append(dumpThis(args));
        sb.append(",");
        sb.append("body=");
        sb.append(dumpThis(body));
        sb.append(",");
        sb.append(")");
        return sb.toString();
    }

    public <R> R accept(VisitorIF<R> visitor) throws Exception {
        return visitor.visitSIMQuery(this);
    }

    public void traverse(VisitorIF<?> visitor) throws Exception {
        if (args != null)
            args.accept(visitor);
        if (body != null)
            body.accept(visitor);
    }

    private int lineno = -1;
    @ExposedGet(name = "lineno")
    public int getLineno() {
        if (lineno != -1) {
            return lineno;
        }
        return getLine();
    }

    @ExposedSet(name = "lineno")
    public void setLineno(int num) {
        lineno = num;
    }

    private int col_offset = -1;
    @ExposedGet(name = "col_offset")
    public int getCol_offset() {
        if (col_offset != -1) {
            return col_offset;
        }
        return getCharPositionInLine();
    }

    @ExposedSet(name = "col_offset")
    public void setCol_offset(int num) {
        col_offset = num;
    }

}
