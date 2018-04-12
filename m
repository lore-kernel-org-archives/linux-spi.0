From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v2 07/10] spi: bcm53xx: Implement the spi_mem interface
Date: Thu, 12 Apr 2018 15:09:52 +0200
Message-ID: <20180412150952.57a525ee@bbrezillon>
References: <20180410224439.9260-1-boris.brezillon@bootlin.com>
 <20180410224439.9260-8-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>, Vignesh R <vigneshr@ti.com>,
 Kamal Dasu <kdasu.kdev@gmail.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Peter Pan <peterpansjtu@gmail.com>,
 Frieder Schrempf <frieder.schrempf@exceet.de>,
 =?UTF-8?B?UmFmYcWCIE1pxYJl?= =?UTF-8?B?Y2tp?= <rafal@milecki.pl>,
 Sourav Poddar <sourav.poddar@ti.com>
To: David Woodhouse <dwmw2@infradead.org>, Brian Norris
 <computersforpeace@gmail.com>, Boris Brezillon
 <boris.brezillon@bootlin.com>, Marek Vasut <marek.vasut@gmail.com>, Richard
 Weinberger <richard@nod.at>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
 linux-mtd@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>,
 Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20180410224439.9260-8-boris.brezillon@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On Wed, 11 Apr 2018 00:44:36 +0200
Boris Brezillon <boris.brezillon@bootlin.com> wrote:

> The spi_mem interface is meant to replace the spi_flash_read() one.
> Implement the ->exec_op() method so that we can smoothly get rid of the
> old interface.
> 
> Note that the current ->flash_read() implementation looks a bit fragile
> since it does not take the ->read_opcode passed by the spi-nor layer
> into account, which means if might not work with all kind of NORs.
> 
> Anyway, I left the logic unchanged and added a few extra checks to make
> sure we're receiving something that looks like a NOR read operation.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> ---
> Changes in v2:
> - include spi-mem.h
> - treat op->addr.val differently since it's now an u64
> ---
>  drivers/spi/spi-bcm2835.c |  1 +
>  drivers/spi/spi-bcm53xx.c | 36 +++++++++++++++++++++++++++++++++++-
>  2 files changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
> index f35cc10772f6..41ed371eaf15 100644
> --- a/drivers/spi/spi-bcm2835.c
> +++ b/drivers/spi/spi-bcm2835.c
> @@ -37,6 +37,7 @@
>  #include <linux/of_gpio.h>
>  #include <linux/of_irq.h>
>  #include <linux/spi/spi.h>
> +#include <linux/spi/spi-mem.h>

Oops, I didn't modify the appropriate file. This line should be added
in drivers/spi/spi-bcm53xx.c. I'll fix that in the next version.

>  
>  /* SPI register offsets */
>  #define BCM2835_SPI_CS			0x00
> diff --git a/drivers/spi/spi-bcm53xx.c b/drivers/spi/spi-bcm53xx.c
> index d02ceb7a29d1..016059d3160b 100644
> --- a/drivers/spi/spi-bcm53xx.c
> +++ b/drivers/spi/spi-bcm53xx.c
> @@ -257,6 +257,38 @@ static int bcm53xxspi_transfer_one(struct spi_master *master,
>  	return 0;
>  }
>  
> +static int bcm53xxspi_exec_mem_op(struct spi_mem *mem,
> +				  const struct spi_mem_op *op)
> +{
> +	struct bcm53xxspi *b53spi = spi_master_get_devdata(mem->spi->master);
> +	u32 from;
> +
> +	/*
> +	 * FIXME: There's nothing in this driver programming the opcode and
> +	 * buswidth to be used when a read is done on the mmio window, but it
> +	 * seems to be used to access a SPI NOR device, so restrict access
> +	 * access to SPINOR_OP_READ commands.
> +	 */
> +	if (!op->data.nbytes || op->data.dir != SPI_MEM_DATA_IN ||
> +	    op->addr.nbytes != 3 || op->cmd.opcode != 0x3)
> +		return -ENOTSUPP;
> +
> +	/* Return -ENOTSUPP so that the core can fall back to normal reads. */
> +	from = op->addr.val;
> +	if (from + op->data.nbytes > BCM53XXSPI_FLASH_WINDOW)
> +		return -ENOTSUPP;
> +
> +	bcm53xxspi_enable_bspi(b53spi);
> +	memcpy_fromio(op->data.buf.in, b53spi->mmio_base + from,
> +		      op->data.nbytes);
> +
> +	return 0;
> +}
> +
> +static const struct spi_controller_mem_ops bcm53xxspi_mem_ops = {
> +	.exec_op = bcm53xxspi_exec_mem_op,
> +};
> +
>  static int bcm53xxspi_flash_read(struct spi_device *spi,
>  				 struct spi_flash_read_message *msg)
>  {
> @@ -311,8 +343,10 @@ static int bcm53xxspi_bcma_probe(struct bcma_device *core)
>  
>  	master->dev.of_node = dev->of_node;
>  	master->transfer_one = bcm53xxspi_transfer_one;
> -	if (b53spi->mmio_base)
> +	if (b53spi->mmio_base) {
> +		master->mem_ops = &bcm53xxspi_mem_ops;
>  		master->spi_flash_read = bcm53xxspi_flash_read;
> +	}
>  
>  	bcma_set_drvdata(core, b53spi);
>  


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
