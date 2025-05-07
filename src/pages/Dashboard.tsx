
import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Separator } from "@/components/ui/separator";
import { Button } from "@/components/ui/button";
import { LucideArrowLeft, LucideLogOut } from "lucide-react";
import authService from "@/services/AuthService";
import { User } from "@/types/auth";
import { toast } from "@/hooks/use-toast";

const Dashboard = () => {
  const navigate = useNavigate();
  const [activeTab, setActiveTab] = useState("overview");
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchUserData = async () => {
      try {
        setLoading(true);
        const userData = await authService.getCurrentUser();
        setUser(userData);
      } catch (error) {
        console.error("Error fetching user data:", error);
        toast({
          title: "Error",
          description: "Failed to load user data",
          variant: "destructive",
        });
      } finally {
        setLoading(false);
      }
    };

    fetchUserData();
  }, []);

  const handleLogout = () => {
    authService.logout();
    navigate("/");
  };

  return (
    <div className="min-h-screen bg-gray-50">
      <header className="bg-white shadow-sm">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-4 flex items-center justify-between">
          <div className="flex items-center">
            <Button
              variant="ghost"
              size="icon"
              onClick={() => navigate("/")}
              className="mr-2"
            >
              <LucideArrowLeft className="h-5 w-5" />
            </Button>
            <h1 className="text-xl font-bold text-gray-900">
              Career Pathways Portal
            </h1>
          </div>
          <div className="flex items-center space-x-4">
            {!loading && user && (
              <span className="text-sm text-gray-600">
                Welcome, {user.name || user.username}
              </span>
            )}
            <Button
              variant="outline"
              size="sm"
              onClick={handleLogout}
              className="flex items-center space-x-1"
            >
              <LucideLogOut className="h-4 w-4 mr-1" />
              <span>Logout</span>
            </Button>
          </div>
        </div>
      </header>

      <main className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-6">
        <div className="bg-white shadow-sm rounded-lg p-6">
          {loading ? (
            <div className="flex justify-center items-center h-64">
              <div className="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-gray-900"></div>
            </div>
          ) : (
            <>
              {user && (
                <div className="mb-6">
                  <h2 className="text-2xl font-bold text-gray-900">
                    User Profile
                  </h2>
                  <Separator className="my-4" />
                  <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div>
                      <p className="text-sm text-gray-500">Name</p>
                      <p className="font-medium">{user.name}</p>
                    </div>
                    <div>
                      <p className="text-sm text-gray-500">Username</p>
                      <p className="font-medium">{user.username}</p>
                    </div>
                    <div>
                      <p className="text-sm text-gray-500">Email</p>
                      <p className="font-medium">{user.email}</p>
                    </div>
                    <div>
                      <p className="text-sm text-gray-500">Phone</p>
                      <p className="font-medium">{user.phone || "Not provided"}</p>
                    </div>
                    <div>
                      <p className="text-sm text-gray-500">Address</p>
                      <p className="font-medium">{user.address || "Not provided"}</p>
                    </div>
                    <div>
                      <p className="text-sm text-gray-500">Age</p>
                      <p className="font-medium">{user.age || "Not provided"}</p>
                    </div>
                  </div>
                </div>
              )}

              <Tabs
                defaultValue="overview"
                value={activeTab}
                onValueChange={setActiveTab}
                className="mt-6"
              >
                <TabsList className="grid grid-cols-3 mb-8">
                  <TabsTrigger value="overview">Overview</TabsTrigger>
                  <TabsTrigger value="courses">Courses</TabsTrigger>
                  <TabsTrigger value="jobs">Job Opportunities</TabsTrigger>
                </TabsList>
                <TabsContent value="overview" className="py-4">
                  <h3 className="text-lg font-medium mb-4">Welcome to Career Pathways</h3>
                  <p className="text-gray-600 mb-4">
                    This portal helps you explore educational and career options that align with your interests and goals.
                    Use the tabs above to browse through available courses and job opportunities.
                  </p>
                </TabsContent>
                <TabsContent value="courses" className="py-4">
                  <h3 className="text-lg font-medium mb-4">Recommended Courses</h3>
                  <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                    <div className="border rounded-lg p-4">
                      <h4 className="font-medium">B.Tech Computer Science</h4>
                      <p className="text-sm text-gray-600 mt-1">
                        Bachelor of Technology in Computer Science and Engineering
                      </p>
                    </div>
                    <div className="border rounded-lg p-4">
                      <h4 className="font-medium">BBA</h4>
                      <p className="text-sm text-gray-600 mt-1">
                        Bachelor of Business Administration
                      </p>
                    </div>
                    <div className="border rounded-lg p-4">
                      <h4 className="font-medium">MBBS</h4>
                      <p className="text-sm text-gray-600 mt-1">
                        Bachelor of Medicine and Bachelor of Surgery
                      </p>
                    </div>
                  </div>
                </TabsContent>
                <TabsContent value="jobs" className="py-4">
                  <h3 className="text-lg font-medium mb-4">Job Opportunities</h3>
                  <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div className="border rounded-lg p-4">
                      <h4 className="font-medium">Software Engineer</h4>
                      <p className="text-sm text-gray-600 mt-1">
                        TechSolutions Inc. • Bangalore
                      </p>
                      <p className="text-sm mt-2">₹12-18 LPA • Full-time</p>
                    </div>
                    <div className="border rounded-lg p-4">
                      <h4 className="font-medium">Data Scientist</h4>
                      <p className="text-sm text-gray-600 mt-1">
                        Analytics Plus • Hyderabad
                      </p>
                      <p className="text-sm mt-2">₹15-22 LPA • Full-time</p>
                    </div>
                    <div className="border rounded-lg p-4">
                      <h4 className="font-medium">Marketing Manager</h4>
                      <p className="text-sm text-gray-600 mt-1">
                        BrandBoost • Mumbai
                      </p>
                      <p className="text-sm mt-2">₹10-15 LPA • Full-time</p>
                    </div>
                    <div className="border rounded-lg p-4">
                      <h4 className="font-medium">Financial Analyst</h4>
                      <p className="text-sm text-gray-600 mt-1">
                        Global Investments Ltd. • Delhi
                      </p>
                      <p className="text-sm mt-2">₹8-12 LPA • Full-time</p>
                    </div>
                  </div>
                </TabsContent>
              </Tabs>
            </>
          )}
        </div>
      </main>

      <footer className="bg-white mt-12">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-6">
          <p className="text-center text-sm text-gray-500">
            &copy; 2025 Career Pathways Portal. All rights reserved.
          </p>
        </div>
      </footer>
    </div>
  );
};

export default Dashboard;
