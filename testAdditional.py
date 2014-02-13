import unittest
import os
import testLib

class TestNilUser(testLib.RestTestCase):
    """Test adding user with empty Username"""
    def assertResponse(self, respData, errCode = testLib.RestTestCase.ERR_BAD_USERNAME):
        """
        Check that the response data dictionary matches the expected values
        """
        expected = { 'errCode' : errCode }
        self.assertDictEqual(expected, respData)

    def testAdd1(self):
        respData = self.makeRequest("/users/add", method="POST", data = { 'user': '', 'password': 'hehe'} )
        self.assertResponse(respData)


class TestMaxUser(testLib.RestTestCase):
    """Test adding user with too long Username"""
    def assertResponse(self, respData, errCode = testLib.RestTestCase.ERR_BAD_USERNAME):
        """
        Check that the response data dictionary matches the expected values
        """
        expected = { 'errCode' : errCode }
        self.assertDictEqual(expected, respData)

    def testAdd1(self):
        a = "a"*129
        respData = self.makeRequest("/users/add", method="POST", data = { 'user': a, 'password': 'hehe'} )
        self.assertResponse(respData)


class TestMaxPassword(testLib.RestTestCase):
    """Test adding user with too long Username"""
    def assertResponse(self, respData, errCode = testLib.RestTestCase.ERR_BAD_PASSWORD):
        """
        Check that the response data dictionary matches the expected values
        """
        expected = { 'errCode' : errCode }
        self.assertDictEqual(expected, respData)

    def testAdd1(self):
        b = "b"*129
        respData = self.makeRequest("/users/add", method="POST", data = { 'user': 'hehe', 'password': b} )
        self.assertResponse(respData)


class TestDupUser(testLib.RestTestCase):
    """Test Duplicate Users Added to Database"""
    def assertResponse(self, respData, errCode = testLib.RestTestCase.ERR_USER_EXISTS):
        """
        Check that the response data dictionary matches the expected values
        """
        expected = { 'errCode' : errCode }
        self.assertDictEqual(expected, respData)

    def testAdd1(self):
        self.makeRequest("/users/add", method="POST", data = { 'user' : 'me', 'password' : 'you'} )
        respData = self.makeRequest("/users/add", method="POST", data = { 'user' : 'me', 'password' : 'you'} )
        self.assertResponse(respData)


class TestLoginUser(testLib.RestTestCase):
    """Test login functionality"""
    def assertResponse(self, respData, count = 2, errCode = testLib.RestTestCase.SUCCESS):
        """
        Check that the response data dictionary matches the expected values
        """
        expected = { 'errCode' : errCode }
        if count is not None:
            expected['count']  = count
        self.assertDictEqual(expected, respData)

    def testAdd1(self):
        self.makeRequest("/users/add", method="POST", data = { 'user' : 'zack', 'password' : 'wack'} )
        respData = self.makeRequest("/users/login", method="POST", data = { 'user' : 'zack', 'password' : 'wack'} )
        self.assertResponse(respData, count = 2)


class TestLoginNoUser(testLib.RestTestCase):
    """Test Logging in user that has not been created"""
    def assertResponse(self, respData, errCode = testLib.RestTestCase.ERR_BAD_CREDENTIALS):
        """
        Check that the response data dictionary matches the expected values
        """
        expected = { 'errCode' : errCode }
        self.assertDictEqual(expected, respData)

    def testAdd1(self):
        respData = self.makeRequest("/users/login", method="POST", data = { 'user' : 'nothere', 'password' : 'lsls'} )
        self.assertResponse(respData)


class TestLoginBadPassword(testLib.RestTestCase):
    """Test Logging in user with a bad password"""
    def assertResponse(self, respData, errCode = testLib.RestTestCase.ERR_BAD_CREDENTIALS):
        """
        Check that the response data dictionary matches the expected values
        """
        expected = { 'errCode' : errCode }
        self.assertDictEqual(expected, respData)

    def testAdd1(self):
        respData = self.makeRequest("/users/login", method="POST", data = { 'user' : 'user1', 'password' : 'uhoh'} )
        self.assertResponse(respData)


class TestDbReset(testLib.RestTestCase):
    """Test Logging in user that has not been created"""
    def assertResponse(self, respData, errCode = testLib.RestTestCase.SUCCESS):
        """
        Check that the response data dictionary matches the expected values
        """
        expected = { 'errCode' : errCode }
        self.assertDictEqual(expected, respData)

    def testAdd1(self):
        respData = self.makeRequest("/TESTAPI/resetFixture", method="POST", data = {}) ###not sure about empty dict
        self.assertResponse(respData)