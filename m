From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: pl022: Add support for chip select extension
Date: Thu, 11 Sep 2014 15:26:01 +0200
Message-ID: <CACRpkdavQBJkaC40GJkD396JkwPjSr_dzWegn8veLpG-Fcn-SQ@mail.gmail.com>
References: <1410360030-26634-1-git-send-email-anders.berg@avagotech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Anders Berg <anders.berg-1wcpHE2jlwO1Z/+hSey0Gg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1410360030-26634-1-git-send-email-anders.berg-1wcpHE2jlwO1Z/+hSey0Gg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Sep 10, 2014 at 4:40 PM, Anders Berg <anders.berg-1wcpHE2jlwO1Z/+hSey0Gg@public.gmane.org> wrote:

> Add support for a extended PL022 which has an extra register for controlling up
> to five chip select signals. This controller is found on the AXM5516 SoC.
> Unfortunately the PrimeCell identification registers are identical to a
> standard ARM PL022. To work around this, the peripheral ID must be overridden
> in the device tree using the "arm,primecell-periphid" property with the value
> 0x000b6022.
>
> Signed-off-by: Anders Berg <anders.berg-1wcpHE2jlwO1Z/+hSey0Gg@public.gmane.org>
(...)
> +               /*
> +                * PL022 variant that has a chip select control register whih
> +                * allows control of 5 output signals nCS[0:4].
> +                */
> +               .id     = 0x000b6022,

OK so you're defining 0xb6 to the the 8bit ID for LSI.

Do you have some special reason for this, like that it appears
in some other silicon block from LSI? Otherwise I suggest using
0x4c (uppercase 'L') so as to follow the pattern of the other
vendor IDs.

Please patch include/linux/amba/bus.h to add
AMBA_VENDOR_LSI = 0x4c (or 6b) as well, as this is the first
occurence.

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
