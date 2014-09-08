From: Anders Berg <anders.berg-1wcpHE2jlwO1Z/+hSey0Gg@public.gmane.org>
Subject: Re: [PATCH 1/2] gpio: Add driver for AXM55xx SSP chip selects
Date: Mon, 8 Sep 2014 13:02:32 +0200
Message-ID: <CAE0=X_2q1Z+pGuh6OY9Si5jbrF9HkczNFUqUgK_8xBekNvMeyQ@mail.gmail.com>
References: <1409576021-24828-1-git-send-email-anders.berg@avagotech.com>
	<1409576021-24828-2-git-send-email-anders.berg@avagotech.com>
	<CACRpkdby4H-fivNn_kG2uL0EjsCGAc+t6OyFi0+VcNGf2Z9NQA@mail.gmail.com>
	<20140904170630.GL29327@sirena.org.uk>
	<CACRpkdZEoBan=Lqr1T-iY41U9NfMA_MCLX3LA=juw7X4pmRvSQ@mail.gmail.com>
	<CAE0=X_3QO5p26M=FS7joKS3zD6LAM_moFutHNcyE1-CjauL3Rw@mail.gmail.com>
	<20140906135308.GC2601@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140906135308.GC2601-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Sat, Sep 6, 2014 at 3:53 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Fri, Sep 05, 2014 at 11:05:37AM +0200, Anders Berg wrote:
>
>> Well, the problem with adding this to the spi-pl022 driver (as a
>> vendor specific extension) is that this IP block unfortunately isn't
>> distinguishable from the standard ARM PL022 implementation (same
>> values in the PrimeCell identification registers). That's why I went
>> down the GPIO path...
>
> Would it not be more straightforward to just register it as a platform
> device in this case, or use a separate OF ID in the DT?  We appear to
> specify a compatible string when registering AMBA devices even if we are
> capable of identifying using the ID registers.

I'll drop this gpio patch for now and submit a patch on the pl022
driver instead. I read the arm,primecell binding and learned that
there is a property (arm,primecell-periphid) that can be used to
override the HW PrimeCell ID. Seems like something to use here, right?

/Anders
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
