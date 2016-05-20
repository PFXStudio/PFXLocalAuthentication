# PFXLocalAuthentication
PFXLocalAuthentication

````
- (IBAction)localAuthenticationButtonTouched:(id)sender {
    [PFXLocalAuthentication canLocalAuthenticationWithCompletion:^{
        [PFXLocalAuthentication evaluateLocalAuthenticationWithCompletion:^{
            NSLog(@"Success Fingerprint authentication");
        } failure:^(NSError *error) {
            [self showPasswordAlert];
        }];
    } failure:^(NSError *error) {
        [self showPasswordAlert];
    }];
}

````


# PFXStudio

Mobile : http://pfxstudio.modoo.at/

Twitter : http://twitter.com/pfxstudio

Facebook : http://facebook.com/pfxstudio

Github : https://github.com/PFXStudio

iOS AppStore : https://itunes.apple.com/kr/artist/ppark/id448017898

Google Play : https://play.google.com/store/apps/developer?id=PFXStudio
