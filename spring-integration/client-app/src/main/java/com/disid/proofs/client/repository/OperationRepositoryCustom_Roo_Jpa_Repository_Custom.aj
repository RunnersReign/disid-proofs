// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.disid.proofs.client.repository;

import com.disid.proofs.client.domain.Operation;
import com.disid.proofs.client.domain.Person;
import com.disid.proofs.client.domain.Tool;
import com.disid.proofs.client.repository.OperationRepositoryCustom;
import io.springlets.data.domain.GlobalSearch;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

privileged aspect OperationRepositoryCustom_Roo_Jpa_Repository_Custom {
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param person
     * @param globalSearch
     * @param pageable
     * @return Page
     */
    public abstract Page<Operation> OperationRepositoryCustom.findByPerson(Person person, GlobalSearch globalSearch, Pageable pageable);
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param tools
     * @param globalSearch
     * @param pageable
     * @return Page
     */
    public abstract Page<Operation> OperationRepositoryCustom.findByTools(Tool tools, GlobalSearch globalSearch, Pageable pageable);
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param globalSearch
     * @param pageable
     * @return Page
     */
    public abstract Page<Operation> OperationRepositoryCustom.findAll(GlobalSearch globalSearch, Pageable pageable);
    
}
