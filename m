From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2] spi/s3c64xx: Expand S3C64XX_SPI_{DE,}ACT macros at
 call sites
Date: Thu, 28 Jun 2012 20:52:45 +0200
Message-ID: <CACRpkdaC3mXcgTib3JWOjuvaWU_NEcg1JCV-4QNS4EcAAZzCJQ@mail.gmail.com>
References: <1340889811-7524-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1340889811-7524-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Kukjin Kim <kgene.kim@samsung.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	linux-samsung-soc@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1340889811-7524-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Jun 28, 2012 at 3:23 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:

> They have very few users and they're both just doing a single register
> write so the advantage of having the macro is a bit limited. An inline
> function might make sense but it's as easy to just do the writes directly.
>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Much clearer.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
