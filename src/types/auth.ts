
export interface UserFormData {
  name: string;
  email: string;
  username: string;
  password: string;
  confirmPassword?: string;
  phone: string;
  address: string;
  age: string | number;
  dateOfBirth: string;
}

export interface LoginFormData {
  username: string;
  password: string;
}
