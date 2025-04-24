<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Login - BS Unisex Salon</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-[url('/images/salon-bg.jpg')] bg-cover bg-center min-h-screen">

  @include('components.navbar')

  <div class="flex items-center justify-center min-h-screen">
    <div class="bg-white bg-opacity-90 p-8 rounded-xl shadow-lg w-full max-w-md">
      <h2 class="text-2xl font-bold text-center text-indigo-600 mb-6">Welcome to BS Unisex Salon 💼</h2>

      @if(session('error'))
        <div class="text-red-500 text-sm mb-4">{{ session('error') }}</div>
      @endif

      <form action="{{ route('login') }}" method="POST">
        @csrf
        <div class="mb-4">
          <label class="block text-sm text-gray-700">Email</label>
          <input type="email" name="email" class="w-full mt-1 p-2 border border-gray-300 rounded-md" required>
        </div>
        <div class="mb-4">
          <label class="block text-sm text-gray-700">Password</label>
          <input type="password" name="password" class="w-full mt-1 p-2 border border-gray-300 rounded-md" required>
        </div>
        <button type="submit" class="w-full bg-indigo-600 text-white py-2 rounded hover:bg-indigo-700">Log In</button>

        <p class="text-sm text-center mt-4">
          Don't have an account?
          <a href="{{ route('register') }}" class="text-indigo-600 hover:underline">Register</a>
        </p>
      </form>
    </div>
  </div>
</body>
</html>
