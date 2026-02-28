import { defineCollection, z } from 'astro:content';

const blog = defineCollection({
	// .passthrough() を追加。定義していない項目（tagsやauthorなど）があってもエラーにせず通します
	schema: z.object({
		title: z.string(),
		description: z.string(),
		pubDate: z.coerce.date(),
		heroImage: z.string().optional(),
		category: z.string().optional(),
	}).passthrough(), 
});

export const collections = { blog };