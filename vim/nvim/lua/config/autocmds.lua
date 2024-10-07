-- compile

-- C/C++ 
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp", "h" },
    command = "nnoremap <F5> <bar> :w <bar> !g++ -I /$(pwd) -std=c++20 -g -Wall % -o %:r<cr>",
})
