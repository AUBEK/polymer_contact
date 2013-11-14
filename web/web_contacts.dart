import 'dart:html';
import 'dart:convert';
import 'package:polymer_contacts/contacts.dart';
import 'package:polymer/polymer.dart';

@CustomTag('web-contacts')
class WebContacts extends PolymerElement {
  @published Contacts contacts = Model.one.contacts;

  var AddMaj=false;
  
  WebContacts.created() : super.created();

  add(Event e, var detail, Node target) {
   
    InputElement num = shadowRoot.querySelector("#num");
    InputElement prenom = shadowRoot.querySelector("#prenom");
    InputElement nom = shadowRoot.querySelector("#nom");
    InputElement email = shadowRoot.querySelector("#email");
    InputElement tel = shadowRoot.querySelector("#tel");
    TextAreaElement adresse = shadowRoot.querySelector("#adresse");
    LabelElement message = shadowRoot.querySelector("#message");    
    
    var error = false;
    message.text = '';
    
    if (num.value.trim() == '') error = true;

    if (prenom.value.trim() == '') error = true;

    if (nom.value.trim() == '') error = true;
   
    if (email.value.trim() == '') error = true;
    
    if (tel.value.trim() == '') error = true;
    
    if (adresse.value.trim() == '') error = true;
    
    if (!error) {
      var contact = new Contact(num.value, prenom.value,nom.value,email.value,tel.value,adresse.value);
      if (contacts.add(contact)) {
        contacts.sort();
        save();
      } else {
        message.text = 'web contact with that name already exists';
      }
    }
  }
  
  update(Event e, var detail, Node target) {
    
    if(AddMaj){
      InputElement num = shadowRoot.querySelector("#num");
      InputElement prenom = shadowRoot.querySelector("#prenom");
      InputElement nom = shadowRoot.querySelector("#nom");
      InputElement email = shadowRoot.querySelector("#email");
      InputElement tel = shadowRoot.querySelector("#tel");
      TextAreaElement adresse = shadowRoot.querySelector("#adresse");
      LabelElement message = shadowRoot.querySelector("#message");    
      
      var error = false;
      message.text = '';
      
      Contact majContact = contacts.find(num.value);
      
      if (num.value.trim() == '') error = true;
      if (prenom.value.trim() == '') error = true;
      if (nom.value.trim() == '') error = true;   
      if (email.value.trim() == '') error = true;    
      if (tel.value.trim() == '') error = true;    
      if (adresse.value.trim() == '') error = true;
      
      majContact.NoCon=num.value;
      majContact.prenom=prenom.value;
      majContact.nom=nom.value;
      majContact.email=email.value;
      majContact.tel=tel.value;
      majContact.adresse=adresse.value;
      
      AddMaj=false;
      
      if (!error) {
        contacts.remove(majContact);
        var contact = new Contact(num.value, prenom.value,nom.value,email.value,tel.value,adresse.value);
        if (contacts.add(majContact)) {
          contacts.sort();
          save();          
        } else {
          message.text = 'Erreur de modification';
        }
      }
    }else{
      LabelElement message = shadowRoot.querySelector("#message");
      message.text = 'Aucun contact selectionné';
      }
  }

  edit(Event e, var detail, Node target) {
    
    AddMaj=true;
    
    InputElement num = shadowRoot.querySelector("#num");
    InputElement prenom = shadowRoot.querySelector("#prenom");
    InputElement nom = shadowRoot.querySelector("#nom");
    InputElement email = shadowRoot.querySelector("#email");
    InputElement tel = shadowRoot.querySelector("#tel");
    TextAreaElement adresse = shadowRoot.querySelector("#adresse");
    LabelElement message = shadowRoot.querySelector("#message");
    
    
    var id=(e.target as ImageElement).title;
    
    //message.text = '';
    
    Contact contact = contacts.find(id);
    
      //url.value = contact.url.toString();
      num.value = contact.NoCon.toString();
      prenom.value = contact.prenom.toString();
      nom.value = contact.nom.toString();
      email.value = contact.email.toString();
      tel.value = contact.tel.toString();
      adresse.value = contact.adresse.toString();
      
      
  }
  
  delete(Event e, var detail, Node target) {
           
    var num=(e.target as ImageElement).title;
        
    if(window.confirm("Voulez vous supprimer ce contact?!!")){
      
      LabelElement message = shadowRoot.querySelector("#message");
      message.text = '';
      Contact contact = contacts.find(num);
      //window.alert(contact.toString());
      contacts.remove(contact);
      save(); 
      //message.text = 'Suppression effectuée; ${message.text}'; 
      window.location.assign(window.location.href);
    }
    
    //window.alert('Supprimer le contact : '+ id);
    //if (contacts.remove(contact)) save();
    //category = categories.find(code);
    //categories.remove(category);
  }

  save() {
    window.localStorage['polymer_contacts'] = JSON.encode(Model.one.toJson());
  }
}