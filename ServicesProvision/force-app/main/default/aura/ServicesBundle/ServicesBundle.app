<aura:application implements="flexipage:availableForAllPageTypes" controller="AnimalController" access="global">
    <!--<aura:handler name="init" value="{!this}" action="{!c.init}"/> -->
    <aura:attribute name="animalId" type="String"/>
    <aura:attribute name="animalListWrapper" type="Object"/>
   	<div class="row">
        <lightning:input id="AnimalExtID" name="animalIdInput" label="Animal get" placeholder="Enter id..." value="{!v.animalId}"/>
        <lightning:button variant="base" label="Get animals by id" title="Get animals" onclick="{! c.handleClick }"/>
    </div>
    
    <div>
        <table class="a-table" aria-labelledby="">
            <thead>
                <tr class="">
                    <th class="" scope="col">
                        <div class="slds-truncate" title="Animal Name">Animal Name</div>
                    </th>
                    <th class="" scope="col">
                        <div class="slds-truncate" title="Says">Says</div>
                    </th>
                    <th class="" scope="col">
                        <div class="slds-truncate" title="Eats">Eats</div>
                    </th>
                    <th class="" scope="col">
                        <div class="slds-truncate" title="ExternalId">External Id</div>
                    </th>
                </tr>
            </thead>
            <tbody>
                <tr class="">
                  <td data-label="Animal Name">
                    <div class="" title="nameValue">Chicken</div>
                  </td>
                  <td data-label="Says">
                    <div class="" title="saysValue">Cluck</div>
                  </td>
                  <td data-label="Eats">
                    <div class="" title="EatsValue">Chicken food</div>
                  </td>
                  <td data-label="ExternalId">
                    <div class="" title="idValue">1</div>
                  </td>
                </tr>
            </tbody>
        </table>
    </div>
     
    
</aura:application>