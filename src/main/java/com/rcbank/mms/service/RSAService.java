package com.rcbank.mms.service;

import javax.servlet.http.HttpServletRequest;
import java.security.interfaces.RSAPublicKey;

public interface RSAService {

    RSAPublicKey generateKey(HttpServletRequest request);

    void removePrivateKey(HttpServletRequest request);

    String decryptParameter(String name, HttpServletRequest request);

}