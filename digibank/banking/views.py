from rest_framework import generics
from .serializers import BankAccountSerializer, TransactionSerializer ,TrensferSerializer
from rest_framework import permissions
from rest_framework.response import Response
from django.http import Http404
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from accounts.models import CustomUser
from .models import BankAccount
from django.db.models import F
import csv
from . import models
from django.http.response import HttpResponse




class CreateBankAccountAPI(generics.CreateAPIView):
 
   
    serializer_class = BankAccountSerializer
    #permission_classes = [permissions.IsAdminUser]  

    
    def post(self, request, format=None):
        serializer = BankAccountSerializer(data=request.data)
                
        if serializer.is_valid():
            account_type = serializer.validated_data['account_type']
            if account_type == 'savings':
                serializer.validated_data['account_balance'] = 00          
            elif account_type == 'credit':
                serializer.validated_data['account_balance'] = 100000     
            serializer.save()
            return Response(status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)





class BankAccountUpdate(APIView):
  
    def get(self, request, pk, format=None):
        account = self.get_object(pk)
        serializer = BankAccountSerializer(account)
        return Response(serializer.data)

    def get_object(self, pk, ):
        
        try:
            user_id = self.request.data.get('user')
            return BankAccount.objects.get(pk=pk, user_id = user_id)    
        except BankAccount.DoesNotExist:
            raise Http404

    def put(self, request, pk, format=None):
        account = self.get_object(pk)
        serializer = BankAccountSerializer(account, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)




class CreateTransactionAPI(generics.CreateAPIView):
   
   
    serializer_class = TransactionSerializer
   # permission_classes = [permissions.IsAdminUser]        
    
    def post(self, request, format=None):
        serializer = TransactionSerializer(data=request.data)
                
        if serializer.is_valid():
            user_id = serializer.validated_data['user']
            account_type = serializer.validated_data['account_type']
            transaction_type = serializer.validated_data['transaction_type']
            transaction_amount = serializer.validated_data['transaction_amount']
            bank_account = BankAccount.objects.get(id=account_type.pk, user_id=user_id)
                        
            if bank_account:   
                if transaction_type == 'deposit':
                    bank_account.account_balance = F('account_balance') + transaction_amount
                    bank_account.save()
                    serializer.save()
                    return Response(status=status.HTTP_201_CREATED)
                    
                elif transaction_type == 'withdrawal':
                    if bank_account.account_type == 'savings':
                        if bank_account.account_balance > 500 and bank_account.account_balance > transaction_amount:
                            new_savings_balance = bank_account.account_balance - transaction_amount 
                            if new_savings_balance >= 500:                                                
                                bank_account.account_balance = F('account_balance') - transaction_amount
                                bank_account.save()
                                serializer.save()
                                return Response(status=status.HTTP_201_CREATED)
                            else:
                                return Response(status=status.HTTP_400_BAD_REQUEST)                            
                        else:
                            return Response(status=status.HTTP_400_BAD_REQUEST)
                    
                    elif bank_account.account_type == 'credit':
                        if bank_account.account_balance > 100000:
                            new_credit_balance = bank_account.account_balance - transaction_amount
                            if new_credit_balance >= 100000:                                              
                                bank_account.account_balance = F('account_balance') - transaction_amount
                                bank_account.save()
                                serializer.save()
                                return Response(status=status.HTTP_201_CREATED)
                            else:
                                return Response(status=status.HTTP_400_BAD_REQUEST) 
                        else:
                            return Response(status=status.HTTP_400_BAD_REQUEST)
               

        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
class CreateTransferAPI(generics.CreateAPIView):
   
   
    serializer_class = TrensferSerializer
    #permission_classes = [permissions.IsAdminUser]  
    # 
    def money_transfer(self, request, *args, **kwargs):
      if request.method == "POST":
        form = TrensferSerializer.MoneyTransfer(request.POST)
        if form.is_valid():
            form.save()
        
            curr_user = models.MoneyTransfer.objects.get(EmailCur=request.user)
            dest_user_acc_num = curr_user.EmailDes

            temp = curr_user 
            
            dest_user = models.BankAccount.objects.get(EmailDes=dest_user_acc_num) 
            amount = curr_user.amount
            curr_user = models.BankAccount.objects.get(EmailCur=request.user) 

            
            nv = curr_user.account_balance - amount
            dest_user.account_balance = dest_user.account_balance + nv

        
            curr_user.save()
            dest_user.save()

            temp.delete()

        return Response(status=status.HTTP_201_CREATED)
      else:
       return Response(status=status.HTTP_400_BAD_REQUEST) 
    
      
    
   
                    
        
            
     
class ViewBankAccountAPI(generics.ListAPIView):
   

    serializer_class = BankAccountSerializer
    permission_classes = [permissions.IsAdminUser]
    
    def get_queryset(self):
        user_id = self.request.query_params.get('id')
        
        if user_id:                                
            user = CustomUser.objects.get(id=user_id)
            queryset = user.bankaccount.all()
            
        return queryset


class ViewBankAccountUser(generics.ListAPIView):
   
    serializer_class = BankAccountSerializer
    permission_classes = [permissions.IsAuthenticated]
    
    def get_queryset(self):
        logged_in_user = self.request.user     # FOR LOGGED IN USERS      
        queryset = logged_in_user.bankaccount.all()
        return queryset




def downloadBankAccounts(request):
   
       
    data = BankAccount.objects.all()
    if data:
        
        file = 'bank_accounts.csv'
        response = HttpResponse(
            content_type='text/csv',
            headers={'Content-Disposition': 'attachment; filename='+ file},
        )
        writer = csv.writer(response)
        writer.writerow(['ID', 'Account Type', 'Account Balance', 'Transaction Date', 'User_ID'])

        for f in data:
            writer.writerow([f.id, f.account_type, f.account_balance, f.date, f.user_id])
            print([f.id, f.account_type, f.account_balance, f.date, f.user_id])
        return response
