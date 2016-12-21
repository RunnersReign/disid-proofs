// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.springframework.roo.petclinic.dod;

import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.roo.petclinic.dod.PetDataOnDemand;
import org.springframework.roo.petclinic.dod.VetDataOnDemand;
import org.springframework.roo.petclinic.dod.VisitDataOnDemand;
import org.springframework.roo.petclinic.domain.Visit;
import org.springframework.roo.petclinic.repository.VisitRepository;
import org.springframework.stereotype.Component;

privileged aspect VisitDataOnDemand_Roo_DataOnDemand {
    
    declare @type: VisitDataOnDemand: @Component;
    
    /**
     * TODO Auto-generated attribute documentation
     */
    private Random VisitDataOnDemand.rnd = new SecureRandom();
    
    /**
     * TODO Auto-generated attribute documentation
     */
    private List<Visit> VisitDataOnDemand.data;
    
    /**
     * TODO Auto-generated attribute documentation
     */
    public VisitRepository VisitDataOnDemand.visitRepository;
    
    /**
     * TODO Auto-generated attribute documentation
     */
    @Autowired
    PetDataOnDemand VisitDataOnDemand.petDataOnDemand;
    
    /**
     * TODO Auto-generated attribute documentation
     */
    @Autowired
    VetDataOnDemand VisitDataOnDemand.vetDataOnDemand;
    
    /**
     * TODO Auto-generated constructor documentation
     * 
     * @param visitRepository
     */
    public VisitDataOnDemand.new(VisitRepository visitRepository) {
        this.visitRepository = visitRepository;
    }

    /**
     * TODO Auto-generated method documentation
     * 
     * @param index
     * @return Visit
     */
    public Visit VisitDataOnDemand.getNewTransientVisit(int index) {
        Visit obj = new Visit();
        setDescription(obj, index);
        setVisitDate(obj, index);
        return obj;
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param obj
     * @param index
     */
    public void VisitDataOnDemand.setDescription(Visit obj, int index) {
        String description = "description_" + index;
        if (description.length() > 255) {
            description = description.substring(0, 255);
        }
        obj.setDescription(description);
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param obj
     * @param index
     */
    public void VisitDataOnDemand.setVisitDate(Visit obj, int index) {
        Date visitDate = new Date(new Date().getTime() - 10000000L);
        obj.setVisitDate(visitDate);
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param index
     * @return Visit
     */
    public Visit VisitDataOnDemand.getSpecificVisit(int index) {
        init();
        if (index < 0) {
            index = 0;
        }
        if (index > (data.size() - 1)) {
            index = data.size() - 1;
        }
        Visit obj = data.get(index);
        Long id = obj.getId();
        return visitRepository.findOne(id);
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @return Visit
     */
    public Visit VisitDataOnDemand.getRandomVisit() {
        init();
        Visit obj = data.get(rnd.nextInt(data.size()));
        Long id = obj.getId();
        return visitRepository.findOne(id);
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param obj
     * @return Boolean
     */
    public boolean VisitDataOnDemand.modifyVisit(Visit obj) {
        return false;
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     */
    public void VisitDataOnDemand.init() {
        int from = 0;
        int to = 10;
        data = visitRepository.findAll(new org.springframework.data.domain.PageRequest(from / to, to)).getContent();
        if (data == null) {
            throw new IllegalStateException("Find entries implementation for 'Visit' illegally returned null");
        }
        if (!data.isEmpty()) {
            return;
        }
        
        data = new ArrayList<Visit>();
        for (int i = 0; i < 10; i++) {
            Visit obj = getNewTransientVisit(i);
            try {
                visitRepository.save(obj);
            } catch (final ConstraintViolationException e) {
                final StringBuilder msg = new StringBuilder();
                for (Iterator<ConstraintViolation<?>> iter = e.getConstraintViolations().iterator(); iter.hasNext();) {
                    final ConstraintViolation<?> cv = iter.next();
                    msg.append("[").append(cv.getRootBean().getClass().getName()).append(".").append(cv.getPropertyPath()).append(": ").append(cv.getMessage()).append(" (invalid value = ").append(cv.getInvalidValue()).append(")").append("]");
                }
                throw new IllegalStateException(msg.toString(), e);
            }
            visitRepository.flush();
            data.add(obj);
        }
    }
    
}
