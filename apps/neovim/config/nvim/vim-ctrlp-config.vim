" Open file in a new tab instead of a new buffer
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<2-LeftMouse>'],
    \ 'AcceptSelection("t")': ['<cr>'],
    \ }

" Default to search by filename
nmap <c-p> 
let g:ctrlp_by_filename = 1
