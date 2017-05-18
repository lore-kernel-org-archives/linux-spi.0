From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: spidev: Adjust five checks for null pointers
Date: Thu, 18 May 2017 16:34:45 +0200
Message-ID: <5d9f71d4-2f0d-7083-fd28-fb505841b502@users.sourceforge.net>
References: <c5452d8c-d123-d5e9-b2cc-a386d1325aec@users.sourceforge.net>
 <df3e58c6-f70d-a5d3-102e-4fab2f7df126@users.sourceforge.net>
 <20170518112846.tcirhguyps3kk3ra@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: linux-spi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170518112846.tcirhguyps3kk3ra@sirena.org.uk>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

>> MIME-Version: 1.0
>> Content-Type: text/plain; charset=UTF-8
>> Content-Transfer-Encoding: 8bit
> 
> Please fix however you're sending things out to avoid this noise.

The Git software generated such extra information because my commit message
contained a few special characters.


>> The script “checkpatch.pl” pointed information out like the following.
>>
>> Comparison to NULL could be written !…
>>
>> Thus fix the affected source code places.
> 
> This changelog does not describe any purpose in making this change,
> we could equally well say the exact opposite.  Why should we do this?

How do you think about to reduce the usage of the preprocessor symbol “NULL”?

Can it help if the source code is a little bit shorter after the
proposed adjustment?

Regards,
Markus
