abstract class Endpoints {
  static const signUp = "/auth/signup";
  static const signIn = "/auth/signin";
  static const verifyEmail = "/auth/verify-email";
  static const forgotPassword = "/auth/forgot-password";
  static const logout = "/auth/logout";
  static const refreshUserToken = "/auth/refresh-token";
  static const getAllProperties = "/properties";
  static const getPropertyById = "/properties/:id";
  static const addToFavourites = "/users/:userId/favourites/:propertyId";
  static const getAllFavourites = "/users/:userId/favourites";
  static const deleteFavourites = "/users/:userId/favourites";
  static const showBalance = "/users/balance/:userId";
  static const userInfo = "/users/:userId";
  static const changeUserPin = "/users/pin/:userId";
  static const becomeInvestorUser = "/users/investor/:userId";
}
