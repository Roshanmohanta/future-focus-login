
import { useState } from "react";
import LoginForm from "@/components/auth/LoginForm";
import RegisterForm from "@/components/auth/RegisterForm";

const Auth = () => {
  const [isLogin, setIsLogin] = useState(true);
  
  const toggleAuthMode = () => {
    setIsLogin(!isLogin);
  };

  return (
    <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-career-gray to-white p-4">
      <div className="w-full max-w-4xl flex flex-col lg:flex-row rounded-2xl shadow-xl overflow-hidden">
        {/* Left side - Image and info */}
        <div className="lg:w-1/2 bg-gradient-to-br from-career-purple to-career-lightPurple p-8 text-white flex flex-col justify-between">
          <div>
            <h1 className="text-3xl font-bold mb-4">Career Recommendation Portal</h1>
            <p className="mb-6 opacity-90">
              Find your perfect career path with personalized recommendations based on your skills and interests.
            </p>
            <div className="space-y-4">
              <div className="flex items-start">
                <div className="bg-white/20 rounded-full p-1.5 mr-3 mt-0.5">
                  <svg className="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                    <path fillRule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clipRule="evenodd" />
                  </svg>
                </div>
                <div>
                  <h3 className="font-medium">Personalized Recommendations</h3>
                  <p className="text-sm opacity-80">Get course and career suggestions tailored to your profile.</p>
                </div>
              </div>
              <div className="flex items-start">
                <div className="bg-white/20 rounded-full p-1.5 mr-3 mt-0.5">
                  <svg className="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                    <path fillRule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clipRule="evenodd" />
                  </svg>
                </div>
                <div>
                  <h3 className="font-medium">College & Course Details</h3>
                  <p className="text-sm opacity-80">Comprehensive information about colleges and courses.</p>
                </div>
              </div>
              <div className="flex items-start">
                <div className="bg-white/20 rounded-full p-1.5 mr-3 mt-0.5">
                  <svg className="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                    <path fillRule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clipRule="evenodd" />
                  </svg>
                </div>
                <div>
                  <h3 className="font-medium">Job Opportunities</h3>
                  <p className="text-sm opacity-80">Discover job openings that match your qualifications.</p>
                </div>
              </div>
            </div>
          </div>
          <div className="mt-12 text-sm opacity-80">
            © 2025 Career Recommendation Portal. All rights reserved.
          </div>
        </div>

        {/* Right side - Auth form */}
        <div className="lg:w-1/2 p-4 bg-white flex items-center justify-center">
          {isLogin ? (
            <LoginForm onSwitchToRegister={toggleAuthMode} />
          ) : (
            <RegisterForm onSwitchToLogin={toggleAuthMode} />
          )}
        </div>
      </div>
    </div>
  );
};

export default Auth;
