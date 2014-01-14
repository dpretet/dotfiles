


"Search and replace , by ; on nline lines
function ReplaceComma(nline)
    
    let i=0
    while (i<a:nline)        
        :s/,/;/g 
        let i+=1
        normal j
    endwhile

endfunction

function DeleteLastChar(nline)
    
    let i=0
    while (i<a:nline)        
        normal $
        normal x
        let i+=1
        normal j
    endwhile

endfunction


"Insert bracket at the end of the line to construct the instance
function InsertBracket(nline)

    let i=0
    while (i<a:nline)
        :s/$/              (       ),
        let i+=1
        normal j
    endwhile
        
endfunction

