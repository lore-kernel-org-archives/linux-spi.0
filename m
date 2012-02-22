From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] spi/s3c64xx: Convert to using core message queue
Date: Wed, 22 Feb 2012 10:07:06 +0100
Message-ID: <CACRpkdawRwsT9SBS7BjyEnZzV3Z+Fe=NKVde2ghxjxCuqWJaNg@mail.gmail.com>
References: <1329346112-1647-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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

> Convert the s3c64xx driver to using the new message queue factored out of
> the pl022 driver by Linus Walleij, saving us a nice block of code and
> getting the benefits of improvements implemented in the core.
>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Hi Mark,

I tried to include this patch for my patch series but it seems it might be
dependent on other stuff already applied in the SPI tree so I couldn't
get it to apply.

However I guess if Grant picks up the latest (v3) version of the
core patch it should apply just as fine on top of that one.

Yours,
Linus Walleij
