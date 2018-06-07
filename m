From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [RFC PATCH 1/2] spi: spi-mem: Add a new API to support direct
 mapping
Date: Thu, 7 Jun 2018 17:16:57 +0200
Message-ID: <20180607171657.4b819462@bbrezillon>
References: <20180601143603.4047-1-boris.brezillon@bootlin.com>
 <20180601143603.4047-2-boris.brezillon@bootlin.com>
 <20180607170153.757ca102@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Vignesh R <vigneshr@ti.com>, Richard Weinberger <richard@nod.at>,
 Cyrille Pitchen <cyrille.pitchen@microchip.com>, linux-spi@vger.kernel.org,
 Marek Vasut <marek.vasut@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-mtd@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20180607170153.757ca102@xps13>
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

Hi Miquel,

On Thu, 7 Jun 2018 17:01:53 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Hi Boris,
> 
> On Fri,  1 Jun 2018 16:36:02 +0200, Boris Brezillon
> <boris.brezillon@bootlin.com> wrote:
> 
> > Most modern QSPI controllers support can directly map a SPI memory (or  
> 
> s/support// ?

Yep.

> 
> > a portion of the SPI memory) in the CPU address space. Most of the time
> > this brings significant performance improvements as it automates the
> > whole process of sending SPI memory operations every time a new region
> > is accessed.
> > 
> > This new API allow SPI memory driver to create direct mappings and then  
> 
> s/allow/allows/
> s/driver/drivers/ ?

Looks like I should have spent more time checking my commit message :-).
Will fix that.

> 
> > use them to access the memory instead of using spi_mem_exec_op().
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> > ---
> >  drivers/spi/spi-mem.c       | 267 ++++++++++++++++++++++++++++++++++++++++----
> >  include/linux/spi/spi-mem.h |  72 ++++++++++++
> >  2 files changed, 318 insertions(+), 21 deletions(-)
> > 
> > diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> > index 990770dfa5cf..90ea0c5263a7 100644
> > --- a/drivers/spi/spi-mem.c
> > +++ b/drivers/spi/spi-mem.c
> > @@ -175,6 +175,44 @@ bool spi_mem_supports_op(struct spi_mem *mem, const struct spi_mem_op *op)
> >  }
> >  EXPORT_SYMBOL_GPL(spi_mem_supports_op);
> >  
> > +static int spi_mem_access_start(struct spi_mem *mem)
> > +{
> > +	struct spi_controller *ctlr = mem->spi->controller;
> > +
> > +	/*
> > +	 * Flush the message queue before executing our SPI memory
> > +	 * operation to prevent preemption of regular SPI transfers.
> > +	 */
> > +	spi_flush_queue(ctlr);
> > +
> > +	if (ctlr->auto_runtime_pm) {
> > +		int ret;
> > +
> > +		ret = pm_runtime_get_sync(ctlr->dev.parent);
> > +		if (ret < 0) {
> > +			dev_err(&ctlr->dev, "Failed to power device: %d\n",
> > +				ret);
> > +			return ret;
> > +		}
> > +	}
> > +
> > +	mutex_lock(&ctlr->bus_lock_mutex);
> > +	mutex_lock(&ctlr->io_mutex);
> > +
> > +	return 0;
> > +}
> > +
> > +static void spi_mem_access_end(struct spi_mem *mem)
> > +{
> > +	struct spi_controller *ctlr = mem->spi->controller;
> > +
> > +	mutex_unlock(&ctlr->io_mutex);
> > +	mutex_unlock(&ctlr->bus_lock_mutex);
> > +
> > +	if (ctlr->auto_runtime_pm)
> > +		pm_runtime_put(ctlr->dev.parent);
> > +}
> > +
> >  /**
> >   * spi_mem_exec_op() - Execute a memory operation
> >   * @mem: the SPI memory
> > @@ -200,30 +238,13 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
> >  		return -ENOTSUPP;
> >  
> >  	if (ctlr->mem_ops) {
> > -		/*
> > -		 * Flush the message queue before executing our SPI memory
> > -		 * operation to prevent preemption of regular SPI transfers.
> > -		 */
> > -		spi_flush_queue(ctlr);
> > -
> > -		if (ctlr->auto_runtime_pm) {
> > -			ret = pm_runtime_get_sync(ctlr->dev.parent);
> > -			if (ret < 0) {
> > -				dev_err(&ctlr->dev,
> > -					"Failed to power device: %d\n",
> > -					ret);
> > -				return ret;
> > -			}
> > -		}
> > +		ret = spi_mem_access_start(mem);
> > +		if (ret)
> > +			return ret;
> >  
> > -		mutex_lock(&ctlr->bus_lock_mutex);
> > -		mutex_lock(&ctlr->io_mutex);
> >  		ret = ctlr->mem_ops->exec_op(mem, op);
> > -		mutex_unlock(&ctlr->io_mutex);
> > -		mutex_unlock(&ctlr->bus_lock_mutex);
> >  
> > -		if (ctlr->auto_runtime_pm)
> > -			pm_runtime_put(ctlr->dev.parent);
> > +		spi_mem_access_end(mem);  
> 
> As this is something you tell me on a weekly basis: would you mind to
> separate the direct mapping support and the
> spi_mem_access_start/end() helpers introduction in different
> patches? :)

Sure, actually I was expecting this request :P.

> 
> >  
> >  		/*
> >  		 * Some controllers only optimize specific paths (typically the
> > @@ -336,6 +357,210 @@ int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
> >  }
> >  EXPORT_SYMBOL_GPL(spi_mem_adjust_op_size);
> >    
> 
> [...]
> 
> > +
> > +/**
> > + * struct spi_mem_dirmap_desc - Direct mapping descriptor
> > + * @mem: the SPI memory device this direct mapping is attached to
> > + * @info: information passed at direct mapping creation time
> > + * @nodirmap: set to true if the SPI controller does not implement
> > + *	      ->mem_ops->dirmap_create() or when this function returned an  
> 
> s/returned/returns/

No, I really meant returned here.

> 
> > + *	      error. If dirmap is true, all spi_mem_dirmap_{read,write}()
> > + *	      calls will use spi_mem_exec_op() to access the memory. This is a
> > + *	      degraded mode that allows higher spi_mem drivers to use the same
> > + *	      code no matter if the controller supports direct mapping or not
> > + * @priv: field pointing to controller specific data
> > + *
> > + * Common part of a direct mapping descriptor. This object is created by
> > + * spi_mem_dirmap_create() and controller implementation of ->create_dirmap()
> > + * can create/attach direct mapping resources to the descriptor in the ->priv
> > + * field.
> > + */
> > +struct spi_mem_dirmap_desc {
> > +	struct spi_mem *mem;
> > +	struct spi_mem_dirmap_info info;
> > +	bool nodirmap;
> > +	void *priv;
> > +};
> > +
> >  /**
> >   * struct spi_mem - describes a SPI memory device
> >   * @spi: the underlying SPI device
> > @@ -167,10 +210,24 @@ static inline void *spi_mem_get_drvdata(struct spi_mem *mem)
> >   *		    limitations)
> >   * @supports_op: check if an operation is supported by the controller
> >   * @exec_op: execute a SPI memory operation
> > + * @dirmap_create: create a direct mapping descriptor that can later be used to
> > + *		   access the memory device. This method is optional  
> 
> Only *dirmap_create() is marked as optional while all are.

It's a bit more complicated than that. If ->dirmap_create() is not
implemented then all other hooks should be left empty. On the other
hand, if it's implemented then at least one of the
->dirmap_{read,write}() should be implemented. ->dirmap_destroy() is
optional. I'll try to clarify the situation.

> 
> > + * @dirmap_destroy: destroy a memory descriptor previous created by
> > + *		    ->dirmap_create()  
> 
> s/previous/previously/

Yep.

> 
> > + * @dirmap_read: read data from the memory device using the direct mapping
> > + *		 created by ->dirmap_create().
> > + * @dirmap_write: write data to the memory device using the direct mapping
> > + *		  created by ->dirmap_create().  
> 
> I think there is a better kernel-doc way to reference dirmap_create(),
> maybe with '@' (I don't remember exactly).

I think its &struct_spi_mem_ops->dirmap_create(), but I'm not sure.

Thanks for the review.

Boris

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
