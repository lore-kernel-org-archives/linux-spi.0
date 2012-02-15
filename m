From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] spi/s3c64xx: Convert to using core message queue
Date: Wed, 15 Feb 2012 23:51:54 +0100
Message-ID: <CACRpkdYTEUKv60qwRMyxYnmP6kb+BvsqUkzB=2as_1TH4+XJcw@mail.gmail.com>
References: <1329346112-1647-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kukjin Kim <kgene.kim@samsung.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net,
	linux-samsung-soc@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1329346112-1647-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Feb 15, 2012 at 11:48 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:

> Convert the s3c64xx driver to using the new message queue factored ou=
t of
> the pl022 driver by Linus Walleij, saving us a nice block of code and
> getting the benefits of improvements implemented in the core.
>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

> Only lightly tested thus far. =A0Linus, it'd be really nice if you co=
uld
> add this to your patch queue for this feature until it's merged by
> Grant.

I just pinged Grant on the main (v2) patch, if there are issues to
be resolved I will carry this patch in the series, if Grant is happy
with v2 we can just push this on top I guess...

Thanks,
Linus Walleij
