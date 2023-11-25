(define (domain PlanLectura)
    (:requirements :strips :typing :adl :fluents)

    (:types libros_catalog mes - object
            ;l_leido l_porleer - libros_catalog
    )


    (:predicates
        (predecesor ?l1 - libros_catalog ?l2 - libros_catalog)
        (leido ?l - libros_catalog)
        (quiere_leer ?l - libros_catalog)
        (paralelos ?l1 - libros_catalog ?l2 - libros_catalog)
        ;(mesactual ?m - mes)
        (mes_anterior ?m1 - mes ?m2 - mes)
        (mes_lectura ?l - libros_catalog ?m - mes)
    )


    ;(:functions 
       ; (libros_leidos) ;?l - libros_catalog)
       ; (mes_leido ?m - mes)
   ; )

    ; 1. accion de leer si tenemos libros predecesores y paralelos
    (:action leer
        :parameters (?l1 - libros_catalog ?m1 - mes ?m2 - mes)
        :precondition (and
                        (not(leido ?l1)) 
                        
                        (forall (?l2 - libros_catalog)
                                (imply (predecesor ?l2 ?l1) 
                                (and (leido ?l2) (mes_lectura ?l2 ?m2))) 
                        )
                
                        (forall (?l2 - libros_catalog) 
                            (imply (paralelos ?l2 ?l1) 
                                (and (leido ?l2) (mes_lectura ?l2 ?m1)))
                        ) 

                        (mes_anterior ?m2 ?m1)
                      
                      )

        :effect (and (leido ?l1)
                     (mes_lectura ?l1 ?m1)
                     ;(when (quiere_leer ?l1) (increase (llegits) 1))
                )
    )


)