# Gemini API Plugin

Google Gemini API integration for Claude Code, providing text generation, multimodal analysis, image generation (Nano Banana), function calling, search grounding, and embeddings via REST API.

## Prerequisites

Set your Google API key as an environment variable:

```bash
export GOOGLE_API_KEY="your-api-key-here"
```

Get your API key from [Google AI Studio](https://aistudio.google.com/apikey).

## Skills

### gemini

Core generation skill using the `generateContent` API. Supports:

- **Text Generation**: Basic prompts, chat, Q&A with configurable parameters
- **Multimodal Analysis**: Analyze images, videos, and audio
- **Image Generation (Nano Banana)**: Create and edit images with character consistency
- **Function Calling**: Execute custom functions based on natural language
- **Search Grounding**: Real-time web search integration
- **JSON Mode**: Structured output in JSON format
- **Streaming**: Server-sent events for real-time responses

**Trigger keywords**: "use gemini", "ask gemini", "gemini chat", "gemini image"

### gemini-embed

Embedding generation using the `embedContent` API. Supports:

- **Single Embedding**: Generate embedding for one text
- **Batch Embedding**: Process multiple texts efficiently
- **Task Types**: Optimize for retrieval, similarity, classification, or clustering
- **Dimensionality Control**: Truncate embeddings for efficiency

**Trigger keywords**: "gemini embed", "gemini embedding", "text to vector"

## Available Models

| Model | Purpose |
|-------|---------|
| `gemini-2.5-flash` | Fast text generation |
| `gemini-2.5-pro` | High quality text generation |
| `gemini-3-flash-preview` | Latest flash model |
| `gemini-3-pro-preview` | Latest pro model |
| `gemini-2.5-flash-image` | Image generation (Nano Banana) |
| `gemini-3-pro-image-preview` | Advanced image generation (4K, thinking, search) |
| `gemini-embedding-001` | Text embeddings |

## Quick Examples

### Text Generation

```bash
curl "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=$GOOGLE_API_KEY" \
    -H 'Content-Type: application/json' \
    -d '{"contents": [{"parts": [{"text": "Hello!"}]}]}'
```

### Image Generation

```bash
curl "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash-image:generateContent?key=$GOOGLE_API_KEY" \
    -H 'Content-Type: application/json' \
    -d '{
      "contents": [{"parts": [{"text": "A cat wearing a hat"}]}],
      "generationConfig": {"responseModalities": ["TEXT", "IMAGE"]}
    }'
```

### Embeddings

```bash
curl "https://generativelanguage.googleapis.com/v1beta/models/gemini-embedding-001:embedContent?key=$GOOGLE_API_KEY" \
    -H 'Content-Type: application/json' \
    -d '{
      "model": "models/gemini-embedding-001",
      "content": {"parts": [{"text": "Hello world"}]}
    }'
```

## Documentation

- [Gemini API Documentation](https://ai.google.dev/gemini-api/docs)
- [Image Generation (Nano Banana)](https://ai.google.dev/gemini-api/docs/image-generation)
- [Embeddings Guide](https://ai.google.dev/gemini-api/docs/embeddings)
- [Function Calling](https://ai.google.dev/gemini-api/docs/function-calling)

## License

MIT
