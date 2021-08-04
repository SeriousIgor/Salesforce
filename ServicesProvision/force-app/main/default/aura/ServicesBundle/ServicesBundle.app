<aura:application implements="flexipage:availableForAllPageTypes" access="global">
    <aura:handler name="init" value="{!this}" action="{!c.init}"/>
   	<div class="row">
        <lightning:input name="animalIdInput" label="Animal get" placeholder="Enter id..."/>
        <lightning:button variant="base" label="Base" title="Base action" onclick="{! c.handleClick }"/>
    </div>
</aura:application>