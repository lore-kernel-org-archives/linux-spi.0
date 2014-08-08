From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi/pl022: Explicitly truncate large bitmask
Date: Fri, 8 Aug 2014 11:02:42 +0200
Message-ID: <CACRpkdbm3OE_czEeBAomPe9ceZ4PN_THzOU6jvya4TAKpZLDhg@mail.gmail.com>
References: <1406911735-17239-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linaro-kernel <linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>,
	Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1406911735-17239-1-git-send-email-broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Aug 1, 2014 at 6:48 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> From: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>
> When building on 64 bit architectures the use of bitwise negation generates
> constants larger than 32 bits which won't fit in u32s used to represent
> 32 bit register values on the device. Explicitly cast to let the compiler
> know that the higher bits are not significant and can be discarded.
>
> Signed-off-by: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Reviewed-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
