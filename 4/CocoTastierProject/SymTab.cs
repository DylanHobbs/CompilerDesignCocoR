using System;
using System.IO;

namespace Tastier { 

//TODO
//.ATG - const

public class Obj { // properties of declared symbol
   public string name; // its name
   public int setVal;  // Constant Value set or not
   public int kind;    // var, proc or scope
   public int type;    // its type if var (undef for proc)
   public int level;   // lexic level: 0 = global; >= 1 local
   public int adr;     // address (displacement) in scope 
   public Obj next;    // ptr to next object in scope
   // for scopes
   public Obj outer;   // ptr to enclosing scope
   public Obj locals;  // ptr to locally declared objects
   public int nextAdr; // next free address in scope
}

public class SymbolTable {

   const int // object kinds
      var = 0, proc = 1, scope = 2, constant=3; 

   const int // types
      undef = 0, integer = 1, boolean = 2;

   const int // set or not. Ignore for var and proc, applies to const only
      unsett = 0, sett = 1;

   public Obj topScope; // topmost procedure scope
   public int curLevel; // nesting level of current scope
   public Obj undefObj; // object node for erroneous symbols
   
   Parser parser;
   
   public SymbolTable(Parser parser) {
      curLevel = -1; 
      topScope = null;
      undefObj = new Obj();
      undefObj.name = "undef";
      undefObj.kind = var;
      undefObj.type = undef;
      undefObj.level = 0;
      undefObj.adr = 0;
      undefObj.next = null;
      this.parser = parser; 
   }

// open new scope and make it the current scope (topScope)
   public void OpenScope() {
      Obj scop = new Obj();
      scop.name = "";
      scop.kind = scope; 
      scop.outer = topScope; 
      scop.locals = null;
      scop.nextAdr = 0;
      topScope = scop; 
      curLevel++;
   }

// close current scope
   public void CloseScope() {
      Obj current = topScope.locals;
      while (current != null){
         string kind = int2Kind(current.kind);
         string type = int2Type(current.type);

         Console.WriteLine(";ADR: " 
            + current.adr + " | KIND: " 
            + kind + " | TYPE: " 
            + type + " | LEVEL: " 
            + current.level + " | NAME: " 
            + current.name + " | SetVal: " 
            + current.setVal);
         current = current.next;
      } 
      // update next available address in enclosing scope
      if(topScope.outer != null)
         topScope.outer.nextAdr = topScope.nextAdr;
      // lexic level remains unchanged
      topScope = topScope.outer;
      curLevel--;
   }

   public string int2Type(int type_trigger ){
      switch(type_trigger){
         case 0: return "UNDEF ";
         case 1: return "INT   ";
         case 2: return "BOOL  ";
         default: return "NOPE";
      }
   }

   public string int2Kind(int kind_trigger){
      switch(kind_trigger){
         case 0: return "VAR   ";
         case 1: return "PROC  ";
         case 2: return "SCOPE ";
         case 3: return "CONST ";
         default: return "NOPE";
      }
   }

// create new object node in current scope
   public Obj NewObj(string name, int kind, int type) {
      Obj p, last; 
      Obj obj = new Obj();
      obj.name = name; obj.kind = kind;
      obj.type = type; obj.level = curLevel; 
      obj.next = null;
      obj.setVal = unsett;
      p = topScope.locals; last = null;
      while (p != null) { 
         if (p.name == name)
            parser.SemErr("name declared twice");
         last = p; p = p.next;
      }
      if (last == null)
         topScope.locals = obj; else last.next = obj;
      if (kind == var || kind == constant)
         obj.adr = topScope.nextAdr++;
      return obj;
   }

// search for name in open scopes and return its object node
   public Obj Find(string name) {
      Obj obj, scope;
      scope = topScope;
      while (scope != null) { // for all open scopes
         obj = scope.locals;
         while (obj != null) { // for all objects in this scope
            if (obj.name == name) return obj;
            obj = obj.next;
         }
         scope = scope.outer;
      }
      parser.SemErr(name + " is undeclared");
      return undefObj;
   }

} // end SymbolTable

} // end namespace
