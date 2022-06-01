
from django.contrib import admin
from django.urls import path, include
from accounts import views as av
from banking import views as bv
from django.views.generic import TemplateView
from rest_framework.schemas import get_schema_view

urlpatterns = [
    path('admin/', admin.site.urls),

 
    path('register/', av.CreateCustomUser.as_view()),

    path('viewuseraccount/', av.ViewUserAccount.as_view()),

    path('adminviewuser/<id>/', av.AdminViewUser.as_view()),
    
    path('createbankaccountapi/', bv.CreateBankAccountAPI.as_view()),

    path('bankaccountupdate/<int:pk>/', bv.BankAccountUpdate.as_view()),

    path('createtransactionapi/', bv.CreateTransactionAPI.as_view()),

    path('createtransferapi/', bv.CreateTransferAPI.as_view()),


    
    path('viewbankaccountapi/', bv.ViewBankAccountAPI.as_view()),

    path('viewbankaccountuser/', bv.ViewBankAccountUser.as_view()),
    
    
    path('downloadbankaccounts/', bv.downloadBankAccounts),


    
    
    path('api-auth/', include('rest_framework.urls')),

    
    path('docs/', TemplateView.as_view(
        template_name='swagger-ui.html',
        extra_context={'schema_url':'openapi-schema'}
    ), name='swagger-ui'),

    path('openapi/', get_schema_view(
        title="Python Django Bank App",
        description="An API-based Banking app"
    ), name='openapi-schema'),

]


