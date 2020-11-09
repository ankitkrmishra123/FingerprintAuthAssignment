package com.exapmle.fingerprintauthassignment;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.content.ContextCompat;

import android.Manifest;
import android.app.KeyguardManager;
import android.content.pm.PackageManager;
import android.hardware.fingerprint.FingerprintManager;
import android.os.Build;
import android.os.Bundle;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {

    private FingerprintManager fingerprintManager;
    private KeyguardManager keyguardManager;
    TextView scannertaptext;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        scannertaptext = findViewById(R.id.scannertaptext);

        // TODO check1 : Android version should be greater or equal to Marshmallow
        // TODO check2 : Device has fingerprint scanner
        // TODO check3 : Have permission to use fingerprint scanner in the app
        // TODO check4 : LockScreen is secured with atleast ine type of lock
        // TODO check5 : Atleast one fingerprint ios registered




        if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.M){

            fingerprintManager = (FingerprintManager) getSystemService(FINGERPRINT_SERVICE);
            keyguardManager = (KeyguardManager) getSystemService(KEYGUARD_SERVICE);

            if(!fingerprintManager.isHardwareDetected()){
                scannertaptext.setText("Fingerprint Scanner not detected in Device");
            }
            else if(ContextCompat.checkSelfPermission(this, Manifest.permission.USE_FINGERPRINT) != PackageManager.PERMISSION_GRANTED){
                scannertaptext.setText("Permission not granted to use Fingerprint Scanner");

            }else if(!keyguardManager.isKeyguardSecure()){
                scannertaptext.setText("add lock to your phone in settings");

            }else if(!fingerprintManager.hasEnrolledFingerprints()){
                scannertaptext.setText("you should add atleast one fingerprint to use this feature");
            }else{
                scannertaptext.setText("place your fingerprint on scanner for authentication");

                FingerprintHandler fingerprintHandler = new FingerprintHandler(this);
                fingerprintHandler.startAuth(fingerprintManager, null);
            }
        }
    }
}