From: Maxime Bizon <mbizon@freebox.fr>
Subject: Re: [PATCH v4] spi: add Broadcom BCM63xx SPI controller driver
Date: Wed, 01 Feb 2012 12:22:09 +0100
Message-ID: <1328095329.4936.21.camel@sakura.staff.proxad.net>
References: <1328019048-5892-10-git-send-email-florian@openwrt.org>
         <1328091249-10389-1-git-send-email-florian@openwrt.org>
Reply-To: mbizon@freebox.fr
Mime-Version: 1.0
Content-Type: text/plain; charset="ANSI_X3.4-1968"
Content-Transfer-Encoding: 7bit
Cc: ralf@linux-mips.org, linux-mips@linux-mips.org,
        spi-devel-general@lists.sourceforge.net,
        Tanguy Bouzeloc <tanguy.bouzeloc@efixo.com>
To: Florian Fainelli <florian@openwrt.org>
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1328091249-10389-1-git-send-email-florian@openwrt.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-Id: linux-spi.vger.kernel.org


On Wed, 2012-02-01 at 11:14 +0100, Florian Fainelli wrote:

Hi Florian,

> +struct bcm63xx_spi {
> +	spinlock_t		lock;

this lock is never actually used

it is referenced only once in device removal path

> +	int			stopping;

this can be removed by changing device removal path to first call
spi_unregister_master. that way the spi stack cannot call spi_transfer
anymore and we don't need to abort these calls.


> +static int bcm63xx_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
> +{

> [...]

> +	bcm_spi_writew(bs, cmd, SPI_CMD);
> +	wait_for_completion(&bs->done);
> +

bcm63xx_txrx_bufs() is called by bcm63xx_transfer(), and according to
Documentation/spi/spi-summary:

    master->transfer(struct spi_device *spi, struct spi_message *message)
	This must not sleep.  Its responsibility is arrange that the
        transfer happens and its complete() callback is issued.  The two
        will normally happen later, after other transfers complete, and
        if the controller is idle it will need to be kickstarted.

So we cannot do a synchronous wait here, this must be pushed to a
workqueue or kthread.


-- 
Maxime
