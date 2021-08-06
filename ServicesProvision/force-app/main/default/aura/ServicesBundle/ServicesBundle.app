<aura:application implements="flexipage:availableForAllPageTypes" controller="AnimalController" access="global">
    <!--<aura:handler name="init" value="{!this}" action="{!c.init}"/> -->
    <aura:attribute name="animalId" type="String"/>
    <aura:attribute name="animalListWrapper" type="Object"/>
   	<div class="row">
        <lightning:input id="AnimalExtID" name="animalIdInput" label="Animal get" placeholder="Enter id..." value="{!v.animalId}"/>
        <lightning:button variant="base" label="Get animals by id" title="Get animals" onclick="{! c.handleClick }"/>
    </div>
    <div>
        <table id="atable" class="a-table" aria-labelledby="">
            <thead>
                <tr class="">
                    <th class="a-th" scope="col">
                        <div class="slds-truncate" title="Animal Name">Animal Name</div>
                    </th>
                    <th class="a-th" scope="col">
                        <div class="slds-truncate" title="Says">Says</div>
                    </th>
                    <th class="a-th" scope="col">
                        <div class="slds-truncate" title="Eats">Eats</div>
                    </th>
                    <th class="a-th" scope="col">
                        <div class="slds-truncate" title="ExternalId">External Id</div>
                    </th>
                </tr>
            </thead>
            <tbody>
                <aura:iteration items="{!v.animalListWrapper}" var="item">
                    <tr class="">
                      <td data-label="Animal Name">
                        <div class="a-td" title="nameValue">{!item.name}</div>
                      </td>
                      <td data-label="Says">
                        <div class="a-td" title="saysValue">{!item.says}</div>
                      </td>
                      <td data-label="Eats">
                        <div class="a-td" title="EatsValue">{!item.eats}</div>
                      </td>
                      <td data-label="ExternalId">
                        <div class="a-td" title="idValue">{!item.externalId}</div>
                      </td>
                    </tr>
    			</aura:iteration>
            </tbody>
        </table>
    </div>
     
    
</aura:application>