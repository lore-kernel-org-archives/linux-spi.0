From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: spi/ppc4xx: Adjust checks for null pointers in two functions
Date: Tue, 17 Jan 2017 19:48:26 +0100
Message-ID: <20ac3577-3b0e-e7d3-d5de-8e511a6e9fd2@users.sourceforge.net>
References: <1413e173-dbac-7a6e-09cb-2287300a335e@users.sourceforge.net>
 <d9bd24b0-d4d5-233c-756d-71aaed63c5ef@users.sourceforge.net>
 <20170117183411.7isqrvu3o55ydjcb@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-spi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170117183411.7isqrvu3o55ydjcb@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

>> From: Markus Elfring <elfring@users.sourceforge.net>
>> Date: Fri, 13 Jan 2017 14:56:10 +0100
>> MIME-Version: 1.0
>> Content-Type: text/plain; charset=UTF-8
>> Content-Transfer-Encoding: 8bit
> 
> This is also corrupted.

Would you like to explain this information a bit more?


The published patch looks reasonable in principle by other interfaces,
doesn't it?
https://lkml.org/lkml/2017/1/13/609
https://patchwork.kernel.org/patch/9516059/
https://lkml.kernel.org/r/<d9bd24b0-d4d5-233c-756d-71aaed63c5ef@users.sourceforge.net>

Regards,
Markus
