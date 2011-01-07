From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] spi_imx.c: correct the test on platform_get_irq()
 return value
Date: Fri, 7 Jan 2011 09:58:15 -0700
Message-ID: <20110107165815.GA25446@angua.secretlab.ca>
References: <AANLkTimpTUz_Fizef09urPBR8vP80KU-5yApjzGWFwc0@mail.gmail.com>
 <1294410361-9092-1-git-send-email-richard.genoud@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: spi-devel-general@lists.sourceforge.net,
	David Brownell <dbrownell@users.sourceforge.net>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1294410361-9092-1-git-send-email-richard.genoud@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Jan 07, 2011 at 03:26:01PM +0100, Richard Genoud wrote:
> The test "if (spi_imx->irq <= 0)" is not testing the IRQ value, but the return value of platform_get_irq().
> As platform_get_irq() can return an error (-ENXIO) or the IRQ value it found, the test should be "if (spi_imx->irq < 0)"
> 
> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>

Alright.  Applied.

g.

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
>  		ret = -EINVAL;
>  		goto out_iounmap;
>  	}
> -- 
> 1.7.1
> 
