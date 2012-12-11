From: chao bi <chao.bi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] SPI: SSP SPI Controller driver
Date: Tue, 11 Dec 2012 10:00:16 +0800
Message-ID: <1355191216.30354.107.camel@bichao>
References: <1353464203.20353.6.camel@bichao>
	<20121206123856.002683E0AE3@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: jun.d.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, ken.k.mills-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, sylvain.centelles-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20121206123856.002683E0AE3@localhost>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Grant,
Thanks for your comments, please see my answer below..

On Thu, 2012-12-06 at 12:38 +0000, Grant Likely wrote:

> >  include/linux/spi/spi-intel-mid-ssp.h |  326 ++++++++
> 
> Most (if not all) of this header file looks like it needs to be moved
> into the .c file. Any symbol that is only used by the driver's .c file
> (usually, anything that isn't platform_data) belongs in the .c

Yes, we'll update it.

> > +#define DRIVER_NAME "intel_mid_ssp_spi_unified"
> 
> This string is used exactly one. Drop the #define.

Yes, we'll update it.

> > +static const struct pci_device_id pci_ids[];
> 
> If you move the pci_ids table up to this point then the forward
> declaration can be eliminated.
> 
> Also, use a driver-specific prefix on all symbols, even if they are
> static. It makes it a lot easier to navigate code when the symbol names
> match the driver and it avoids any possibility of conflict with the
> global namespace. Something like "midssp_" or "midssp_spi_".
> 
> So, this symbol would be midssp_spi_pci_ids[], and all the static
> functions below should be renamed.

Yes, we'll update it.

> > +static void dump_trailer(const struct device *dev, char *buf, int len, int sz)
> > +{
> > +	int tlen1 = (len < sz ? len : sz);
> > +	int tlen2 =  ((len - sz) > sz) ? sz : (len - sz);
> > +	unsigned char *p;
> > +	static char msg[MAX_SPI_TRANSFER_SIZE];
> 
> Is this size a limitation of the hardware, of of the driver?

I think this size is attributed to the DMA controller's maximum block size. 
On Medfield platform, the DMA controller used by SSP SPI has defined its maximum 
block size and word width, so SPI transfer size should not exceed the maximum size that 
DMA could transfer in one block.

> > +
> > +	memset(msg, '\0', sizeof(msg));
> > +	p = buf;
> > +	while (p < buf + tlen1)
> > +		sprintf(msg, "%s%02x", msg, (unsigned int)*p++);
> > +
> > +	if (tlen2 > 0) {
> > +		sprintf(msg, "%s .....", msg);
> > +		p = (buf+len) - tlen2;
> > +		while (p < buf + len)
> > +			sprintf(msg, "%s%02x", msg, (unsigned int)*p++);
> > +	}
> 
> This looks like it will overrun the msg buffer. It adds 2 bytes for
> every byte of data. It's also kind of sketchy code to sprintf into the
> same buffer you're reading from.
> 
> You could avoid all these problems by using print_hex_dump() instead.

Yes, we'll update it.

> > +static inline u32 is_tx_fifo_empty(struct ssp_driver_context *drv_context)
> 
> u32 ==> bool

Yes, we'll update it.

> > +	u32 sssr;
> > +	sssr = read_SSSR(drv_context->ioaddr);
> > +	if ((sssr & SSSR_TFL_MASK) || (sssr & SSSR_TNF) == 0)
> > +		return 0;
> > +	else
> > +		return 1;
> 
> or simply: return (sssr & (SSR_TFL_MASK || SSSR_TNF)) != 0;

Yes, that's better.

> ... Okay, so I just went looking for the read_SSSR() function because I
> wanted to know how it was defined. I just discovered that this driver is
> the same as drivers/spi/spi-pxa2xx.c with a PCI front end bolted on.
> 
> I'm not keen on having two separate drivers for the same logic block.

For SSP SPI driver, read_SSSR() is defined in spi-intel-mid-ssp.h:

#define DEFINE_SSP_REG(reg, off) \
static inline u32 read_##reg(void *p) { return __raw_readl(p + (off)); }
...
DEFINE_SSP_REG(SSSR, 0x08)

> > +	INIT_WORK(&drv_context->complete_work, int_transfer_complete_work);
> 
> Workqueue management is integrated into the core spi infrastructure now.
> SPI drivers should no longer be creating their own workqueues.
> 
> Instead, replace the ->transfer hook with prepare_transfer_hardware(),
> unprepare_transfer_hardware() and transfer_one_message(). See
> Documentation/spi/spi-summary for details.

OK, we'll change according to workqueue management.

> > +late_initcall(intel_mid_ssp_spi_init);
> 
> Why late_initcall()? module_init() should be sufficient. Or better yet
> replace the init and exit functions with module_pci_driver()

Yes, module_pci_driver() is good.

> As mentioned above, most if not all of the stuff in this file belongs in the .c.

Thanks for the detailed comments, we're updating per above comments,
after validation is done, we will resubmit patch for you review.



------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
