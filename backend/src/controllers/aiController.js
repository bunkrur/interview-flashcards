import Anthropic from '@anthropic-ai/sdk';

const anthropic = new Anthropic({
  apiKey: process.env.ANTHROPIC_API_KEY,
});

export const explainAnswer = async (req, res) => {
  try {
    const { question, answer, category, explanation } = req.body;

    if (!question || !answer) {
      return res.status(400).json({ error: 'Question and answer are required' });
    }

    // Check if API key is configured
    if (!process.env.ANTHROPIC_API_KEY || process.env.ANTHROPIC_API_KEY === 'your-api-key-here') {
      return res.status(503).json({
        error: 'AI service not configured',
        message: 'Please add your Anthropic API key to the .env file'
      });
    }

    const prompt = `You are a helpful tech tutor explaining flashcard answers.

Question: ${question}
Answer: ${answer}
${explanation ? `Additional context: ${explanation}` : ''}
${category ? `Category: ${category}` : ''}

Please provide:
1. A clear explanation of why this answer is correct
2. Additional context or examples that help understand the concept better
3. Common mistakes or misconceptions related to this topic
4. A practical example or use case if applicable

Keep your response concise but informative (2-3 paragraphs).`;

    const message = await anthropic.messages.create({
      model: 'claude-sonnet-4-5-20250929',
      max_tokens: 1024,
      messages: [
        {
          role: 'user',
          content: prompt,
        },
      ],
    });

    const aiExplanation = message.content[0].text;

    res.json({
      explanation: aiExplanation,
      usage: {
        input_tokens: message.usage.input_tokens,
        output_tokens: message.usage.output_tokens,
      },
    });
  } catch (error) {
    console.error('Error generating AI explanation:', error);

    if (error.status === 401) {
      return res.status(401).json({
        error: 'Invalid API key',
        message: 'Please check your Anthropic API key in the .env file'
      });
    }

    res.status(500).json({
      error: 'Failed to generate explanation',
      message: error.message
    });
  }
};

export const askQuestion = async (req, res) => {
  try {
    const { question, context } = req.body;

    if (!question) {
      return res.status(400).json({ error: 'Question is required' });
    }

    // Check if API key is configured
    if (!process.env.ANTHROPIC_API_KEY || process.env.ANTHROPIC_API_KEY === 'your-api-key-here') {
      return res.status(503).json({
        error: 'AI service not configured',
        message: 'Please add your Anthropic API key to the .env file'
      });
    }

    const prompt = `You are a helpful tech tutor. Answer the following question concisely and accurately.

${context ? `Context: ${context}\n\n` : ''}Question: ${question}

Provide a clear, practical answer in 1-2 paragraphs.`;

    const message = await anthropic.messages.create({
      model: 'claude-sonnet-4-5-20250929',
      max_tokens: 1024,
      messages: [
        {
          role: 'user',
          content: prompt,
        },
      ],
    });

    const answer = message.content[0].text;

    res.json({
      answer,
      usage: {
        input_tokens: message.usage.input_tokens,
        output_tokens: message.usage.output_tokens,
      },
    });
  } catch (error) {
    console.error('Error answering question:', error);

    if (error.status === 401) {
      return res.status(401).json({
        error: 'Invalid API key',
        message: 'Please check your Anthropic API key in the .env file'
      });
    }

    res.status(500).json({
      error: 'Failed to answer question',
      message: error.message
    });
  }
};
