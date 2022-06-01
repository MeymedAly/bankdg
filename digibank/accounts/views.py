from .models import CustomUser
from .serializers import CustomUserSerializer
from rest_framework import generics
from rest_framework import permissions




class CreateCustomUser(generics.CreateAPIView):
    
    queryset = CustomUser.objects.all()
    serializer_class = CustomUserSerializer



class ViewUserAccount(generics.ListAPIView):
   
    serializer_class = CustomUserSerializer
    permission_classes = [permissions.IsAuthenticated]
    
    
    def get_queryset(self):
        logged_in_user = self.request.user.id  
        queryset = CustomUser.objects.filter(id = logged_in_user)
        return queryset



class AdminViewUser(generics.ListAPIView):
  
    serializer_class = CustomUserSerializer
    permission_classes = [permissions.IsAdminUser]
        
    def get_queryset(self):
        id = self.kwargs['id']
        queryset = CustomUser.objects.filter(id = id)
        return queryset