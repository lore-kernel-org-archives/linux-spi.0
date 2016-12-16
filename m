From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [patch 1/3] spi: armada-3700: Signedness bug in probe
Date: Fri, 16 Dec 2016 12:56:55 +0300
Message-ID: <20161216095655.GB8244@mwanda>
References: <20161216082443.GA7031@elgon.mountain>
 <e1c6a534-6b6c-a83f-390f-b65654ff2bcf@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        kernel-janitors@vger.kernel.org
To: Romain Perier <romain.perier@free-electrons.com>
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e1c6a534-6b6c-a83f-390f-b65654ff2bcf@free-electrons.com>
Sender: kernel-janitors-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Dec 16, 2016 at 10:36:29AM +0100, Romain Perier wrote:
> Hello,
> 
> Le 16/12/2016 à 10:33, Dan Carpenter a écrit :
> >We need "irq" to be an int because platform_get_irq() returns negative
> >error codes.
> >
> >Fixes: 5762ab71eb24 ("spi: Add support for Armada 3700 SPI Controller")
> >Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> >
> >diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
> >index e89da0af45d2..5c7508dc6f0b 100644
> >--- a/drivers/spi/spi-armada-3700.c
> >+++ b/drivers/spi/spi-armada-3700.c
> >@@ -108,7 +108,7 @@ struct a3700_spi {
> > 	struct spi_master *master;
> > 	void __iomem *base;
> > 	struct clk *clk;
> >-	unsigned int irq;
> >+	int irq;
> > 	unsigned int flags;
> > 	bool xmit_data;
> > 	const u8 *tx_buf;
> >
> 
> It is already fixed, see https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?id=f6f0083cca66e673cca6fa26b52b107b5570081d
> 

Ah good.

> And no we cannot just replace the type of the irq field like this
> because devm_request_irq/request_irq require an unsigned int as
> "irq" parameter.

That's immaterial, my patch works fine.  There are other place that use
a signed IRQ like the irq handler and platform_get_irq() which I
mentioned in my patch description.  It's never going to be perfectly
consistent.

But this is actually important that you thought it mattered.  Is there
something that prints a warning?  These irq signedness bugs are some of
the most common recurring bugs I see so it would help to figure out
why people are doing this...

regards,
dan carpenter


