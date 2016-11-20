if (Get-Command brew -errorAction SilentlyContinue)
{
    return $true;
}
else
{
    # More info: https://brew.sh
    
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    return $true;
}

return $false;