// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.springframework.roo.petclinic.web;

import io.springlets.data.domain.GlobalSearch;
import io.springlets.data.web.datatables.Datatables;
import io.springlets.data.web.datatables.DatatablesData;
import io.springlets.data.web.datatables.DatatablesPageable;
import io.springlets.web.NotFoundException;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import org.joda.time.format.DateTimeFormat;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.data.domain.Page;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.roo.petclinic.domain.Vet;
import org.springframework.roo.petclinic.domain.Visit;
import org.springframework.roo.petclinic.service.api.VetService;
import org.springframework.roo.petclinic.service.api.VisitService;
import org.springframework.roo.petclinic.web.VetsCollectionThymeleafController;
import org.springframework.roo.petclinic.web.VetsItemVisitsThymeleafController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.UriComponents;

privileged aspect VetsItemVisitsThymeleafController_Roo_Thymeleaf {
    
    declare @type: VetsItemVisitsThymeleafController: @Controller;
    
    declare @type: VetsItemVisitsThymeleafController: @RequestMapping(value = "/vets/{vet}/visits", name = "VetsItemVisitsThymeleafController", produces = MediaType.TEXT_HTML_VALUE);
    
    /**
     * TODO Auto-generated attribute documentation
     */
    public MessageSource VetsItemVisitsThymeleafController.messageSource;
    
    /**
     * TODO Auto-generated constructor documentation
     * 
     * @param vetService
     * @param visitService
     * @param messageSource
     */
    @Autowired
    public VetsItemVisitsThymeleafController.new(VetService vetService, VisitService visitService, MessageSource messageSource) {
        this.vetService = vetService;
        this.visitService = visitService;
        this.messageSource = messageSource;
    }

    /**
     * TODO Auto-generated method documentation
     * 
     * @param id
     * @return Vet
     */
    @ModelAttribute
    public Vet VetsItemVisitsThymeleafController.getVet(@PathVariable("vet") Long id) {
        Vet vet = vetService.findOne(id);
        if (vet == null) {
            throw new NotFoundException(String.format("Vet with identifier '%s' not found",id));
        }
        return vet;
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param model
     */
    public void VetsItemVisitsThymeleafController.populateFormats(Model model) {
        model.addAttribute("application_locale", LocaleContextHolder.getLocale().getLanguage());
        model.addAttribute("visitDate_date_format", DateTimeFormat.patternForStyle("M-", LocaleContextHolder.getLocale()));
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param model
     */
    public void VetsItemVisitsThymeleafController.populateForm(Model model) {
        populateFormats(model);
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param vet
     * @param search
     * @param pageable
     * @param draw
     * @return ResponseEntity
     */
    @GetMapping(name = "datatables", produces = Datatables.MEDIA_TYPE, value = "/dt")
    @ResponseBody
    public ResponseEntity<DatatablesData<Visit>> VetsItemVisitsThymeleafController.datatables(@ModelAttribute Vet vet, GlobalSearch search, DatatablesPageable pageable, @RequestParam("draw") Integer draw) {
        
        Page<Visit> visits = visitService.findByVet(vet, search, pageable);
        long totalVisitsCount = visitService.countByVet(vet);
        DatatablesData<Visit> data =  new DatatablesData<Visit>(visits, totalVisitsCount, draw);
        return ResponseEntity.ok(data);
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param Vet
     * @param model
     * @return ModelAndView
     */
    @GetMapping(value = "/create-form", name = "createForm")
    public ModelAndView VetsItemVisitsThymeleafController.createForm(@ModelAttribute Vet Vet, Model model) {
        populateForm(model);
        
        model.addAttribute(new Visit());
        return new ModelAndView("vets/visits/create");
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param vet
     * @param visitsToRemove
     * @return ResponseEntity
     */
    @DeleteMapping(name = "removeFromVisits", value = "/{visitsToRemove}")
    @ResponseBody
    public ResponseEntity<?> VetsItemVisitsThymeleafController.removeFromVisits(@ModelAttribute Vet vet, @PathVariable("visitsToRemove") Long visitsToRemove) {
        vetService.removeFromVisits(vet,Collections.singleton(visitsToRemove));
        return ResponseEntity.ok().build();
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param vet
     * @param visits
     * @param model
     * @return ModelAndView
     */
    @PostMapping(name = "create")
    public ModelAndView VetsItemVisitsThymeleafController.create(@ModelAttribute Vet vet, @RequestParam("visitsIds") List<Long> visits, Model model) {
        // Remove empty values
        for (Iterator<Long> iterator = visits.iterator(); iterator.hasNext();) {
            if (iterator.next() == null) {
                iterator.remove();
            }
        }
        vetService.setVisits(vet,visits);
        UriComponents listURI = VetsCollectionThymeleafController.listURI();
        return new ModelAndView("redirect:" + listURI.toUriString());
    }
    
}
