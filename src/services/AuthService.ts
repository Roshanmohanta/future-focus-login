
import { toast } from "sonner";
import { UserFormData, LoginFormData } from "@/types/auth";

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
  private baseUrl = "http://localhost:5000/api/auth"; 
  private isLoggedInValue = false;
  private currentUser: User | null = null;
  private token: string | null = null;

  async register(userData: UserFormData): Promise<boolean> {
    try {
      const response = await fetch(`${this.baseUrl}/register`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(userData)
      });
      
      const data = await response.json();
      
      if (!response.ok) {
        throw new Error(data.message || "Registration failed");
      }
      
      toast.success("Registration successful! Please log in.");
      return true;
    } catch (error) {
      console.error("Registration error:", error);
      toast.error(error instanceof Error ? error.message : "Registration failed. Please try again.");
      return false;
    }
  }

  async login(credentials: LoginFormData): Promise<User | null> {
    try {
      const response = await fetch(`${this.baseUrl}/login`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(credentials)
      });
      
      const data = await response.json();
      
      if (!response.ok) {
        throw new Error(data.message || "Login failed");
      }
      
      this.isLoggedInValue = true;
      this.currentUser = data.user;
      this.token = data.token;
      
      localStorage.setItem("user", JSON.stringify(data.user));
      localStorage.setItem("token", data.token);
      
      toast.success(`Welcome back, ${data.user.name || data.user.username}!`);
      
      return data.user;
    } catch (error) {
      console.error("Login error:", error);
      toast.error(error instanceof Error ? error.message : "Login failed. Please check your credentials.");
      return null;
    }
  }

  async getCurrentUser(): Promise<User | null> {
    if (!this.token) {
      return null;
    }
    
    try {
      const response = await fetch(`${this.baseUrl}/me`, {
        headers: { 
          "Authorization": `Bearer ${this.token}`,
          "Content-Type": "application/json"
        }
      });
      
      if (!response.ok) {
        throw new Error("Failed to fetch user profile");
      }
      
      const data = await response.json();
      this.currentUser = data.user;
      return data.user;
    } catch (error) {
      console.error("Get current user error:", error);
      return null;
    }
  }

  logout(): void {
    this.isLoggedInValue = false;
    this.currentUser = null;
    this.token = null;
    localStorage.removeItem("user");
    localStorage.removeItem("token");
    toast.info("You have been logged out");
  }

  isLoggedIn(): boolean {
    return this.isLoggedInValue;
  }

  getUser(): User | null {
    return this.currentUser;
  }

  // Method to check if user is logged in from localStorage on page refresh
  initializeFromStorage(): void {
    const storedUser = localStorage.getItem("user");
    const storedToken = localStorage.getItem("token");
    
    if (storedUser && storedToken) {
      try {
        this.currentUser = JSON.parse(storedUser);
        this.token = storedToken;
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
