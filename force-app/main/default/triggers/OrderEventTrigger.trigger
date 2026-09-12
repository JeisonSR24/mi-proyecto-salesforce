trigger OrderEventTrigger on Order_Event__e (after insert) {
    // 1. Creamos una lista para guardar las tareas que vamos a crear
    List<Task> tasks = new List<Task>();
    
    // 2. Iteramos por cada evento que llega (pueden llegar varios a la vez)
    for (Order_Event__e event : Trigger.New) {
        
        // 3. Verificamos la condición que te pidieron: ¿Se ha enviado el pedido?
        if (event.Has_Shipped__c == true) {
            
            // 4. Creamos la tarea con los datos que te exigen
            Task t = new Task();
            t.Priority = 'Medium';
            t.Subject = 'Follow up on shipped order ' + event.Order_Number__c;
            t.OwnerId = event.CreatedById; // El usuario que lanzó el evento se encarga de la tarea
            
            tasks.add(t);
        }
    }
    
    // 5. Insertamos todas las tareas de una sola vez (Bulkify)
    if (tasks.size() > 0) {
        insert tasks;
    }
}