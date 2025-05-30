return {
  "avante",
  enabled = true,
  event = "DeferredUIEnter",
  build = "make",
  after = function()
    require("avante_lib").load()
    require("avante").setup({
      provider = "openai",
      openai = {
        endpoint = "https://api.openai.com/v1",
        model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
        --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
        api_key_name = "OPENAI_API_KEY",
      },
      web_search_engine = {
        provider = "tavily", -- tavily, serpapi, searchapi, google, kagi, brave, or searxng
        proxy = nil, -- proxy support, e.g., http://127.0.0.1:7890
      },
      rag_service = {
        enabled = false, -- Enables the RAG service
        host_mount = os.getenv("HOME"), -- Host mount path for the rag service
        provider = "openai", -- The provider to use for RAG service (e.g. openai or ollama)
        -- llm_model = "", -- The LLM model to use for RAG service
        -- embed_model = "", -- The embedding model to use for RAG service
        endpoint = "https://api.openai.com/v1", -- The API endpoint for RAG service
      },
    })
  end,
}
