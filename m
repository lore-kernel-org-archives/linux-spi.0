From: Jan Andersson <jan-FkzTOoA/JUnLoDKTGw+V6w@public.gmane.org>
Subject: Re: [PATCH] spi: add support for aeroflex gaisler spimctrl
Date: Sat, 30 Apr 2011 15:09:15 +0200
Message-ID: <4DBC09FB.5070406@gaisler.se>
References: <1304023295-5829-1-git-send-email-jan@gaisler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1304023295-5829-1-git-send-email-jan-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
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

It seems something on my end ate your reply so I am replying to my own
message pasting in your reply from the archive.

Grant Likely wrote:
> On Thu, Apr 28, 2011 at 10:41:35PM +0200, Jan Andersson wrote:
>> This patch adds support for Aeroflex Gaisler SPI memory controller

[ .... ]

>>  drivers/spi/Kconfig       |    8 +
>>  drivers/spi/Makefile      |    1 +
>>  drivers/spi/ag_spimctrl.c |  354
> +++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 363 insertions(+), 0 deletions(-)
>>  create mode 100644 drivers/spi/ag_spimctrl.c
>>
>> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
>> index fc14b8d..a1846da 100644
>> --- a/drivers/spi/Kconfig
>> +++ b/drivers/spi/Kconfig
>> @@ -53,6 +53,14 @@ if SPI_MASTER
>>
>>  comment "SPI Master Controller Drivers"
>>
>> +config SPI_AG_SPIMCTRL
>> +	tristate "Aeroflex Gaisler SPI memory controller"
>> +        depends on SPARC_LEON
>
> inconsistent whitespace.  use tabs.
>

Fixed.

>> +	select SPI_BITBANG
>> +	help
>> +	  This is the driver for Aeroflex Gaisler's SPI memory controller
>> +	  (SPIMCTRL) found on some LEON/GRLIB SoCs.
>> +
>>  config SPI_ALTERA
>>  	tristate "Altera SPI Controller"
>>  	select SPI_BITBANG
>> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
>> index fd2fc5f..8a11a19 100644
>> --- a/drivers/spi/Makefile
>> +++ b/drivers/spi/Makefile
>> @@ -9,6 +9,7 @@ ccflags-$(CONFIG_SPI_DEBUG) := -DDEBUG
>>  obj-$(CONFIG_SPI_MASTER)		+= spi.o
>>
>>  # SPI master controller drivers (bus)
>> +obj-$(CONFIG_SPI_AG_SPIMCTRL)		+= ag_spimctrl.o
>>  obj-$(CONFIG_SPI_ALTERA)		+= spi_altera.o
>>  obj-$(CONFIG_SPI_ATMEL)			+= atmel_spi.o
>>  obj-$(CONFIG_SPI_ATH79)			+= ath79_spi.o
>> diff --git a/drivers/spi/ag_spimctrl.c b/drivers/spi/ag_spimctrl.c
>> new file mode 100644
>> index 0000000..022c1e8
>> --- /dev/null
>> +++ b/drivers/spi/ag_spimctrl.c
>> @@ -0,0 +1,354 @@
>> +/*

[ ... ]

>> +
>> +static int __devinit ag_spimctrl_probe(struct platform_device *pdev)
>> +{
>> +	struct ag_spimctrl *hw;
>> +	struct spi_master *master;
>> +	int err = -ENODEV;
>> +	u32 status;
>> +
>> +	master = spi_alloc_master(&pdev->dev, sizeof(struct ag_spimctrl));
>> +	if (!master)
>> +		return err;
>> +
>> +	/* setup the master state */
>> +	master->bus_num = pdev->id;
>> +	master->num_chipselect = AG_SPIM_NUMCS;
>> +	master->mode_bits = SPI_CS_HIGH;
>> +	master->setup = ag_spimctrl_setup;
>> +	master->cleanup = ag_spimctrl_cleanup;
>> +
>> +	hw = spi_master_get_devdata(master);
>> +	platform_set_drvdata(pdev, hw);
>> +
>> +	/* setup the state for the bitbang driver */
>> +	hw->bitbang.master = spi_master_get(master);
>> +	if (!hw->bitbang.master)
>> +		goto exit;
>> +	hw->bitbang.master->dev.of_node = pdev->dev.of_node;
>
> hw->bitbang.master->dev.of_node = of_node_get(pdev->dev.of_node);
>

Fixed.

>> +
>> +	hw->bitbang.setup_transfer = ag_spimctrl_setupxfer;
>> +	hw->bitbang.chipselect = ag_spimctrl_chipsel;
>> +	hw->bitbang.txrx_bufs = ag_spimctrl_txrx;
>> +
>> +	/* find and map our resources */
>> +	hw->base = of_ioremap(&pdev->resource[AG_SPIM_REGBANK], 0,
>
> Hmmm.  Will this device ever appear on anything other than a SPARC
machine?
> Using of_ioremap() makes the driver non-portable since only SPARC
> implements it.  An alternative would be devm_ioremap()
>

We will probably only see it on SPARC SoCs so I have left it as is for
now. Let me know if you want it changed.

>> +			resource_size(&pdev->resource[AG_SPIM_REGBANK]),
>> +			"ag-spimctrl regs");
>
> Instead of hardcoding the offset into the resource table, use
> platform_get_resource(), with the IORESOURCE_MEM flag.
>

Fixed

>> +	if (!hw->base) {
>> +		err = -EBUSY;
>> +		goto exit;
>> +	}
>> +
>> +	/* check current hw state. if controller is busy, leave it alone */
>> +	status = ag_spim_read(hw->base + AG_SPIM_STAT);
>> +	if (status & AG_SPIM_STAT_BUSY) {
>> +		err = -EBUSY;
>> +		goto exit_iounmap;
>> +	}
>> +
>> +	/* save control register value to keep settings */
>> +	hw->ctrl = ag_spim_read(hw->base + AG_SPIM_CTRL);
>> +
>> +	/* irq is optional */
>> +	hw->irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
>
> The irq should already be populated in the platform_device resource
> table.  You shouldn't need to call irq_of_parse_and_map().
>

I tried replacing the call with platform_get_irq() but did not get a
sensible value back. I am not familiar with how these structures get
populated. If I would follow how the irq is obtained in other drivers
for these SoCs I would have done: hw->irq = pdev->archdata.irqs[0];

I thought the call to irq_of_parse_and_map was cleaner, and the end
result is the same. If the use of irq_of_parse_and_map is not acceptable
I will need to dig deeper.

>> +	if (hw->irq != NO_IRQ) {
>> +		init_completion(&hw->done);
>> +		err = request_irq(hw->irq, ag_spimctrl_irq, 0, pdev->name, hw);
>> +		if (err)
>> +			goto exit_iounmap;
>> +		/* enable interrupt, written to hw below*/
>> +		hw->ctrl |= AG_SPIM_CTRL_IEN;
>> +	}
>> +
>> +	/* enter user mode so SPI comm. can be done via reg. interface */
>> +	if (!(hw->ctrl & AG_SPIM_CTRL_USRC)) {
>> +		hw->ctrl |= AG_SPIM_CTRL_USRC;
>> +		ag_spim_write(hw->ctrl, hw->base + AG_SPIM_CTRL);
>> +	}
>> +

[ ... ]

>> +	platform_set_drvdata(pdev, NULL);
>> +
>> +	return 0;
>> +}
>> +
>> +#ifdef CONFIG_OF
>> +static const struct of_device_id ag_spimctrl_of_match[] = {
>> +	{ .name = "GAISLER_SPIMCTRL",},
>> +	{ .name = "01_045",},
>
> Matching by name is deprecated and strongly discouraged.  You should
> match by compatible property.  See
> http://devicetree.org/Device_Tree_Usage for a description on how to
> use the compatible property.
>

Thanks for the link. GRLIB SoCs have one, or several, plug'n'play
area(s) that are scanned by the loader. Currently the device tree for
LEON/GRLIB SoCs is automatically generated at boot by a loader (quite
convenient as the same linux image will work on many systems without the
need for user intervention) that creates { .name = "<vendor id>_<device
id>",} entries based on the information in plug'n'play. Apparently the
machine generated tree does not comply to what is described in
Device_Tree_Usage.

It seem that to be compliant with Device_Tree_Usage, the loaders that
generate the device tree will need to be modified. I have not been
involved in that development but I can bring this up with the developers
on Monday.

Could you accept the current match table for now and when/if the loaders
are updated we can submit patches that fixes all our drivers that use {
.name = "<vendor>_<device>",}?

I will send a V2 should you consider the changes above to be acceptable.
In the V2 I will also add support for shared IRQs and after comments
from a colleague I have renamed the driver to be consistent with names
of other drivers for GRLIB SoCs.

Thank you very much for the review!

Best regards,
  Jan

------------------------------------------------------------------------------
WhatsUp Gold - Download Free Network Management Software
The most intuitive, comprehensive, and cost-effective network 
management toolset available today.  Delivers lowest initial 
acquisition cost and overall TCO of any competing solution.
http://p.sf.net/sfu/whatsupgold-sd
