
import { Button } from "@/components/ui/button";
import authService from "@/services/AuthService";
import { useNavigate } from "react-router-dom";

const Dashboard = () => {
  const navigate = useNavigate();
  const user = authService.getCurrentUser();
  
  const handleLogout = () => {
    authService.logout();
    navigate("/");
  };
  
  return (
    <div className="min-h-screen bg-career-gray p-4">
      <div className="max-w-7xl mx-auto bg-white rounded-lg shadow-md p-8">
        <div className="flex justify-between items-center mb-8">
          <h1 className="text-2xl font-bold text-career-darkBlue">Career Recommendation Portal</h1>
          <Button 
            variant="outline"
            className="border-career-purple text-career-purple hover:bg-career-purple hover:text-white"
            onClick={handleLogout}
          >
            Logout
          </Button>
        </div>
        
        <div className="p-6 bg-career-gray/50 rounded-lg mb-6">
          <h2 className="text-xl font-semibold mb-4">Welcome back, {user?.name || user?.username}!</h2>
          <p className="text-gray-600">
            Your career dashboard is ready. Here you can explore course recommendations,
            check college details, and find job opportunities that match your profile.
          </p>
        </div>
        
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          <div className="bg-white border border-gray-200 p-6 rounded-lg shadow-sm">
            <h3 className="font-semibold text-lg mb-3 text-career-purple">Course Recommendations</h3>
            <p className="text-gray-600 mb-4">Explore courses that match your interests and skills.</p>
            <Button className="w-full bg-career-purple hover:bg-career-lightPurple">
              View Courses
            </Button>
          </div>
          
          <div className="bg-white border border-gray-200 p-6 rounded-lg shadow-sm">
            <h3 className="font-semibold text-lg mb-3 text-career-purple">College Information</h3>
            <p className="text-gray-600 mb-4">Find details about top colleges and their offerings.</p>
            <Button className="w-full bg-career-purple hover:bg-career-lightPurple">
              Explore Colleges
            </Button>
          </div>
          
          <div className="bg-white border border-gray-200 p-6 rounded-lg shadow-sm">
            <h3 className="font-semibold text-lg mb-3 text-career-purple">Job Opportunities</h3>
            <p className="text-gray-600 mb-4">Discover job openings that match your profile.</p>
            <Button className="w-full bg-career-purple hover:bg-career-lightPurple">
              Find Jobs
            </Button>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Dashboard;
