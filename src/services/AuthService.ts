
import { toast } from "sonner";

export interface UserRegistration {
  name: string;
  email: string;
  username: string;
  password: string;
  phone: string;
  address: string;
  age: number;
  dateOfBirth: string;
}

export interface UserLogin {
  username: string;
  password: string;
}

export interface User {
  id: number;
  username: string;
  email: string;
  name?: string;
  phone?: string;
  address?: string;
  age?: number;
  dateOfBirth?: string;
  role: 'admin' | 'user';
}

class AuthService {
  private baseUrl = "/api/auth"; // This would be your API endpoint
  private isLoggedInValue = false;
  private currentUser: User | null = null;

  // For development simulating backend
  async simulateApiCall<T>(data: any, success: boolean = true, delay: number = 800): Promise<T> {
    return new Promise((resolve, reject) => {
      setTimeout(() => {
        if (success) {
          resolve(data as T);
        } else {
          reject(new Error("API call failed"));
        }
      }, delay);
    });
  }

  async register(userData: UserRegistration): Promise<boolean> {
    try {
      // In actual implementation, this would be a fetch call to your backend API
      // const response = await fetch(`${this.baseUrl}/register`, {
      //   method: "POST",
      //   headers: { "Content-Type": "application/json" },
      //   body: JSON.stringify(userData)
      // });
      
      // For demo purposes, simulating API call
      const response = await this.simulateApiCall<{success: boolean, message: string}>(
        { success: true, message: "Registration successful" },
        true
      );
      
      toast.success("Registration successful! Please log in.");
      return true;
    } catch (error) {
      console.error("Registration error:", error);
      toast.error("Registration failed. Please try again.");
      return false;
    }
  }

  async login(credentials: UserLogin): Promise<User | null> {
    try {
      // In actual implementation, this would be a fetch call to your backend API
      // const response = await fetch(`${this.baseUrl}/login`, {
      //   method: "POST",
      //   headers: { "Content-Type": "application/json" },
      //   body: JSON.stringify(credentials)
      // });
      
      // For demo purposes, simulating API call
      const mockUser: User = {
        id: 1,
        username: credentials.username,
        email: `${credentials.username}@example.com`,
        name: "Demo User",
        role: "user"
      };
      
      const response = await this.simulateApiCall<{user: User}>(
        { user: mockUser },
        true
      );
      
      this.isLoggedInValue = true;
      this.currentUser = response.user;
      
      localStorage.setItem("user", JSON.stringify(response.user));
      toast.success(`Welcome back, ${response.user.name || response.user.username}!`);
      
      return response.user;
    } catch (error) {
      console.error("Login error:", error);
      toast.error("Login failed. Please check your credentials.");
      return null;
    }
  }

  logout(): void {
    this.isLoggedInValue = false;
    this.currentUser = null;
    localStorage.removeItem("user");
    toast.info("You have been logged out");
  }

  isLoggedIn(): boolean {
    return this.isLoggedInValue;
  }

  getCurrentUser(): User | null {
    return this.currentUser;
  }

  // Method to check if user is logged in from localStorage on page refresh
  initializeFromStorage(): void {
    const storedUser = localStorage.getItem("user");
    if (storedUser) {
      try {
        this.currentUser = JSON.parse(storedUser);
        this.isLoggedInValue = true;
      } catch (e) {
        console.error("Error parsing stored user", e);
        this.logout();
      }
    }
  }
}

// Create a singleton instance
const authService = new AuthService();

// Initialize from storage when the service is first loaded
authService.initializeFromStorage();

export default authService;
