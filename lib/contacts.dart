/*library contacts;

class Contact {
  //String name;
  //Uri url;
  var NoCon, prenom, nom, email, tel, adresse;

  Contact(this.NoCon, this.prenom, this.nom, this.email, this.tel, this.adresse) {
    //url = Uri.parse(link);
  }
}*/

library contacts;

class Contact implements Comparable {
  //String name;
  //Uri url;

  String NoCon, prenom, nom, email, tel, adresse;
  
  Contact(NoCon, prenom, nom, email, tel, adresse) {
    
    this.NoCon = NoCon;
    this.prenom = prenom;
    this.nom = nom;
    this.email = email;
    this.tel = tel;
    this.adresse = adresse;
    //url = Uri.parse(link);
  }

  Contact.fromJson(Map<String, Object> contactMap) {
       
    NoCon = contactMap['NoCon'];
    prenom = contactMap['prenom'];
    nom = contactMap['nom'];
    email = contactMap['email'];
    tel = contactMap['tel'];
    adresse = contactMap['adresse'];
    
  }

  Map<String, Object> toJson() {
    
    var contactMap = new Map<String, Object>();
        
    contactMap['NoCon'] = NoCon;
    contactMap['prenom'] = prenom;
    contactMap['nom'] = nom;
    contactMap['email'] = email;
    contactMap['tel'] = tel;
    contactMap['adresse'] = adresse;
    
    return contactMap;
  }

  String toString() {
    //return '{name: ${name}, url: ${url.toString()}}';
    return '{NoCon: ${NoCon}, prenom: ${prenom.toString()}, nom : ${nom.toString()}, email: ${email.toString()}, tel: ${tel.toString()}, adresse: ${adresse.toString()}}';
  }

  /**
   * Compares two links based on their names.
   * If the result is less than 0 then the first link is less than the second,
   * if it is equal to 0 they are equal and
   * if the result is greater than 0 then the first is greater than the second.
   */
  int compareTo(Contact contact) {
    if (NoCon != null && contact.NoCon != null) {
      return NoCon.compareTo(contact.NoCon);
    } else {
      throw new Exception('a contact Number must be present');
    }
  }
}

class Contacts {
  var _list = new List<Contact>();

  Iterator<Contact> get iterator => _list.iterator;
  bool get isEmpty => _list.isEmpty;

  List<Contact> get internalList => _list;
  set internalList(List<Contact> observableList) => _list = observableList;

  bool add(Contact newContact) {
    if (newContact == null) {
      throw new Exception('a new contact must be present');
    }
    for (Contact contact in this) {
      if (newContact.NoCon == contact.NoCon) return false;
    }
    _list.add(newContact);
    return true;
  }

  Contact find(String NoCon) {
    for (Contact contact in _list) {
      if (contact.NoCon == NoCon) return contact;
    }
    return null;
  }

  bool remove(Contact contact) {
    return _list.remove(contact);
  }

  sort() {
    _list.sort();
  }
}

class Model {
  var contacts = new Contacts();

  // singleton design pattern: http://en.wikipedia.org/wiki/Singleton_pattern
  static Model model;
  Model.private();
  static Model get one {
    if (model == null) {
      model = new Model.private();
    }
    return model;
  }
  // singleton

  init() {
    //var cont1 = new Contact('On Dart', 'http://ondart.me/');
    //var cont2 = new Contact('Polymer.dart', 'https://www.dartlang.org/polymer-dart/');
    //var cont3 = new Contact('Books To Read', 'http://www.goodreads.com/');
   
    var cont1 = new Contact('CON001', 'Aurelien', 'BETBEUI', 'aurel_kb@yahoo.fr', '418-929-0721', '2592 rue vendée Québec QC');
    var cont2 = new Contact('CON002', 'Mich', 'NOUKAM', 'nmich@yahoo.fr', '581-445-5674', '7654 boulevard laurier Québec QC');
    var cont3 = new Contact('CON003', 'Teddy', 'DESCHAMPS', 'tdeschamps@gmail.com', '418-765-3345', '657 rue serine Québec QC');
        
    Model.one.contacts..add(cont1)..add(cont2)..add(cont3);
  }

  List<Map<String, Object>> toJson() {
    var contactList = new List<Map<String, Object>>();
    for (Contact contact in contacts) {
      contactList.add(contact.toJson());
    }
    return contactList;
  }

  fromJson(List<Map<String, Object>> contactList) {
    if (!contacts.isEmpty) {
      throw new Exception('contact are not empty');
    }
    for (Map<String, Object> contactMap in contactList) {
      Contact contact = new Contact.fromJson(contactMap);
      contacts.add(contact);
    }
  }
}

