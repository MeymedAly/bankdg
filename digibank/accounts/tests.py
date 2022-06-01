from django.test import TestCase
from .models import CustomUser
from django.utils.crypto import get_random_string as g
import string as s
from banking.models import BankAccount


class BankAppTestCase(TestCase):

    def setUp(self):
        self.user_account_for_test = CustomUser.objects.create_user(
            email=g(4, allowed_chars=s.ascii_lowercase)+'@gmail.com',
            first_name=g(4, allowed_chars=s.ascii_lowercase),
            last_name=g(4, allowed_chars=s.ascii_lowercase),
            password='1234'
              )

        self.bank_account_for_test = BankAccount.objects.create(
            account_type= 'credit',
            user=self.user_account_for_test
            )
        
        

    
    
    def test_create_new_users_via_api(self):
       
        
        url = 'http://127.0.0.1:8000/register/'
        data = {
            'email': g(4, allowed_chars=s.ascii_lowercase)+'@gmail.com',
            'first_name': g(4, allowed_chars=s.ascii_lowercase),
            'last_name' : g(4, allowed_chars=s.ascii_lowercase),
            'password' : '1234'
        }
        
        response = self.client.post(url, data=data)
        self.assertEqual(response.status_code, 201)
    

   

    def test_create_credit_bank_account_via_api(self):
        
        
        url = 'http://127.0.0.1:8000/createbankaccountapi/'
        data = {'account_type': 'credit', 'user': self.user_account_for_test.id}
        
        response = self.client.post(url, data=data)
        self.assertEqual(response.status_code, 201)
    
       

    def test_create_savings_bank_account_via_api(self):
       
        
        url = 'http://127.0.0.1:8000/createbankaccountapi/'
        data = {'account_type': 'savings', 'user': self.user_account_for_test.id}
        
        response = self.client.post(url, data=data)
        self.assertEqual(response.status_code, 201)
    

    

    def test_make_deposit_via_api(self):
       
        
        url = 'http://127.0.0.1:8000/createtransactionapi/'
        data = {
            'transaction_type': 'deposit', 'transaction_amount': 200,
            'account_type': self.bank_account_for_test.id, 'user': self.user_account_for_test.id}
        
        response = self.client.post(url, data=data)
        self.assertEqual(response.status_code, 201)
    

    def test_make_withdrawal_via_api(self):
     
        
        url = 'http://127.0.0.1:8000/createtransactionapi/'
        data = {
            'transaction_type': 'withdrawal', 'transaction_amount': 1000,
            'account_type': self.bank_account_for_test.id, 'user': self.user_account_for_test.id}
        
        response = self.client.post(url, data=data)
        self.assertEqual(response.status_code, 201)

    def test_make_trensfer_via_api(self):
     
        
        url = 'http://127.0.0.1:8000/createtransactionapi/'
        data = {
            'transaction_type': 'trensfer', 'transaction_amount': 1000,
            'account_type': self.bank_account_for_test.id, 'user': self.user_account_for_test.id}
        
        response = self.client.post(url, data=data)
        self.assertEqual(response.status_code, 201)