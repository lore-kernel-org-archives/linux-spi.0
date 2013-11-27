From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH] Fix long standing chip select issue for non-default CS-polarity setups
Date: Wed, 27 Nov 2013 20:00:00 +0100
Message-ID: <36A84195-DC42-499A-8663-5AE0CCDD720F@martin.sperl.org>
References: <EE805C3B-7650-45CF-ACA7-5A83758B7F77@martin.sperl.org> <20131127184001.GG14725@sirena.org.uk>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: bootc-1Slo4GeK4H1eoWH0uzbU5w@public.gmane.org, swarren-3lzwWm7+WeqjrCrn2yxA+g@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131127184001.GG14725-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

I will try to come up with something that will fit better.

Anyway: the case of changing polarity from invers to normal is
not handled correctly with the current patch.

Still I believe "compiling" the flags once in the setup code and then 
just using them should avoid wasting some cpu cycles in this driver.

> That's just never going to be a sane thing to change on the fly though.
> Changes to things that don't affect /CS are more interesting here.
I believe we need to state the above fact explicitly that this has
the potential for a race condition (maybe other flags as well) in case 
no bus-lock is held and thought should be given to that during the
design.

Martin

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
