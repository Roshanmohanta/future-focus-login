
import { useState } from "react";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { registrationSchema, RegistrationFormData } from "@/schemas/auth-schema";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Eye, EyeOff, Calendar, UserPlus } from "lucide-react";
import authService from "@/services/AuthService";

interface RegisterFormProps {
  onSwitchToLogin: () => void;
}

const RegisterForm = ({ onSwitchToLogin }: RegisterFormProps) => {
  const [isLoading, setIsLoading] = useState(false);
  const [showPassword, setShowPassword] = useState(false);
  const [showConfirmPassword, setShowConfirmPassword] = useState(false);
  
  const form = useForm<RegistrationFormData>({
    resolver: zodResolver(registrationSchema),
    defaultValues: {
      name: "",
      email: "",
      username: "",
      password: "",
      confirmPassword: "",
      phone: "",
      address: "",
      age: "",
      dateOfBirth: ""
    }
  });
  
  const { register, handleSubmit, formState: { errors } } = form;

  const onSubmit = async (data: RegistrationFormData) => {
    setIsLoading(true);
    try {
      const success = await authService.register({
        name: data.name,
        email: data.email,
        username: data.username,
        password: data.password,
        phone: data.phone,
        address: data.address,
        age: Number(data.age),
        dateOfBirth: data.dateOfBirth
      });
      
      if (success) {
        onSwitchToLogin();
      }
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div className="auth-card animate-fade-in">
      <div className="text-center mb-6">
        <h1 className="text-2xl font-bold text-career-darkBlue">Create an Account</h1>
        <p className="text-gray-500 mt-2">Register to start your career journey</p>
      </div>

      <form onSubmit={handleSubmit(onSubmit)} className="space-y-5">
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div className="space-y-1">
            <Label htmlFor="name" className="auth-label">Full Name</Label>
            <Input 
              id="name"
              className="auth-input"
              placeholder="Enter your full name"
              disabled={isLoading}
              {...register("name")}
            />
            {errors.name && (
              <p className="form-error">{errors.name.message}</p>
            )}
          </div>

          <div className="space-y-1">
            <Label htmlFor="email" className="auth-label">Email</Label>
            <Input 
              id="email"
              type="email"
              className="auth-input"
              placeholder="Enter your email"
              disabled={isLoading}
              {...register("email")}
            />
            {errors.email && (
              <p className="form-error">{errors.email.message}</p>
            )}
          </div>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div className="space-y-1">
            <Label htmlFor="username" className="auth-label">Username</Label>
            <Input 
              id="username"
              className="auth-input"
              placeholder="Choose a username"
              disabled={isLoading}
              {...register("username")}
            />
            {errors.username && (
              <p className="form-error">{errors.username.message}</p>
            )}
          </div>

          <div className="space-y-1">
            <Label htmlFor="phone" className="auth-label">Phone Number</Label>
            <Input 
              id="phone"
              className="auth-input"
              placeholder="Enter your phone number"
              disabled={isLoading}
              {...register("phone")}
            />
            {errors.phone && (
              <p className="form-error">{errors.phone.message}</p>
            )}
          </div>
        </div>

        <div className="space-y-1">
          <Label htmlFor="address" className="auth-label">Address</Label>
          <Input 
            id="address"
            className="auth-input"
            placeholder="Enter your address"
            disabled={isLoading}
            {...register("address")}
          />
          {errors.address && (
            <p className="form-error">{errors.address.message}</p>
          )}
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div className="space-y-1">
            <Label htmlFor="age" className="auth-label">Age</Label>
            <Input 
              id="age"
              className="auth-input"
              placeholder="Enter your age"
              disabled={isLoading}
              {...register("age")}
            />
            {errors.age && (
              <p className="form-error">{errors.age.message}</p>
            )}
          </div>

          <div className="space-y-1">
            <Label htmlFor="dateOfBirth" className="auth-label">Date of Birth</Label>
            <div className="relative">
              <Input 
                id="dateOfBirth"
                type="date"
                className="auth-input"
                disabled={isLoading}
                {...register("dateOfBirth")}
              />
              <div className="absolute right-3 top-1/2 -translate-y-1/2 text-gray-500">
                <Calendar size={18} />
              </div>
            </div>
            {errors.dateOfBirth && (
              <p className="form-error">{errors.dateOfBirth.message}</p>
            )}
          </div>
        </div>

        <div className="space-y-1">
          <Label htmlFor="password" className="auth-label">Password</Label>
          <div className="relative">
            <Input 
              id="password"
              type={showPassword ? "text" : "password"}
              className="auth-input pr-10"
              placeholder="Create a strong password"
              disabled={isLoading}
              {...register("password")}
            />
            <button
              type="button"
              className="absolute right-3 top-1/2 -translate-y-1/2 text-gray-500 hover:text-gray-700"
              onClick={() => setShowPassword(!showPassword)}
            >
              {showPassword ? <EyeOff size={18} /> : <Eye size={18} />}
            </button>
          </div>
          {errors.password && (
            <p className="form-error">{errors.password.message}</p>
          )}
        </div>

        <div className="space-y-1">
          <Label htmlFor="confirmPassword" className="auth-label">Confirm Password</Label>
          <div className="relative">
            <Input 
              id="confirmPassword"
              type={showConfirmPassword ? "text" : "password"}
              className="auth-input pr-10"
              placeholder="Confirm your password"
              disabled={isLoading}
              {...register("confirmPassword")}
            />
            <button
              type="button"
              className="absolute right-3 top-1/2 -translate-y-1/2 text-gray-500 hover:text-gray-700"
              onClick={() => setShowConfirmPassword(!showConfirmPassword)}
            >
              {showConfirmPassword ? <EyeOff size={18} /> : <Eye size={18} />}
            </button>
          </div>
          {errors.confirmPassword && (
            <p className="form-error">{errors.confirmPassword.message}</p>
          )}
        </div>

        <Button type="submit" className="auth-btn" disabled={isLoading}>
          {isLoading ? (
            <div className="flex items-center">
              <div className="w-5 h-5 border-2 border-white border-t-transparent rounded-full animate-spin mr-2" />
              Creating your account...
            </div>
          ) : (
            <div className="flex items-center">
              <UserPlus size={18} className="mr-2" />
              Register
            </div>
          )}
        </Button>
      </form>

      <div className="mt-6 text-center">
        <p className="text-gray-600">
          Already have an account?{" "}
          <button 
            type="button"
            onClick={onSwitchToLogin}
            className="text-career-purple hover:text-career-lightPurple font-medium"
          >
            Sign in
          </button>
        </p>
      </div>
    </div>
  );
};

export default RegisterForm;
