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

export const suggestEmoji = async (req, res) => {
  try {
    const { categoryName } = req.body;

    if (!categoryName) {
      return res.status(400).json({ error: 'Category name is required' });
    }

    // Check if API key is configured
    if (!process.env.ANTHROPIC_API_KEY || process.env.ANTHROPIC_API_KEY === 'your-api-key-here') {
      return res.status(503).json({
        error: 'AI service not configured',
        message: 'Please add your Anthropic API key to the .env file'
      });
    }

    const prompt = `Given the category name "${categoryName}", suggest a single appropriate emoji that best represents this category.

Return ONLY a single emoji character, nothing else. No explanations, no text, just the emoji.

Examples:
- "JavaScript" -> 💛
- "Python" -> 🐍
- "Docker" -> 🐳
- "Security" -> 🔒
- "Databases" -> 🗄️

Category: ${categoryName}
Emoji:`;

    const message = await anthropic.messages.create({
      model: 'claude-sonnet-4-5-20250929',
      max_tokens: 10,
      messages: [
        {
          role: 'user',
          content: prompt,
        },
      ],
    });

    const emoji = message.content[0].text.trim();

    res.json({
      emoji,
      categoryName,
    });
  } catch (error) {
    console.error('Error suggesting emoji:', error);

    if (error.status === 401) {
      return res.status(401).json({
        error: 'Invalid API key',
        message: 'Please check your Anthropic API key in the .env file'
      });
    }

    res.status(500).json({
      error: 'Failed to suggest emoji',
      message: error.message
    });
  }
};

export const enhanceFlashcard = async (req, res) => {
  try {
    const { question, answer, explanation, code_snippet, difficulty } = req.body;

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

    const prompt = `You are an expert educational content creator. Enhance the following flashcard by:
1. Improving the answer with more clarity, detail, and practical examples
2. Adding or improving the explanation with real-world context and use cases
3. Adding or improving code snippets if relevant (for technical topics)
4. Suggesting an appropriate difficulty level if needed

Current Flashcard:
- Question: ${question}
- Answer: ${answer}
- Explanation: ${explanation || 'None provided'}
- Code Snippet: ${code_snippet || 'None provided'}
- Difficulty: ${difficulty || 'medium'}

Return ONLY a valid JSON object with this exact structure:
{
  "answer": "Enhanced answer with more details and examples",
  "explanation": "Enhanced explanation with practical context",
  "code_snippet": "Enhanced or new code snippet (or null if not applicable)",
  "difficulty": "easy|medium|hard",
  "enhancements": "Brief summary of what was improved"
}

Guidelines:
- Keep the answer concise but comprehensive (2-4 paragraphs max)
- Add practical examples and use cases in the explanation
- Include code snippets for technical topics
- Make difficulty appropriate to the content complexity
- Focus on making the flashcard more valuable for interview preparation
- Return ONLY the JSON object, no markdown formatting`;

    const message = await anthropic.messages.create({
      model: 'claude-sonnet-4-5-20250929',
      max_tokens: 2048,
      messages: [
        {
          role: 'user',
          content: prompt,
        },
      ],
    });

    let responseText = message.content[0].text;

    // Strip markdown code blocks if present
    const jsonCodeBlockRegex = /```(?:json)?\s*([\s\S]*?)\s*```/;
    const match = responseText.match(jsonCodeBlockRegex);
    if (match) {
      responseText = match[1].trim();
    }

    // Parse the JSON response
    let enhancement;
    try {
      enhancement = JSON.parse(responseText);
    } catch (parseError) {
      console.error('Failed to parse AI response:', responseText);
      return res.status(500).json({
        error: 'Failed to parse AI response',
        message: 'The AI returned an invalid format. Please try again.'
      });
    }

    // Validate response has required fields
    if (!enhancement.answer) {
      return res.status(500).json({
        error: 'Invalid enhancement',
        message: 'The AI did not provide a valid enhanced answer.'
      });
    }

    res.json({
      enhancement,
      usage: {
        input_tokens: message.usage.input_tokens,
        output_tokens: message.usage.output_tokens,
      },
    });
  } catch (error) {
    console.error('Error enhancing flashcard:', error);

    if (error.status === 401) {
      return res.status(401).json({
        error: 'Invalid API key',
        message: 'Please check your Anthropic API key in the .env file'
      });
    }

    res.status(500).json({
      error: 'Failed to enhance flashcard',
      message: error.message
    });
  }
};

export const generateFlashcards = async (req, res) => {
  try {
    const { text, category_id } = req.body;

    if (!text) {
      return res.status(400).json({ error: 'Text content is required' });
    }

    if (!category_id) {
      return res.status(400).json({ error: 'Category selection is required' });
    }

    // Check if API key is configured
    if (!process.env.ANTHROPIC_API_KEY || process.env.ANTHROPIC_API_KEY === 'your-api-key-here') {
      return res.status(503).json({
        error: 'AI service not configured',
        message: 'Please add your Anthropic API key to the .env file'
      });
    }

    const prompt = `You are a helpful assistant that generates flashcards from educational content.

Analyze the following text and generate flashcards for interview preparation. Each flashcard should have:
- A clear, specific question
- A comprehensive answer
- Difficulty level (easy, medium, or hard)
- An explanation that provides additional context
- A code snippet if relevant (optional)

Text to analyze:
${text}

Return ONLY a valid JSON array of flashcards with this exact structure:
[
  {
    "question": "The question text",
    "answer": "The answer text",
    "difficulty": "easy|medium|hard",
    "explanation": "Additional context and explanation",
    "code_snippet": "optional code example or null"
  }
]

Guidelines:
- Generate 3-10 flashcards depending on content richness
- Questions should test understanding, not just memorization
- Include code snippets for programming concepts
- Make questions interview-focused
- Ensure answers are concise but complete
- Return ONLY the JSON array, no markdown formatting or additional text`;

    const message = await anthropic.messages.create({
      model: 'claude-sonnet-4-5-20250929',
      max_tokens: 4096,
      messages: [
        {
          role: 'user',
          content: prompt,
        },
      ],
    });

    let responseText = message.content[0].text;

    // Strip markdown code blocks if present
    const jsonCodeBlockRegex = /```(?:json)?\s*([\s\S]*?)\s*```/;
    const match = responseText.match(jsonCodeBlockRegex);
    if (match) {
      responseText = match[1].trim();
    }

    // Parse the JSON response
    let flashcards;
    try {
      flashcards = JSON.parse(responseText);
    } catch (parseError) {
      console.error('Failed to parse AI response:', responseText);
      return res.status(500).json({
        error: 'Failed to parse AI response',
        message: 'The AI returned an invalid format. Please try again.'
      });
    }

    // Validate flashcards array
    if (!Array.isArray(flashcards) || flashcards.length === 0) {
      return res.status(500).json({
        error: 'Invalid flashcards generated',
        message: 'No flashcards were generated from the text.'
      });
    }

    // Validate each flashcard has required fields
    const validFlashcards = flashcards.filter(card =>
      card.question && card.answer && card.difficulty
    );

    if (validFlashcards.length === 0) {
      return res.status(500).json({
        error: 'No valid flashcards generated',
        message: 'The generated flashcards were missing required fields.'
      });
    }

    res.json({
      flashcards: validFlashcards,
      count: validFlashcards.length,
      usage: {
        input_tokens: message.usage.input_tokens,
        output_tokens: message.usage.output_tokens,
      },
    });
  } catch (error) {
    console.error('Error generating flashcards:', error);

    if (error.status === 401) {
      return res.status(401).json({
        error: 'Invalid API key',
        message: 'Please check your Anthropic API key in the .env file'
      });
    }

    res.status(500).json({
      error: 'Failed to generate flashcards',
      message: error.message
    });
  }
};
