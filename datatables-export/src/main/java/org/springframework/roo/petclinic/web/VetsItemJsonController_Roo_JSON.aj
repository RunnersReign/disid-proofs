// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.springframework.roo.petclinic.web;

import io.springlets.web.NotFoundException;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.roo.petclinic.domain.Vet;
import org.springframework.roo.petclinic.service.api.VetService;
import org.springframework.roo.petclinic.web.VetsItemJsonController;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.method.annotation.MvcUriComponentsBuilder;
import org.springframework.web.util.UriComponents;

privileged aspect VetsItemJsonController_Roo_JSON {
    
    declare @type: VetsItemJsonController: @RestController;
    
    declare @type: VetsItemJsonController: @RequestMapping(value = "/vets/{vet}", name = "VetsItemJsonController", produces = MediaType.APPLICATION_JSON_VALUE);
    
    /**
     * TODO Auto-generated constructor documentation
     * 
     * @param vetService
     */
    @Autowired
    public VetsItemJsonController.new(VetService vetService) {
        this.vetService = vetService;
    }

    /**
     * TODO Auto-generated method documentation
     * 
     * @param id
     * @return Vet
     */
    @ModelAttribute
    public Vet VetsItemJsonController.getVet(@PathVariable("vet") Long id) {
        Vet vet = vetService.findOne(id);
        if (vet == null) {
            throw new NotFoundException(String.format("Vet with identifier '%s' not found",id));
        }
        return vet;
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param vet
     * @return ResponseEntity
     */
    @GetMapping(name = "show")
    public ResponseEntity<?> VetsItemJsonController.show(@ModelAttribute Vet vet) {
        return ResponseEntity.status(HttpStatus.FOUND).body(vet);
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param vet
     * @return UriComponents
     */
    public static UriComponents VetsItemJsonController.showURI(Vet vet) {
        return MvcUriComponentsBuilder
            .fromMethodCall(
                MvcUriComponentsBuilder.on(VetsItemJsonController.class).show(vet))
            .buildAndExpand(vet.getId()).encode();
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param storedVet
     * @param vet
     * @param result
     * @return ResponseEntity
     */
    @PutMapping(name = "update")
    public ResponseEntity<?> VetsItemJsonController.update(@ModelAttribute Vet storedVet, @Valid @RequestBody Vet vet, BindingResult result) {
        
        if (result.hasErrors()) {
            return ResponseEntity.status(HttpStatus.CONFLICT).body(result);
        }
        vet.setId(storedVet.getId());
        vetService.save(vet);
        return ResponseEntity.ok().build();
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param vet
     * @return ResponseEntity
     */
    @DeleteMapping(name = "delete")
    public ResponseEntity<?> VetsItemJsonController.delete(@ModelAttribute Vet vet) {
        vetService.delete(vet);
        return ResponseEntity.ok().build();
    }
    
}
