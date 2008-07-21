From: Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>
Subject: Re: [RFT PATCH] SuperH HSPI controller driver.
Date: Mon, 21 Jul 2008 21:39:25 +0900
Message-ID: <20080721123925.GC19854__15652.9415552088$1216644069$gmane$org@linux-sh.org>
References: <20080721090744.GA16714@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-TtF/mJH4Jtrk1uMJSBkQmQ@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Manuel Lauss <mano-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080721090744.GA16714-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Jul 21, 2008 at 11:07:44AM +0200, Manuel Lauss wrote:
> +out2:
> +	release_resource(priv->ioarea);
> +	kfree(priv->ioarea);

What is this kfree() for?

> +static int __devexit hspi_remove(struct platform_device *pdev)
> +{
> +	struct hspi_priv *priv = platform_get_drvdata(pdev);
> +
> +	spi_bitbang_stop(&priv->bitbang);
> +	iowrite32(0, priv->io + SPCR);
> +	iowrite32(0, priv->io + SPSCR);
> +	iowrite32(0, priv->io + SPSR);
> +	free_irq(priv->irq, priv);
> +	iounmap(priv->io);
> +	release_resource(priv->ioarea);
> +	kfree(priv->ioarea);

Likewise here.

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
