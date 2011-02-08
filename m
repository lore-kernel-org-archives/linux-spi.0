From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2] davinci: spi: move event queue parameter to platform
	data
Date: Tue, 8 Feb 2011 15:04:46 -0700
Message-ID: <AANLkTimwdYr4riFtcd1JGwVYRKXtA+XSSgjBpF8eQSV2@mail.gmail.com>
References: <1297169995-31321-1-git-send-email-michael.williamson@criticallink.com>
	<87k4hakx29.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general@lists.sourceforge.net,
	davinci-linux-open-source@linux.davincidsp.com,
	Michael Williamson <michael.williamson@criticallink.com>,
	linux-arm-kernel@lists.infradead.org
To: Kevin Hilman <khilman@ti.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87k4hakx29.fsf@ti.com>
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

On Tue, Feb 8, 2011 at 2:58 PM, Kevin Hilman <khilman@ti.com> wrote:
> Michael Williamson <michael.williamson@criticallink.com> writes:
>
>> For DMA operation, the davinci spi driver needs an event queue number.
>> Currently, this number is passed as a IORESOURCE_DMA. =A0This is not
>> correct, as the event queue is not a DMA channel. =A0Pass the event queue
>> via the platform data structure instead.
>>
>> On dm355 and dm365, move the eventq assignment for spi0 out of resources
>> array and into platform data.
>>
>> Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
>> Acked-by: Sekhar Nori <nsekhar@ti.com>
>
> With Grant's ack, will merge this through davinci tree.

Acked-by: Grant Likely <grant.likely@secretlab.ca>

>
> Kevin
>
>> ---
>> Changes since v1:
>> =A0 =A0- Add Sekhar's Ack.
>> =A0 =A0- Really fix the typo. =A0This time for sure (blew the format pat=
ch
>> =A0 =A0 =A0on last go around).
>>
>> =A0arch/arm/mach-davinci/dm355.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A05 +----
>> =A0arch/arm/mach-davinci/dm365.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A05 +----
>> =A0arch/arm/mach-davinci/include/mach/spi.h | =A0 15 ++++++++++-----
>> =A0drivers/spi/davinci_spi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 11 +++=
--------
>> =A04 files changed, 15 insertions(+), 21 deletions(-)
>>
>> diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355=
.c
>> index a5f8a80..76364d1 100644
>> --- a/arch/arm/mach-davinci/dm355.c
>> +++ b/arch/arm/mach-davinci/dm355.c
>> @@ -403,16 +403,13 @@ static struct resource dm355_spi0_resources[] =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .start =3D 16,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =3D IORESOURCE_DMA,
>> =A0 =A0 =A0 },
>> - =A0 =A0 {
>> - =A0 =A0 =A0 =A0 =A0 =A0 .start =3D EVENTQ_1,
>> - =A0 =A0 =A0 =A0 =A0 =A0 .flags =3D IORESOURCE_DMA,
>> - =A0 =A0 },
>> =A0};
>>
>> =A0static struct davinci_spi_platform_data dm355_spi0_pdata =3D {
>> =A0 =A0 =A0 .version =A0 =A0 =A0 =A0=3D SPI_VERSION_1,
>> =A0 =A0 =A0 .num_chipselect =3D 2,
>> =A0 =A0 =A0 .cshold_bug =A0 =A0 =3D true,
>> + =A0 =A0 .dma_event_q =A0 =A0=3D EVENTQ_1,
>> =A0};
>> =A0static struct platform_device dm355_spi0_device =3D {
>> =A0 =A0 =A0 .name =3D "spi_davinci",
>> diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365=
.c
>> index 02d2cc3..4604e72 100644
>> --- a/arch/arm/mach-davinci/dm365.c
>> +++ b/arch/arm/mach-davinci/dm365.c
>> @@ -625,6 +625,7 @@ static u64 dm365_spi0_dma_mask =3D DMA_BIT_MASK(32);
>> =A0static struct davinci_spi_platform_data dm365_spi0_pdata =3D {
>> =A0 =A0 =A0 .version =A0 =A0 =A0 =A0=3D SPI_VERSION_1,
>> =A0 =A0 =A0 .num_chipselect =3D 2,
>> + =A0 =A0 .dma_event_q =A0 =A0=3D EVENTQ_3,
>> =A0};
>>
>> =A0static struct resource dm365_spi0_resources[] =3D {
>> @@ -645,10 +646,6 @@ static struct resource dm365_spi0_resources[] =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .start =3D 16,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =3D IORESOURCE_DMA,
>> =A0 =A0 =A0 },
>> - =A0 =A0 {
>> - =A0 =A0 =A0 =A0 =A0 =A0 .start =3D EVENTQ_3,
>> - =A0 =A0 =A0 =A0 =A0 =A0 .flags =3D IORESOURCE_DMA,
>> - =A0 =A0 },
>> =A0};
>>
>> =A0static struct platform_device dm365_spi0_device =3D {
>> diff --git a/arch/arm/mach-davinci/include/mach/spi.h b/arch/arm/mach-da=
vinci/include/mach/spi.h
>> index 38f4da5..7af305b 100644
>> --- a/arch/arm/mach-davinci/include/mach/spi.h
>> +++ b/arch/arm/mach-davinci/include/mach/spi.h
>> @@ -19,6 +19,8 @@
>> =A0#ifndef __ARCH_ARM_DAVINCI_SPI_H
>> =A0#define __ARCH_ARM_DAVINCI_SPI_H
>>
>> +#include <mach/edma.h>
>> +
>> =A0#define SPI_INTERN_CS =A0 =A0 =A0 =A00xFF
>>
>> =A0enum {
>> @@ -39,13 +41,16 @@ enum {
>> =A0 * =A0 =A0 =A0 =A0 =A0 to populate if all chip-selects are internal.
>> =A0 * @cshold_bug: =A0 =A0 =A0set this to true if the SPI controller on =
your chip requires
>> =A0 * =A0 =A0 =A0 =A0 =A0 a write to CSHOLD bit in between transfers (li=
ke in DM355).
>> + * @dma_event_q: DMA event queue to use if SPI_IO_TYPE_DMA is used for =
any
>> + * =A0 =A0 =A0 =A0 =A0 device on the bus.
>> =A0 */
>> =A0struct davinci_spi_platform_data {
>> - =A0 =A0 u8 =A0 =A0 =A0version;
>> - =A0 =A0 u8 =A0 =A0 =A0num_chipselect;
>> - =A0 =A0 u8 =A0 =A0 =A0intr_line;
>> - =A0 =A0 u8 =A0 =A0 =A0*chip_sel;
>> - =A0 =A0 bool =A0 =A0cshold_bug;
>> + =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0version;
>> + =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0num_chipselect;
>> + =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0intr_line;
>> + =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*chip_sel;
>> + =A0 =A0 bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cshold_bug;
>> + =A0 =A0 enum dma_event_q =A0 =A0 =A0 =A0dma_event_q;
>> =A0};
>>
>> =A0/**
>> diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
>> index 6beab99..166a879 100644
>> --- a/drivers/spi/davinci_spi.c
>> +++ b/drivers/spi/davinci_spi.c
>> @@ -790,7 +790,6 @@ static int davinci_spi_probe(struct platform_device =
*pdev)
>> =A0 =A0 =A0 struct resource *r, *mem;
>> =A0 =A0 =A0 resource_size_t dma_rx_chan =3D SPI_NO_RESOURCE;
>> =A0 =A0 =A0 resource_size_t dma_tx_chan =3D SPI_NO_RESOURCE;
>> - =A0 =A0 resource_size_t dma_eventq =3D SPI_NO_RESOURCE;
>> =A0 =A0 =A0 int i =3D 0, ret =3D 0;
>> =A0 =A0 =A0 u32 spipc0;
>>
>> @@ -878,17 +877,13 @@ static int davinci_spi_probe(struct platform_devic=
e *pdev)
>> =A0 =A0 =A0 r =3D platform_get_resource(pdev, IORESOURCE_DMA, 1);
>> =A0 =A0 =A0 if (r)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_tx_chan =3D r->start;
>> - =A0 =A0 r =3D platform_get_resource(pdev, IORESOURCE_DMA, 2);
>> - =A0 =A0 if (r)
>> - =A0 =A0 =A0 =A0 =A0 =A0 dma_eventq =3D r->start;
>>
>> =A0 =A0 =A0 dspi->bitbang.txrx_bufs =3D davinci_spi_bufs;
>> =A0 =A0 =A0 if (dma_rx_chan !=3D SPI_NO_RESOURCE &&
>> - =A0 =A0 =A0 =A0 dma_tx_chan !=3D SPI_NO_RESOURCE &&
>> - =A0 =A0 =A0 =A0 dma_eventq !=3D SPI_NO_RESOURCE) {
>> + =A0 =A0 =A0 =A0 dma_tx_chan !=3D SPI_NO_RESOURCE) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dspi->dma.rx_channel =3D dma_rx_chan;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dspi->dma.tx_channel =3D dma_tx_chan;
>> - =A0 =A0 =A0 =A0 =A0 =A0 dspi->dma.eventq =3D dma_eventq;
>> + =A0 =A0 =A0 =A0 =A0 =A0 dspi->dma.eventq =3D pdata->dma_event_q;
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D davinci_spi_request_dma(dspi);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
>> @@ -897,7 +892,7 @@ static int davinci_spi_probe(struct platform_device =
*pdev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(&pdev->dev, "DMA: supported\n");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(&pdev->dev, "DMA: RX channel: %d, T=
X channel: %d, "
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "event queue=
: %d\n", dma_rx_chan, dma_tx_chan,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_eventq);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->dma_eve=
nt_q);
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 dspi->get_rx =3D davinci_spi_rx_buf_u8;
>



-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
