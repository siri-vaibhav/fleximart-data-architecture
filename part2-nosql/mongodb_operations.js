// Note:
// The provided products_catalog.json dataset demonstrates nested documents with embedded reviews and specifications. Similar MongoDB operations can be applied on that dataset to perform aggregations such as average rating per product.


// MongoDB Operations for FlexiMart
// Database: fleximart_nosql
// Collection: reviews

// 1. Insert sample documents into the reviews collection
db.reviews.insertMany([
  {
    review_id: "R001",
    product_id: "P001",
    customer_name: "John Doe",
    rating: 5,
    review_text: "Excellent product, very satisfied!",
    review_date: ISODate("2024-01-10")
  },
  {
    review_id: "R002",
    product_id: "P002",
    customer_name: "Sara Khan",
    rating: 4,
    review_text: "Good quality, but delivery was slow.",
    review_date: ISODate("2024-01-12")
  },
  {
    review_id: "R003",
    product_id: "P001",
    customer_name: "Amit Shah",
    rating: 3,
    review_text: "Average experience, could be better.",
    review_date: ISODate("2024-01-15")
  }
]);

// 2. Find all reviews with rating greater than or equal to 4
db.reviews.find({ rating: { $gte: 4 } });

// 3. Aggregate average rating per product
db.reviews.aggregate([
  {
    $group: {
      _id: "$product_id",
      average_rating: { $avg: "$rating" },
      total_reviews: { $sum: 1 }
    }
  }
]);

// 4. Update a review by review_id
db.reviews.updateOne(
  { review_id: "R003" },
  {
    $set: {
      rating: 4,
      review_text: "Improved after replacement, satisfied now."
    }
  }
);

// 5. Find top-rated products (average rating >= 4)
db.reviews.aggregate([
  {
    $group: {
      _id: "$product_id",
      avg_rating: { $avg: "$rating" }
    }
  },
  {
    $match: {
      avg_rating: { $gte: 4 }
    }
  }
]);