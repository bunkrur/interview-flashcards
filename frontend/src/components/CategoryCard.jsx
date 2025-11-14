import { Link } from 'react-router-dom';

function CategoryCard({ category }) {
  const { name, slug, description, color, icon, card_count } = category;

  return (
    <Link
      to={`/category/${slug}`}
      className="card hover:shadow-lg transition-shadow duration-200 cursor-pointer group"
    >
      <div className="flex items-start justify-between mb-4">
        <div
          className="text-4xl p-3 rounded-lg"
          style={{ backgroundColor: `${color}20` }}
        >
          {icon}
        </div>
        <span className="text-sm text-gray-500 bg-gray-100 px-2 py-1 rounded">
          {card_count} {card_count === 1 ? 'card' : 'cards'}
        </span>
      </div>

      <h3 className="text-xl font-semibold text-gray-900 mb-2 group-hover:text-primary-600 transition-colors">
        {name}
      </h3>

      {description && (
        <p className="text-gray-600 text-sm line-clamp-2">{description}</p>
      )}
    </Link>
  );
}

export default CategoryCard;
