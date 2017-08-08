EnviarSAFT
==========


Validates the most recent XML file on the folder and send it for designated addresses.

Usage
=====

just execute the file


Configuration
=============


There are 3 files for e-mail configuration.

The script assumes you're using a gmail account to send e-mails. Make sure you make all the security allowances at gmail settings to allow this kind of setup.

E-mail authentication
---------------------

This rests at `System/Config`:

    Email=email@gmail.com
    Password=passw0RD

Mail body
---------

`System/message.htm`:

    <html>
    <h1>Ficheiro em anexo</h1>
    
    <p>Este e-mail tem um ficheiro importante em anexo.</p>
    </html>


E-mail Recipients
-----------------


`System/recipients.txt`:

    Recipients=recipient@gmail.com
    Store=vbarra
    Subject=SAFT com anexo
    Message=ee


