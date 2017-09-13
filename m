From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 0/2] Fix issues in Armada-3700 SPI controller driver
Date: Wed, 13 Sep 2017 10:20:38 -0700
Message-ID: <87o9qeh5w9.fsf@free-electrons.com>
References: <20170913162139.17598-1-miquel.raynal@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        Antoine Tenart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170913162139.17598-1-miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> (Miquel
        Raynal's message of "Wed, 13 Sep 2017 18:21:37 +0200")
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Miquel and Mark,
 
 On mer., sept. 13 2017, Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:

> Hello,
>
> This short serie addresses two issues in Armada-3700 SPI controller driver.
>
> Second patch from Zachary Zhang fixes the way padding is introduced in not
> 4-byte aligned SPI transfers (that fails some NAND flash devices). It also
> revealed the issue fixed by the first commit when using quad-SPI. Thus, it
> would be preferable to apply them in that order.
>
> Differences with the first version:
> - Added this cover letter.
> - Fixed the commit titles by using "spi: armada-3700:" prefix.
>
> And sorry for the noise.

These two patches being fixes it would be nice to add the Fixes and
Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> flags. Indeed the older version on Linux
should be fixed too.

Miquel could you provide the accurate Fixes: flag ?
(By the way there is also a way to indicate dependency between patches
for stable, see Documentation/process/stable-kernel-rules.rst.)

Mark, could you amend the patches with the flags that will be provided
my Miquel? Thanks, to this the patches will be backported to te stables
branches.

Thanks!

Gregory

>
> Thanks,
> Miquel
>
> Miquel Raynal (1):
>   spi: armada-3700: Fix failing commands with quad-SPI
>
> Zachary Zhang (1):
>   spi: armada-3700: Fix padding when sending not 4-byte aligned data
>
>  drivers/spi/spi-armada-3700.c | 142 ++++++++++++++----------------------------
>  1 file changed, 46 insertions(+), 96 deletions(-)
>
> -- 
> 2.11.0
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
