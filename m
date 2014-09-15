From: Anders Berg <anders.berg-1wcpHE2jlwO1Z/+hSey0Gg@public.gmane.org>
Subject: Re: [PATCH] spi: pl022: Add support for chip select extension
Date: Mon, 15 Sep 2014 12:59:54 +0200
Message-ID: <CAE0=X_1Rh_XWKoR+wn=uz+hcKZtKtq+7eE_Q3QAEHoyfXCX57g@mail.gmail.com>
References: <1410360030-26634-1-git-send-email-anders.berg@avagotech.com>
	<CACRpkdavQBJkaC40GJkD396JkwPjSr_dzWegn8veLpG-Fcn-SQ@mail.gmail.com>
	<CAE0=X_1YMs1OUx3H65qbZ9CX-oSiW4Uo65Z7qCW8-6ksc4ovvQ@mail.gmail.com>
	<CACRpkdZfzsg-upNJaWX5CO6dJn3mg=wzhKhX-koask4ckxVTmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACRpkdZfzsg-upNJaWX5CO6dJn3mg=wzhKhX-koask4ckxVTmQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Sep 12, 2014 at 7:00 PM, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On Thu, Sep 11, 2014 at 10:10 PM, Anders Berg <anders.berg-1wcpHE2jlwO1Z/+hSey0Gg@public.gmane.org> wrote:
(...)
>> I picked 0xb6 since I've seen some reference manuals for other AMBA
>> peripherals the use of JEDEC assigned vendor IDs in this register field (see
>> the PL390 TRM for example). So I put the LSI Logic 7-bit JEDEC ID (0x36)
>> there: [0:6] = 0x36, [7] = 1 (the MSB set to '1' to signify the use of JEDEC
>> ID instead of a "classic" AMBA vendor).
>
> Hey that's very observant, I had no clue about that scheme!
>
> Can you write a comment about this in <linux/amba/bus.h> when
> you patch it (like above the enum) so we know that in the future
> when people need to pick new IDs?

Sure, will do.

/Anders
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
