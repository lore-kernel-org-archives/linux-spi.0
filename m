From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] spi: introduce max message size flag in spi_master
Date: Wed, 17 Aug 2016 20:51:12 +0200
Message-ID: <09d8a91d-8187-abdc-33d0-622208fdb251@gmail.com>
References: <6c95366c-7fcc-ef4c-033a-f9f6e152a669@gmail.com>
 <20160816164204.GV9347@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160816164204.GV9347-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Am 16.08.2016 um 18:42 schrieb Mark Brown:
> On Sun, Aug 07, 2016 at 09:47:18PM +0200, Heiner Kallweit wrote:
> 
>> As there are no (known) spi controller with differing size limits for
>> transfer and message, introduce a flag in spi_master to indicate that
>> the max transfer size is also the maximum message size.
> 
> This is a *really* cumbersome interface which will doubtless be found to
> be broken at some point by some hardware that does have separate
> restrictons on both.  Let's just specify the limit directly unless
> there's some pressing reason not to.
> 
> There's also something off with the way you're posting the patches, your
> patch series isn't threaded together.  
> 
Thanks for the feedback. I'll address both points and send a v2.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
