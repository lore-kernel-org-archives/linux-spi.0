From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi/pl022: Unprepare clocks while suspended
Date: Thu, 23 Jan 2014 08:13:09 +0100
Message-ID: <CACRpkdYPR92BS2Fzkw+m40cu__ct6xcku8yV6mY=_4dQU61tvw@mail.gmail.com>
References: <1390416154-3292-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linaro-kernel <linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>,
	Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1390416154-3292-1-git-send-email-broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Jan 22, 2014 at 7:42 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> From: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>
> When the driver was converted to clk_prepare() the suspend path didn't
> have any changes made so the clock remains prepared throughout the runtime
> of the driver. Unprepare it when suspended so that any savings that can be
> made as a result are made.
>
> Signed-off-by: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Acked-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Maybe you should update the probe() and remove()
runpaths to use the combined prepare_enable() &
unprepare_disable() calls as well when you're at it?

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
