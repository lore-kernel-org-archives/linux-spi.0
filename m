From: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: RE: [PATCH 10/14] drivers/spi/spi-ep93xx.c: fix error return code
Date: Wed, 22 Aug 2012 11:12:26 -0500
Message-ID: <ADE657CA350FB648AAC2C43247A983F00206B1B19DD6@AUSP01VMBX24.collaborationhost.net>
References: <1345365870-29831-1-git-send-email-Julia.Lawall@lip6.fr>
 <1345365870-29831-12-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Julia Lawall <Julia.Lawall@lip6.fr>,
	Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1345365870-29831-12-git-send-email-Julia.Lawall@lip6.fr>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sunday, August 19, 2012 1:44 AM, Julia Lawall wrote:
> From: Julia Lawall <Julia.Lawall@lip6.fr>
>
> Initialize return variable before exiting on an error path.

<snip>

> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>
> ---
>  drivers/spi/spi-ep93xx.c |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
> index f97f1d2..9e7fdfd 100644
> --- a/drivers/spi/spi-ep93xx.c
> +++ b/drivers/spi/spi-ep93xx.c
> @@ -1105,6 +1105,7 @@ static int __devinit ep93xx_spi_probe(struct platform_device *pdev)
>  	espi->wq = create_singlethread_workqueue("ep93xx_spid");
>  	if (!espi->wq) {
>  		dev_err(&pdev->dev, "unable to create workqueue\n");
> +		error = -ENOMEM;
>  		goto fail_free_dma;
>  	}
>  	INIT_WORK(&espi->msg_work, ep93xx_spi_work);

Looks ok to me... Thanks!

Reviewed-by: H Hartley Sweeten <hsweeten@visionengravers.com>
