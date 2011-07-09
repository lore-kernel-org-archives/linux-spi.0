From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] pxa2xx_spi: fix memory corruption
Date: Sun, 10 Jul 2011 00:11:09 +0100
Message-ID: <20110709231108.GQ4812@n2100.arm.linux.org.uk>
References: <1310246098-21208-1-git-send-email-anarsoul@gmail.com>
	<201107100105.48168.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Vasily Khoruzhick <anarsoul@gmail.com>,
	spi-devel-general@lists.sourceforge.net, Eric Miao <eric.y.miao@gmail.com>,
	linux-arm-kernel@lists.infradead.org
To: Marek Vasut <marek.vasut@gmail.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <201107100105.48168.marek.vasut@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On Sun, Jul 10, 2011 at 01:05:48AM +0200, Marek Vasut wrote:
> On Saturday, July 09, 2011 11:14:58 PM Vasily Khoruzhick wrote:
> > pxa2xx_spi_probe allocates struct driver_data and null_dma_buf
> > at same time via spi_alloc_master(), but then calculates
> > null_dma_buf pointer incorrectly, and it causes memory corruption
> > later if DMA usage is enabled.
> > 
> > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > ---
> >  drivers/spi/pxa2xx_spi.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/spi/pxa2xx_spi.c b/drivers/spi/pxa2xx_spi.c
> > index dc25bee..ef38fbf 100644
> > --- a/drivers/spi/pxa2xx_spi.c
> > +++ b/drivers/spi/pxa2xx_spi.c
> > @@ -1569,7 +1569,7 @@ static int __devinit pxa2xx_spi_probe(struct
> > platform_device *pdev) master->transfer = transfer;
> > 
> >  	drv_data->ssp_type = ssp->type;
> > -	drv_data->null_dma_buf = (u32 *)ALIGN((u32)(drv_data +
> > +	drv_data->null_dma_buf = (u32 *)ALIGN(((u32)drv_data +
> >  						sizeof(struct driver_data)), 8);
> 
> This thing looks a bit disturbing in itself. Like, where the heck is that thing 
> pointing in the end ? Since some data are written to address in "null_dma_buf" 
> ... isn't this just changing the corruption impact ?

        /* Allocate master with space for drv_data and null dma buffer */
        master = spi_alloc_master(dev, sizeof(struct driver_data) + 16);

So there's 16 bytes at the end of driver_data.

However:

	(u32)(drv_data + sizeof(struct driver_data))

is pointer arithmetic.  drv_data points at an object of sizeof(struct
driver_data).  Adding one to this increments the pointer by
sizeof(struct driver_data) bytes.  So the above expression increments
the pointer by sizeof(struct driver_data)*sizeof(struct driver_data)
bytes, which is obviously complete rubbish.

	((u32)drv_data + sizeof(struct driver_data))

casts drv_data to a u32 first, then adds the sizeof(struct driver_data)
which moves us into the 16 bytes allocated off the end of the struct.
