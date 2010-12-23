From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/2] spi_imx.c: CSPI3 irq is 0 on imx25
Date: Thu, 23 Dec 2010 11:59:21 -0700
Message-ID: <20101223185921.GB20384@angua.secretlab.ca>
References: <1293102730-32528-1-git-send-email-richard.genoud@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: spi-devel-general@lists.sourceforge.net,
	David Brownell <dbrownell@users.sourceforge.net>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1293102730-32528-1-git-send-email-richard.genoud@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Dec 23, 2010 at 12:12:09PM +0100, Richard Genoud wrote:
> On imx25 soc, MX25_INT_CSPI3 is 0
> (cf arch/arm/plat-mxc/include/mach/mx25.h).
> So, the test (spi_imx->irq <= 0) returned an error
> for this platform.
> This patch corrects this behaviour.
> 
> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
> ---
>  drivers/spi/spi_imx.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/spi/spi_imx.c b/drivers/spi/spi_imx.c
> index 55a38e2..793ae99 100644
> --- a/drivers/spi/spi_imx.c
> +++ b/drivers/spi/spi_imx.c
> @@ -847,7 +847,7 @@ static int __devinit spi_imx_probe(struct platform_device *pdev)
>  	}
>  
>  	spi_imx->irq = platform_get_irq(pdev, 0);
> -	if (spi_imx->irq <= 0) {
> +	if (spi_imx->irq < 0) {

I *really* don't want to apply this.  The kernel is slowly moving
toward NO_IRQ == 0 for all architectures.  This patch is a step in the
wrong direction because it will break with ARM starts using 0 for
NO_IRQ.

I would accept a change to spi_imx->irq == NO_IRQ however.

g.
