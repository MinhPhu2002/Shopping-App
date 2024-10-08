import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testapp/core/app_authentication.dart';
import 'package:testapp/module/auth/bloc/login_cubit.dart';
import 'package:testapp/module/auth/bloc/password_cubit.dart';
import 'package:testapp/module/auth/bloc/register_cubit.dart';
import 'package:testapp/module/auth/bloc/vertify_cubit.dart';
import 'package:testapp/module/auth/repo/vertify_forgot_password_repo.dart';
import 'package:testapp/module/auth/repo/vertify_repo.dart';
import 'package:testapp/module/auth/screen/change_password_screen.dart';
import 'package:testapp/module/auth/screen/forgot_password_screen.dart';
import 'package:testapp/module/auth/screen/login_screen.dart';
import 'package:testapp/module/auth/screen/new_password_screen.dart';
import 'package:testapp/module/auth/screen/recomment_screen.dart';
import 'package:testapp/module/auth/screen/signup_screen.dart';
import 'package:testapp/module/auth/screen/start_screen.dart';
import 'package:testapp/module/auth/screen/vertification_code_screen.dart';
import 'package:testapp/module/cart/bloc/cart_cubit.dart';
import 'package:testapp/module/cart/screen/address_creen.dart';
import 'package:testapp/module/cart/screen/cart_screen.dart';
import 'package:testapp/module/cart/screen/new_card_screen.dart';
import 'package:testapp/module/cart/screen/order_confirmed_screen.dart';
import 'package:testapp/module/cart/screen/payment_screen.dart';
import 'package:testapp/module/detail/bloc/product_details/product_details_cubit.dart';
import 'package:testapp/module/detail/description_product_screen.dart';
import 'package:testapp/module/home/bloc/brands/brands_cubit.dart';
import 'package:testapp/module/home/bloc/products/products_cubit.dart';
import 'package:testapp/module/home/bloc/user/user_cubit.dart';
import 'package:testapp/module/home/home_screen.dart';
import 'package:testapp/module/product/bloc/brand_details/brand_details_cubit.dart';
import 'package:testapp/module/product/brand_screen.dart';
import 'package:testapp/module/product/wishlish_screen.dart';
import 'package:testapp/module/review/add_review_screen.dart';
import 'package:testapp/module/review/bloc/comment_cubit.dart';
import 'package:testapp/module/review/review_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      name: '/',
      path: '/',
      builder: (context, state) => const StartScreen(),
    ),
    GoRoute(
      name: 'login',
      path: '/login',
      builder: (context, state) {
        return BlocProvider(
          create: (context) => LoginCubit(),
          child: const LoginScreen(),
        );
      },
    ),
    GoRoute(
      name: 'signup',
      path: '/signup',
      builder: (context, state) => BlocProvider(
        create: (context) => RegisterCubit(),
        child: const SignupScreen(),
      ),
    ),
    GoRoute(
      name: 'vertification',
      path: '/vertification',
      builder: (context, state) {
        final param = state.extra as Map<String, String>;
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => LoginCubit(),
            ),
            BlocProvider(
              create: (context) => VertifyCubit(repo: VertifyRepository()),
            ),
            BlocProvider(
              create: (context) => PasswordCubit(),
            )
          ],
          child: VertificationCodeScreen(
            username: param['username'] as String,
            onResentOtp: AppAuthenticationBinding
                .instance!.notifyUserRequestAccessVerification,
            onVerifySuccess: () {
              context.goNamed('home');
            },
          ),
        );
      },
    ),
    GoRoute(
      name: 'vertifyForgotPassword',
      path: '/vertifyForgotPassword',
      builder: (context, state) {
        final param = state.extra as Map<String, String>;
        final username = param['username'] as String;
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => LoginCubit(),
            ),
            BlocProvider(
              create: (context) =>
                  VertifyCubit(repo: VertifyForgotPasswordRepo()),
            ),
            BlocProvider(
              create: (context) => PasswordCubit(),
            )
          ],
          child: VertificationCodeScreen(
            username: username,
            onResentOtp: AppAuthenticationBinding
                .instance!.notifyResetPasswordRequestAccessVertification,
            onVerifySuccess: () {
              context.pushNamed('newPassword', extra: {'username': username});
            },
          ),
        );
      },
    ),
    GoRoute(
      name: 'forgotPassword',
      path: '/forgotPassword',
      builder: (context, state) => BlocProvider(
        create: (context) => PasswordCubit(),
        child: ForgotPasswordScreen(),
      ),
    ),
    GoRoute(
      name: 'newPassword',
      path: '/newPassword',
      builder: (context, state) {
        final param = state.extra as Map<String, String>;

        return BlocProvider(
          create: (context) => PasswordCubit(),
          child: NewPasswordScreen(
            username: param['username'] as String,
          ),
        );
      },
    ),
    GoRoute(
      name: 'recomment',
      path: '/recomment',
      builder: (context, state) => RecommentScreen(),
    ),
    GoRoute(
      name: 'address',
      path: '/address',
      builder: (context, state) => AddressCreen(),
    ),
    GoRoute(
      name: 'cart',
      path: '/cart',
      builder: (context, state) {
        return BlocProvider(
          create: (context) => CartCubit(),
          child: CartScreen(),
        );
      },
    ),
    GoRoute(
      name: 'newCard',
      path: '/newCard',
      builder: (context, state) => const NewCardScreen(),
    ),
    GoRoute(
      name: 'orderConfirmed',
      path: '/orderConfirmed',
      builder: (context, state) => const OrderConfirmedScreen(),
    ),
    GoRoute(
      name: 'payment',
      path: '/payment',
      builder: (context, state) => PaymentScreen(),
    ),
    GoRoute(
      name: 'description',
      path: '/description',
      builder: (context, state) {
        return BlocProvider(
          create: (context) => ProductDetailsCubit(state.extra as int),
          child: DescriptionProductScreen(postId: state.extra as int),
        );
      },
    ),
    GoRoute(
      name: 'home',
      path: '/home',
      builder: (context, state) {
        return MultiBlocProvider(providers: [
          BlocProvider(
            create: (context) => UserCubit(),
          ),
          BlocProvider(
            create: (context) => ProductsCubit(),
          ),
          BlocProvider(
            create: (context) => BrandsCubit(),
          ),
        ], child: const HomeScreen());
      },
    ),
    GoRoute(
      name: 'wishlish',
      path: '/wishlish',
      builder: (context, state) => WishlishScreen(),
    ),
    GoRoute(
      name: 'brand',
      path: '/brand',
      builder: (context, state) {
        final param = state.extra as Map<String, String>;
        return BlocProvider(
          create: (context) => BrandDetailsCubit(param['slug'] as String),
          child: BrandScreen(nameBrand: param['nameBrand'] as String),
        );
      },
    ),
    GoRoute(
      name: 'review',
      path: '/review',
      builder: (context, state) {
        final param = state.extra as Map<String, String>;
        return BlocProvider(
          create: (context) => CommentCubit(param['id'] as int),
          child: ReviewScreen(postId: param['id'] as int),
        );
      },
    ),
    GoRoute(
      name: 'addreview',
      path: '/addreview',
      builder: (context, state) => AddReviewScreen(postId: state.extra as int),
    ),
    GoRoute(
      name: 'changepassword',
      path: '/changepassword',
      builder: (context, state) => BlocProvider(
        create: (context) => PasswordCubit(),
        child: ChangePasswordScreen(),
      ),
    ),
  ],
  redirect: (context, GoRouterState state) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('token');
    String currentLocation = state.uri.toString();
    if (currentLocation == '/' && token != null) {
      return '/home';
    }
    if (currentLocation == '/' && token == null) {
      return '/';
    }
    return null;
  },
);
