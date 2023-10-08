function checkProductLicenses()
    if ~hasProductLicenses()
        error("Required products for the workshop are missing. Visit the license link "+...
            "in Part II of the pre-work instructions and ensure that you are "+...
            "logged in to your MathWorks account in the browser. Then, log out of "+...
            "the MATLAB Mobile app (Settings -> Click your email address -> Forget "+...
            "Account) and log back in (Settings -> Log In).");
    end
end

function hasLicenses = hasProductLicenses
    % Checks whether all required products for the Pocket AI and IoT
    % workshop are available for use. 
    
    requiredToolboxes = {'Signal Processing Toolbox', 'Statistics and Machine Learning Toolbox'};
    requiredSpkgs = {'MATLAB Support Package for Android Sensors', 'MATLAB Support Package for Apple iOS Sensors'};
    
    installedToolboxes = ver;
    installedToolboxes = {installedToolboxes.Name};
    
    installedSpkgs = matlabshared.supportpkg.getInstalled;
    installedSpkgs = {installedSpkgs.Name};
    
    missingToolboxes = setdiff(requiredToolboxes, installedToolboxes);
    missingSpkgs = setdiff(requiredSpkgs, installedSpkgs);
    
    if isempty(missingToolboxes) && isempty(missingSpkgs)
        hasLicenses = true;
    else
        hasLicenses = false;
    end
end