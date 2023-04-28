const request = require("supertest");
const { app } = require("./app");
const { faker } = require("@faker-js/faker");
const path = require("path");
const fs = require("fs");
const mysql = require("mysql");
const db=require('./config')
  // Set up database connection
  // Create test data
 
  afterAll((done) => {
    // Close the database connection
    db.end(done);
  });
const { checkIfUserExists } = require("./controllers/userController"); // replace with the name of your module that exports the three functions

describe("checkIfUserExists", () => {
  test("should return true if user exists", async () => {
    const req = { body: { email: "Misty.Abernathy@hotmail.com" } };
    const result = await checkIfUserExists(req);
    expect(result).toBe(true);
  });

  test("should return false if user does not exist", async () => {
    const req = { body: { email: "nonexistent@example.com" } };
    const result = await checkIfUserExists(req);
    expect(result).toBe(false);
  });
});

describe("registerUser", () => {
  test("should register a new user and return a 200 status code", async () => {
    let randomName = faker.name.fullName();
    let randomEmail = faker.internet.email();
    let randomPassword = faker.internet.password();
    let randomBalance = faker.random.numeric(7);
    const response = await request(app).post("/backend/user/register").send({
      name: randomName,
      email: randomEmail,
      password: randomPassword,
      balance: randomBalance,
    });
    expect(response.statusCode).toBe(200);
  });

  test("should return a 400 status code if user already exists", async () => {
    const req = {
      body: {
        name: "John Doe",
        email: "oussema422oussema@gmail.com",
        password: "password123",
        balance: 100,
      },
    };
    const response = await request(app)
      .post("/backend/user/register")
      .send(req.body);
    expect(response.statusCode).toBe(400);
  });
});

describe("loginUser", () => {
  // test("should log in a user with correct credentials and return a token", async () => {
  //   const req = {
  //     body: {
  //       email: "oussema.besbes@supcom.tn",
  //       password: "98938450",
  //     },
  //   };
  //   const response = await request(app).post("/backend/user/login").send(req.body);
  //   console.log("response body:", response.header); // add this line
  //   expect(response.statusCode).toBe(200);
  //   expect(response.headers).toHaveProperty("auth-token");
  // });

  test("should return a 400 status code if email is wrong", async () => {
    const req = {
      body: {
        email: "nonexistent@example.com",
        password: "password123",
      },
    };
    const response = await request(app).post("/backend/user/login").send(req.body);
    expect(response.statusCode).toBe(400);
  });

  test("should return a 400 status code if password is wrong", async () => {
    const req = {
      body: {
        email: "oussema422oussema@gmail.com",
        password: "wrongpassword",
      },
    };
    const response = await request(app).post("/backend/user/login").send(req.body);
    expect(response.statusCode).toBe(400);
  });
});

describe("one field is missing", () => {
  test("should respond with a status code of 400", async () => {
    const bodyData = [
      { name: "username", email: "email@test.com", balance: 0 },
      { email: "test@gmail.com", password: "helloworld", balance: 0 },
      { name: "besbes", password: "helloworld", balance: 0 },
    ];
    for (const body of bodyData) {
      const response = await request(app).post("/backend/user/register").send(body);
      expect(response.statusCode).toBe(400);
    }
  });
});

describe("createBid", () => {
  test("should insert data successfully with valid input", async () => {
    const req = {
      body: {
        product_id: 1,
        userId: 1,
        bidAmount: 501,
        date: "2024-12-03",
      },
    };
    const response = await request(app).post("/backend/bid/create").send(req.body);
    expect(response.statusCode).toBe(200);
    expect(response.body.message).toBe("Data Inserted Successfully");
  });

 
});

describe("lastBid", () => {
  test("should return the last bid for a product", async () => {
    const productId = 1;
    const response = await request(app).get(`/backend/bid/5`);
    expect(response.statusCode).toBe(200);
  });
});

 describe("createAuction", () => {
  test("should return 400 status code if no file was uploaded", async () => {
    const req = {
      body: {
        productName: "Test Product",
        userId: 1,
        productCategory: 2,
        productDescription: "Test product description",
        auctionDate: "2024-12-03",
      },
    };
    const response = await request(app)
      .post("/backend/auction/create")
      .send(req.body);
    expect(response.statusCode).toBe(400);
    expect(response.text).toBe("No file was uploaded.");
  });
});

describe("displayProducts", () => {
  test("should return products data successfully with valid input", async () => {
    const response = await request(app).get(
      "/backend/auction/display?page=1&limit=10"
    );
    expect(response.statusCode).toBe(200);
    expect(response.body.length).toBeGreaterThanOrEqual(0);
  });
});
describe("countProducts", () => {
  test("should return a count of products", async () => {
    const response = await request(app).get("/backend/auction/count");
    console.log("response.body", response.body);
    expect(response.statusCode).toBe(200);
    expect(response.body[0]).toHaveProperty("count");
  });
});

describe("countProductsCategory", () => {
  test("should return a count of products for a given category", async () => {
    const response = await request(app).get(
      "/backend/auction/countbycategory/1?page=1&limit=10"
    );
    expect(response.statusCode).toBe(200);
    expect(response.body[0]).toHaveProperty("count");
  });
});

describe("getCategories", () => {
  test("should return a list of categories", async () => {
    const response = await request(app).get("/backend/auction/categories");
    expect(response.statusCode).toBe(200);
    expect(response.body).not.toHaveLength(0);
  });
});

describe("displayByCategory", () => {
  test("should return a list of products for a given category", async () => {
    const response = await request(app).get(
      "/backend/auction/countbycategory/1?page=1&limit=10"
    );
    expect(response.statusCode).toBe(200);
    expect(response.body).not.toHaveLength(0);
  });
});
describe("displayProduct", () => {
  test("should return product with given product_id", async () => {
    const product_id = 10;
    const response = await request(app).get(
      `/backend/auction/displayproduct/${product_id}`
    );
    console.log("response.body", response.body);
    expect(response.statusCode).toBe(200);
    expect(response.body).toHaveProperty("id");
    expect(response.body.id).toBe(product_id);
  });

  test("should return 500 status code and error message if database query fails", async () => {
    const product_id = 1002;
    const mockDbQuery = jest
      .spyOn(db, "query")
      .mockImplementation((query, callback) => {
        callback(new Error("Database query failed"));
      });
    const response = await request(app).get(
      `/backend/auction/displayproduct/${product_id}`
    );
    expect(response.statusCode).toBe(500);
    expect(response.body).toHaveProperty("error");
    expect(response.body.error).toBe("Error retrieving data from the database");
    mockDbQuery.mockRestore();
  });
});

describe("getCategory", () => {
  test("should return category with given category_id", async () => {
    const category_id = 1;
    const response = await request(app).get(
      `/backend/auction/getCategory/${category_id}`
    );
    expect(response.statusCode).toBe(200);
    expect(response.body).toHaveProperty("id");
    expect(response.body.id).toBe(category_id);
  });

  test("should return 500 status code and error message if database query fails", async () => {
    const category_id = 1;
    const mockDbQuery = jest
      .spyOn(db, "query")
      .mockImplementation((query, callback) => {
        callback(new Error("Database query failed"));
      });
    const response = await request(app).get(
      `/backend/auction/getCategory/${category_id}`
    );
    expect(response.statusCode).toBe(500);
    expect(response.body).toHaveProperty("error");
    expect(response.body.error).toBe("Error retrieving data from the database");
    mockDbQuery.mockRestore();
  });
});