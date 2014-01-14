"Insert bracket at the end of the line to construct the instance
function FinishPrintLine(nline)

    let i=0
    while (i<a:nline)
        normal $
        :s/\n/");\r
        let i+=1
        normal j
    endwhile
        
endfunction

