abstract class Endpoints {
  static const signUp = "/auth/signup";
  static const signIn = "/auth/signin";
  static const verifyEmail = "/auth/verify-email";
  static const forgotPassword = "/auth/forgot-password";
  static const logout = "/auth/logout";
  static const getAllProperties = "/properties";
  static const addToFavourites = "/users/:userId/favourites/:propertyId";
  static const getAllFavourites = "/users/:userId/favourites";
  static const deleteFavourites = "/users/:userId/favourites";
}
