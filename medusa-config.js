const dotenv = require('dotenv')

let ENV_FILE_NAME = '';
switch (process.env.NODE_ENV) {
  case 'production':
    ENV_FILE_NAME = '.env.production';
    break;
  case 'staging':
    ENV_FILE_NAME = '.env.staging';
    break;
  case 'test':
    ENV_FILE_NAME = '.env.test';
    break;
  case 'development':
  default:
    ENV_FILE_NAME = '.env';
    break;
}

try {
  dotenv.config({ path: process.cwd() + '/' + ENV_FILE_NAME });
} catch (e) {
}

// CORS when consuming Medusa from admin
// const ADMIN_CORS = process.env.ADMIN_CORS || "http://localhost:7700,http://localhost:7701";
const ADMIN_CORS = process.env.ADMIN_CORS || "https://frolicking-bunny-457b9d.netlify.app";

// CORS to avoid issues when consuming Medusa from a client
// const STORE_CORS = process.env.STORE_CORS || "http://localhost:8100,http://storefront:8100";
const STORE_CORS = process.env.STORE_CORS || " https://deluxe-chebakia-ad2b74.netlify.app";

// Database URL (here we use a local database called medusa-development)
const DATABASE_URL =
  // process.env.DATABASE_URL || "postgres://localhost/medusa-store";
  DATABASE_URL="postgres://yynid:Syw!888888@localhost:5432/medusa_db"

// Medusa uses Redis, so this needs configuration as well
// const REDIS_URL = process.env.REDIS_URL || "redis://localhost:6379";
const REDIS_URL = process.env.REDIS_URL || "redis://red-cjb56ppitvpc73eok84g:6379";

// Stripe keys
const STRIPE_API_KEY = process.env.STRIPE_API_KEY || "pk_live_51NdOyMGHWQ38AB7XcAxORp5dAbpZ5rxqGfFvVe0o0w75vmlzGHnY8YxLHedEoRFOzMw4K6A6ot3fd6oX98u6LFj000KUErzPDd";
const STRIPE_WEBHOOK_SECRET = process.env.STRIPE_WEBHOOK_SECRET || "";

// This is the place to include plugins. See API documentation for a thorough guide on plugins.
const plugins = [
  `medusa-fulfillment-manual`,
  `medusa-payment-manual`,
  `medusa-file-minio`,
  // Minio
  {
    resolve: `medusa-file-minio`,
    options: {
      endpoint: process.env.MINIO_ENDPOINT,
      bucket: process.env.MINIO_BUCKET,
      access_key_id: process.env.MINIO_ACCESS_KEY,
      secret_access_key: process.env.MINIO_SECRET_KEY,
    },
  },
  // Uncomment to add Stripe support.
  // You can create a Stripe account via: https://stripe.com
  {
    resolve: `medusa-payment-stripe`,
    options: {
      api_key: STRIPE_API_KEY,
      webhook_secret: STRIPE_WEBHOOK_SECRET,
    },
  },
  {
  resolve: `medusa-plugin-meilisearch`,
  options: {
    // config object passed when creating an instance of the MeiliSearch client
    config: {
      host: "http://127.0.0.1:7700",
      apiKey: "your_master_key",
    },
    settings: {
      // index name
      products: {
        // MeiliSearch's setting options to be set on a particular index
        searchableAttributes: ["title", "description", "variant_sku", "thumbnail", "variants"],
        displayedAttributes: ["title", "description", "variant_sku", "thumbnail", "variants"],
      },
    },
  },
},
  //...
  // {
  //   resolve: `@medusajs/file-local`,
  //   options: {
  //     upload_dir: './uploads', // optional
  //     #backend_url: 'ruaa.ruaa.ontheweb.nu', // optional
  //   },
  // },
];

module.exports = {
  projectConfig: {
    redis_url: REDIS_URL,
    database_url: DATABASE_URL,
    database_type: "postgres",
    //database_database: "./medusa-db.sql",
    //database_type: "sqlite",
    store_cors: STORE_CORS,
    admin_cors: ADMIN_CORS,
    database_extra: { ssl: { rejectUnauthorized: false } },
  },
  plugins,
};
