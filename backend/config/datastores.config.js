module.exports = {
  // computate_engine: {
  //   dialect: 'sqlite',
  //   storage: 'storage/database/compute_engine.db'
  // },
  // utility: {
  //   dialect: 'sqlite',
  //   storage: 'storage/database/utility.db'
  // }
  computate_engine: {
    dialect: 'mssql',
    host: process.env.DB_HOST,
    database: process.env.DB_DATABASE,
    dialectOptions: {
      authentication: {
        type: 'azure-active-directory-service-principal-secret',
        options: {
          clientId: process.env.DB_CLIENTID,
          clientSecret: process.env.DB_CLIENT_SECRET,
          tenantId: process.env.DB_TENANTID,
        },
      }
    }
  },
  utility: {
    dialect: 'mssql',
    host: process.env.DB_HOST,
    database: process.env.DB_DATABASE,
    dialectOptions: {
      authentication: {
        type: 'azure-active-directory-service-principal-secret',
        options: {
          clientId: process.env.DB_CLIENTID,
          clientSecret: process.env.DB_CLIENT_SECRET,
          tenantId: process.env.DB_TENANTID,
        },
      }
    }
  }
};