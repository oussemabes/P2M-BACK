const Joi = require("@hapi/joi");
const db = require("./config");
//register validation
const registerValidation = (data) => {
  const schema = Joi.object({
    name: Joi.string().min(6).required(),
    email: Joi.string().min(6).required().email(),
    password: Joi.string().min(6).required(),
    balance: Joi.number(),
  });
  return schema.validate(data);
};
const loginValidation = (data) => {
  const schema = Joi.object({
    email: Joi.string().min(6).required().email(),
    password: Joi.string().min(6).required(),
  });
  return schema.validate(data);
};

// create auction validation
const auctionValidation = (data) => {
  const schema = Joi.object({
    productName: Joi.string().required(),
    productDescription: Joi.string().min(30).required(),
  });
  return schema.validate(data);
};

// const bidValidation = async (data) => {
//   const product_id = data.productId;
//   const bidAmount = data.bidAmount;
//   return new Promise(function (resolve, reject) {
//     const getLastBidAmount = `SELECT * FROM Bids WHERE product_id=${product_id} ORDER BY date DESC`;
//     db.query(getLastBidAmount, function (err, result) {
//       console.log(result)
//       if (result === undefined) {
//         reject(new Error("Error rows is undefined"));
//       } 
//         if (result.length==0) {
//           resolve(true);
//         } else {
//           console.log(result)
//           if (bidAmount > result[0].bidAmount) {
//             resolve(true);
//           } else {
//             resolve(false);
//           }
//         }
      
//     });
//   });
// };

module.exports = {
  registerValidation,
  loginValidation,
  auctionValidation,
  // bidValidation,
};
