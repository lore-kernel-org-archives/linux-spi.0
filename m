From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH v2 2/6] spi: s3c64xx: move controller information into
 driver data
Date: Thu, 24 May 2012 14:13:36 +0530
Message-ID: <CAJuYYwR9GYcKCTLG3JanzQ2UzvqO9UW0Tdnj6p4WoHXb4hG9SA@mail.gmail.com>
References: <1337333613-6216-1-git-send-email-thomas.abraham@linaro.org>
	<1337333613-6216-3-git-send-email-thomas.abraham@linaro.org>
	<005a01cd397d$77f39600$67dac200$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spi-devel-general@lists.sourceforge.net,
	devicetree-discuss@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, rob.herring@calxeda.com,
	grant.likely@secretlab.ca, jaswinder.singh@linaro.org,
	broonie@opensource.wolfsonmicro.com,
	Kyoungil Kim <ki0351.kim@samsung.com>
To: Kukjin Kim <kgene.kim@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <005a01cd397d$77f39600$67dac200$%kim@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 24 May 2012 12:48, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Thomas Abraham wrote:
>>
>> Platform data is used to specify controller hardware specific inform=
ation
>> such as the tx/rx fifo level mask and bit offset of rx fifo level. S=
uch
>> information is not suitable to be supplied from device tree. Instead=
,
>> it can be moved into the driver data and removed from platform data.
>>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> Acked-by: Jaswinder Singh <jaswinder.singh@linaro.org>
>> ---
>> =A0arch/arm/mach-exynos/clock-exynos4.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 18 +-
>> =A0arch/arm/mach-exynos/setup-spi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| =A0 25 ---
>> =A0arch/arm/mach-s3c24xx/clock-s3c2416.c =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A02 +-
>> =A0arch/arm/mach-s3c24xx/clock-s3c2443.c =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A02 +-
>> =A0arch/arm/mach-s3c24xx/common-s3c2443.c =A0 =A0 =A0 =A0 =A0 | =A0 =
=A04 +-
>> =A0arch/arm/mach-s3c24xx/setup-spi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 =A08 -
>> =A0arch/arm/mach-s3c64xx/clock.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 20 ++--
>> =A0arch/arm/mach-s3c64xx/setup-spi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 13 --
>> =A0arch/arm/mach-s5p64x0/clock-s5p6440.c =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 12 +-
>> =A0arch/arm/mach-s5p64x0/clock-s5p6450.c =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 12 +-
>> =A0arch/arm/mach-s5p64x0/setup-spi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 16 --
>> =A0arch/arm/mach-s5pc100/clock.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 30 ++--
>> =A0arch/arm/mach-s5pc100/setup-spi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 22 ---
>> =A0arch/arm/mach-s5pv210/clock.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 14 +-
>> =A0arch/arm/mach-s5pv210/setup-spi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 15 --
>> =A0arch/arm/plat-samsung/include/plat/s3c64xx-spi.h | =A0 15 --
>> =A0drivers/spi/spi-s3c64xx.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0| =A0180
> ++++++++++++++++++----
>> =A017 files changed, 210 insertions(+), 198 deletions(-)
>>
> Basically, looks ok to me and there are small comments.
>
>> diff --git a/arch/arm/mach-exynos/clock-exynos4.c b/arch/arm/mach-
>> exynos/clock-exynos4.c
>> index bcb7db4..10a46a9 100644
>> --- a/arch/arm/mach-exynos/clock-exynos4.c
>> +++ b/arch/arm/mach-exynos/clock-exynos4.c
>> @@ -586,17 +586,17 @@ static struct clk exynos4_init_clocks_off[] =3D=
 {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ctrlbit =A0 =A0 =A0 =A0=3D (1 << 13),
>> =A0 =A0 =A0 }, {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "spi",
>> - =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D "s3c64xx-spi.0=
",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D "exynos4210-sp=
i.0",
>
> Please consider that this can be used only for exynos4210 or all of e=
xynos4
> Socs. We need to keep the consistency for the naming.

It is always easier to assign a specific device name such as
Exynos4210. Any other SoC in the Exynos4 family which has a exactly
similar SPI controller(s) as that of Exynos4210 can claim
compatibility to the Exynos4210 type by using Exynos4210 as the device
name.

Using generic name like Exynos4 as problems. If any one of the SoC's
in the Exynos4 family (present or upcoming) uses different properties
from that of Exynos4210 SPI controller (such as different tx/rx fifo
size, different bit positions in a register or new functionality),
then it can no more be classified as a Exynos4 compatible SPI
controller.

>
> [...]
>
>> diff --git a/arch/arm/mach-s3c24xx/clock-s3c2416.c b/arch/arm/mach-
>> s3c24xx/clock-s3c2416.c
>> index 8702ecf..a582ba1 100644
>> --- a/arch/arm/mach-s3c24xx/clock-s3c2416.c
>> +++ b/arch/arm/mach-s3c24xx/clock-s3c2416.c
>> @@ -144,7 +144,7 @@ static struct clk_lookup s3c2416_clk_lookup[] =3D=
 {
>> =A0 =A0 =A0 CLKDEV_INIT("s3c-sdhci.0", "mmc_busclk.0", &hsmmc0_clk),
>> =A0 =A0 =A0 CLKDEV_INIT("s3c-sdhci.0", "mmc_busclk.2", &hsmmc_mux0.c=
lk),
>> =A0 =A0 =A0 CLKDEV_INIT("s3c-sdhci.1", "mmc_busclk.2", &hsmmc_mux1.c=
lk),
>> - =A0 =A0 CLKDEV_INIT("s3c64xx-spi.0", "spi_busclk2", &hsspi_mux.clk=
),
>> + =A0 =A0 CLKDEV_INIT("s3c2443-spi.0", "spi_busclk2", &hsspi_mux.clk=
),
>
> I think, in this case, some comment helps to know that 's3c2443-spi' =
can
> support s3c2416/s3c2450 together.

Ok.

>
> [...]
>
>> diff --git a/arch/arm/mach-s5p64x0/clock-s5p6440.c b/arch/arm/mach-
>> s5p64x0/clock-s5p6440.c
>> index ee1e8e7..55ea3ab 100644
>> --- a/arch/arm/mach-s5p64x0/clock-s5p6440.c
>> +++ b/arch/arm/mach-s5p64x0/clock-s5p6440.c
>
> [...]
>
>> @@ -519,8 +519,8 @@ static struct clk_lookup s5p6440_clk_lookup[] =3D=
 {
>> =A0 =A0 =A0 CLKDEV_INIT(NULL, "clk_uart_baud2", &clk_pclk_low.clk),
>> =A0 =A0 =A0 CLKDEV_INIT(NULL, "clk_uart_baud3", &clk_sclk_uclk.clk),
>> =A0 =A0 =A0 CLKDEV_INIT(NULL, "spi_busclk0", &clk_p),
>> - =A0 =A0 CLKDEV_INIT("s3c64xx-spi.0", "spi_busclk1", &clk_sclk_spi0=
=2Eclk),
>> - =A0 =A0 CLKDEV_INIT("s3c64xx-spi.1", "spi_busclk1", &clk_sclk_spi1=
=2Eclk),
>> + =A0 =A0 CLKDEV_INIT("s5p64x0.0", "spi_busclk1", &clk_sclk_spi0.clk=
),
>> + =A0 =A0 CLKDEV_INIT("s5p64x0.1", "spi_busclk1", &clk_sclk_spi1.clk=
),
>
> Should be s5p64x0-spi.0 and s5p64x0-spi.1 ?

Yes, you are right. I will fix this.

>
> [...]
>
>> diff --git a/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
>> b/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
>> index fa95e9a..4e9b9c3 100644
>> --- a/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
>> +++ b/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
>
> [...]
>
>> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
>> index 6a3d51a..f6bc0e3 100644
>> --- a/drivers/spi/spi-s3c64xx.c
>> +++ b/drivers/spi/spi-s3c64xx.c
>> @@ -31,6 +31,8 @@
>> =A0#include <mach/dma.h>
>> =A0#include <plat/s3c64xx-spi.h>
>>
>> +#define MAX_SPI_PORTS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A03
>
> As you know, if spi_isp is used, this can be 5 for latest SoCs later.=
 Just
> note.

Ok.

>
> [...]
>
>> =A0/**
>> + * struct s3c64xx_spi_info - SPI Controller hardware info
>> + * @fifo_lvl_mask: Bit-mask for {TX|RX}_FIFO_LVL bits in SPI_STATUS
>> register.
>> + * @rx_lvl_offset: Bit offset of RX_FIFO_LVL bits in SPI_STATUS reg=
iter.
>> + * @tx_st_done: Bit offset of TX_DONE bit in SPI_STATUS regiter.
>> + * @high_speed: True, if the controller supports HIGH_SPEED_EN bit.
>> + * @clk_from_cmu: True, if the controller does not include a clock =
mux
>> and
>> + * =A0 prescaler unit.
>> + *
>> + * The Samsung s3c64xx SPI controller are used on various Samsung S=
oC's
>> but
>> + * differ in some aspects such as the size of the fifo and spi bus =
clock
>> + * setup. Such differences are specified to the driver using this
>> structure
>> + * which is provided as driver data to the driver.
>> + */
>> +struct s3c64xx_spi_port_config {
>> + =A0 =A0 int =A0 =A0 fifo_lvl_mask[MAX_SPI_PORTS];
>> + =A0 =A0 int =A0 =A0 rx_lvl_offset;
>> + =A0 =A0 int =A0 =A0 tx_st_done;
>> + =A0 =A0 bool =A0 =A0high_speed;
>> + =A0 =A0 bool =A0 =A0clk_from_cmu;
>> +};
>
> When I saw this, I thought this will be used for each SPI port. But I=
 know,
> above structure is used for each SoC not each SPI port. So I think, h=
ow
> about to change the structure name to avoid confusion?

The name of the above structure is following the existing name
conventions which the driver is using to name its structures.

>
> [...]
>
>> @@ -1000,6 +1029,7 @@ static int __init s3c64xx_spi_probe(struct
>> platform_device *pdev)
>> =A0 =A0 =A0 platform_set_drvdata(pdev, master);
>>
>> =A0 =A0 =A0 sdd =3D spi_master_get_devdata(master);
>> + =A0 =A0 sdd->port_conf =3D s3c64xx_spi_get_port_config(pdev);
>> =A0 =A0 =A0 sdd->master =3D master;
>> =A0 =A0 =A0 sdd->cntrlr_info =3D sci;
>> =A0 =A0 =A0 sdd->pdev =3D pdev;
>> @@ -1008,10 +1038,11 @@ static int __init s3c64xx_spi_probe(struct
>> platform_device *pdev)
>> =A0 =A0 =A0 sdd->tx_dma.direction =3D DMA_MEM_TO_DEV;
>> =A0 =A0 =A0 sdd->rx_dma.dmach =3D dmarx_res->start;
>> =A0 =A0 =A0 sdd->rx_dma.direction =3D DMA_DEV_TO_MEM;
>> + =A0 =A0 sdd->port_id =3D pdev->id;
>>
>> =A0 =A0 =A0 sdd->cur_bpw =3D 8;
>>
>> - =A0 =A0 master->bus_num =3D pdev->id;
>> + =A0 =A0 master->bus_num =3D sdd->port_id;
>
> [...]
>
>> @@ -1071,7 +1102,7 @@ static int __init s3c64xx_spi_probe(struct
>> platform_device *pdev)
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 /* Setup Deufult Mode */
>> - =A0 =A0 s3c64xx_spi_hwinit(sdd, pdev->id);
>> + =A0 =A0 s3c64xx_spi_hwinit(sdd, sdd->port_id);
>
> Do we need this change?

Yes, this change is required. In dt mode, the port_id is obtained from
the alias node (since pdev->id is not valid).

>
>>
>> =A0 =A0 =A0 spin_lock_init(&sdd->lock);
>> =A0 =A0 =A0 init_completion(&sdd->xfer_completion);
>> @@ -1096,7 +1127,7 @@ static int __init s3c64xx_spi_probe(struct
>> platform_device *pdev)
>>
>> =A0 =A0 =A0 dev_dbg(&pdev->dev, "Samsung SoC SPI Driver loaded for B=
us SPI-%d "
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 "with %d Slaves attached\n",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 pdev->id, master->num_chipselect);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 sdd->port_id,
> master->num_chipselect);
>
> Same as above.

Yes. This is required.

>
>> =A0 =A0 =A0 dev_dbg(&pdev->dev, "\tIOmem=3D[0x%x-0x%x]\tDMA=3D[Rx-%d=
, Tx-%d]\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 mem_res->end, mem_res->start,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 sdd->rx_dma.dmach,
> sdd->tx_dma.dmach);
>> @@ -1189,7 +1220,7 @@ static int s3c64xx_spi_resume(struct device *d=
ev)
>> =A0 =A0 =A0 clk_enable(sdd->src_clk);
>> =A0 =A0 =A0 clk_enable(sdd->clk);
>>
>> - =A0 =A0 s3c64xx_spi_hwinit(sdd, pdev->id);
>> + =A0 =A0 s3c64xx_spi_hwinit(sdd, sdd->port_id);
>
> Same as above.

Yes. This is required.

>
> [...]
>
>> +#ifdef CONFIG_ARCH_EXYNOS4
>> +struct s3c64xx_spi_port_config exynos4_spi_port_config =3D {
>
> Is this available on exynos4212/exynos4412? If not, this should be
> 'exynos4210_spi_port_config' and ifdef CONFIG_CPU_EXYNOS4210.
>
>> + =A0 =A0 .fifo_lvl_mask =A0=3D { 0x1ff, 0x7F, 0x7F },
>> + =A0 =A0 .rx_lvl_offset =A0=3D 15,
>> + =A0 =A0 .tx_st_done =A0 =A0 =3D 25,
>> + =A0 =A0 .high_speed =A0 =A0 =3D 1,
>> + =A0 =A0 .clk_from_cmu =A0 =3D true,
>> +};
>> +#define EXYNOS4_SPI_PORT_CONFIG
> ((kernel_ulong_t)&exynos4_spi_port_config)
>> +#else
>> +#define EXYNOS4_SPI_PORT_CONFIG ((kernel_ulong_t)NULL)
>> +#endif /* CONFIG_ARCH_EXYNOS4 */
>
> And let's think the name of ..._SPI_PORT_CONFIG again. How about just
> ..._SPI_CONFIG?

Ok. I will change it.

>
>> +
>> +static struct platform_device_id s3c64xx_spi_driver_ids[] =3D {
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "s3c2443-spi=
",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .driver_data =A0 =A0=3D S3C2443_SPI_PORT_C=
ONFIG,
>> + =A0 =A0 }, {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "s3c6410-spi=
",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .driver_data =A0 =A0=3D S3C6410_SPI_PORT_C=
ONFIG,
>> + =A0 =A0 }, {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "s5p64x0-spi=
",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .driver_data =A0 =A0=3D S5P64X0_SPI_PORT_C=
ONFIG,
>> + =A0 =A0 }, {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "s5pc100-spi=
",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .driver_data =A0 =A0=3D S5PC100_SPI_PORT_C=
ONFIG,
>> + =A0 =A0 }, {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "s5pv210-spi=
",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .driver_data =A0 =A0=3D S5PV210_SPI_PORT_C=
ONFIG,
>> + =A0 =A0 }, {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "exynos4210-=
spi",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .driver_data =A0 =A0=3D EXYNOS4_SPI_PORT_C=
ONFIG,
>
> As I commented, if this is only for exynos4210, EXYNOS4210_SPI_CONFIG=
 should
> be used here not EXYNOS4_SPI_.

Ok.

>
> [...]
>
> And I think, it's time to change the name of spi driver to spi-samsun=
g.c and
> samsung_spi as a prefix even though we have another s3c24xx spi drive=
r now.

Ok. It would be better to handle this change outside of this patch
series. This patch series is mainly about adding device tree support.

Thanks for your review and comments.

Regards,
Thomas.
