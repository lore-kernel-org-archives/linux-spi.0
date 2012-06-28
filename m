From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/2] spi/s3c64xx: Convert to devm_request_and_ioremap()
Date: Thu, 28 Jun 2012 20:51:44 +0200
Message-ID: <CACRpkdYwGoUwSRX2ASa5kJPpNFtmxbKPtgwUnFhQzZs9EUoHQQ@mail.gmail.com>
References: <1340889811-7524-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Kukjin Kim <kgene.kim@samsung.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	linux-samsung-soc@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1340889811-7524-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Jun 28, 2012 at 3:23 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:

> Saves some error handling and a small amount of code.
>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Elegant, monsieur.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

I'm starting to wonder if it would not be possible to mass-convert these
using coccinelle.

Yours,
Linus Walleij
