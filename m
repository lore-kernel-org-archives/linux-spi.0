From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: bcm2835: add spi-bcm2835aux driver for the
 auxiliar spi1 and spi2
Date: Fri, 10 Jul 2015 22:53:36 -0600
Message-ID: <55A0A150.3060809@wwwdotorg.org>
References: <1434980408-4086-1-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
 linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1434980408-4086-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 06/22/2015 07:40 AM, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:
> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
> 
> This driver does NOT make use of native chip-selects but uses the
> generic cs-gpios facilities provided by the framework allowing for
> more than 3 chip-selects.

> diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c

> +/*
> + * spi register defines
> + *
> + * note there is garbage in the "official" documentation,
> + * so somedata taken from the file:
> + *   brcm_usrlib/dag/vmcsx/vcinclude/bcm2708_chip/aux_io.h
> + * inside of:
> + *   http://www.broadcom.com/docs/support/videocore/Brcm_Android_ICS_Graphics_Stack.tar.gz
> + */

Hopefully the license of that tar file allows for that. I didn't look.

> +DEFINE_SPINLOCK(__bcm2835_aux_lock);
> +static void bcm2835_aux_modify_enable(struct bcm2835aux_spi *bs,
> +				      u32 mask, u32 val)
> +{
> +	unsigned long flags;
> +	u32 r;
> +
> +	spin_lock_irqsave(&__bcm2835_aux_lock, flags);
> +
> +	r = readl(bs->aux_regs + BCM2835_AUX_ENABLE);
> +	r &= mask;
> +	r |= val;
> +	writel(r, bs->aux_regs + BCM2835_AUX_ENABLE);
> +
> +	spin_unlock_irqrestore(&__bcm2835_aux_lock, flags);
> +}

As mentioned elsewhere, I'd hope all the shared aux register
manipulations can be pushed into a shared driver.

> +static void bcm2835aux_spi_enable(struct bcm2835aux_spi *bs)
> +{
> +	/* identify the spi device - needed to activate the right HW-block */
> +	u32 mask = (size_t)bs->regs & 0x00000040 ?
> +		   BCM2835_AUX_BIT_SPI2 : BCM2835_AUX_BIT_SPI1;
> +
> +	bcm2835_aux_modify_enable(bs, ~mask, mask);
> +}

I expect that function will go away when my previous comment is
resolved. If not, it'd be nice to encode the "ID" of the device into DT,
so that the driver has no hard-coded idea of what register addresses
exist; what happens when (a hypothetical) bcm2837 comes along with 3
instances of this HW block?

> +static int bcm2835aux_spi_remove(struct platform_device *pdev)
> +{
> +	struct spi_master *master = platform_get_drvdata(pdev);
> +	struct bcm2835aux_spi *bs = spi_master_get_devdata(master);
> +
> +	/* Clear FIFOs, and disable the HW block */
> +	clk_disable_unprepare(bs->clk);

You probably want remove() to do things in the reverse order of probe().
In particular, disable the clock after anything that could touch
registers in the HW.

> +	bcm2835aux_spi_reset_hw(bs);
> +
> +	/* disable HW block */
> +	bcm2835aux_spi_disable(bs);
