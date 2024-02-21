return {
    "nvim-telescope/telescope.nvim",
    
    dependencies = {
        "nvim-lua/plenary.nvim"
    },

    config = function()
        require('telescope').setup({})

        -- TODO: More config, especially key mappings here

    end
}
