From: Brian Niebuhr <bniebuhr3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 1/1] davinci: spi: replace
	existing driver
Date: Mon, 2 Aug 2010 09:10:29 -0500
Message-ID: <AANLkTim-FB6YrGSTmDQhmnS+Qw-dGm7D-pH7iCzy0-Td@mail.gmail.com>
References: <1280355490-11878-1-git-send-email-bniebuhr@efjohnson.com>
	<1280355490-11878-2-git-send-email-bniebuhr@efjohnson.com>
	<AANLkTimu+G-5wTrdQ6YiWi60i+5uN9sydfsZKMKQX7_f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <AANLkTimu+G-5wTrdQ6YiWi60i+5uN9sydfsZKMKQX7_f-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Grant -

That's fine - I understand your position.  I do wish you had decided
earlier that you weren't going to accept the patch in that form though
so I could have decided whether I wanted to spend any more time on it.
 For my part, I've already sunk way more time into this than I ever
intended, and I really have no clue how to break this patch down into
smaller patches.  I don't really care much if the patch gets accepted
or not - I am just trying to help out all of the other users that are
stuck with a broken driver like I was.  Maybe if TI wants to give
their customers a driver that actually works they'll pick it up and do
the rest of the work that's necessary to get it accepted.  I'm just
way too swamped with other work to keep going on this.

Thanks for your help though.  Sorry to waste all of the time you've
put into this.

Brian

On Sun, Aug 1, 2010 at 12:12 AM, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> w=
rote:
> On Wed, Jul 28, 2010 at 4:18 PM, Brian Niebuhr <bniebuhr3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrot=
e:
>> INTRODUCTION
>>
>> I have been working on a custom OMAP-L138 board that has multiple spi
>> devices (seven) on one controller. =A0These devices have a wide range of
>> transfer parameters (speed, phase, polarity, internal and gpio chip
>> selects). =A0During my testing I found multiple errors in the davinci spi
>> driver as a result of this complex setup. =A0The primary issues were:
>>
>> 1. There is a race condition due to the SPIBUF read busy-waits for slow
>> =A0 =A0 =A0 =A0devices
>> 2. I found some DMA transfer length errors under some conditions
>> 3. The chip select code caused extra byte transfers (with no chip
>> =A0 =A0 =A0 =A0select active) due to writes to SPIDAT1
>> 4. Several issues prevented using multiple SPI devices, especially
>> =A0 =A0 =A0 =A0the DMA code, as disucussed previously on the davinci lis=
t.
>>
>> The fixes to these problems were not simple. =A0I ended up making fairly
>> large changes to the driver, and those changes are contained in these
>> patches. =A0The full list of changes follows.
>>
>> CHANGE LIST
>>
>> 1. davinci_spi_chipelect() now performs both activation and deactivation
>> =A0 =A0 =A0 =A0of chip selects. =A0This lets spi_bitbang fully control c=
hip
>> =A0 =A0 =A0 =A0select activation, as intended by the SPI API.
>> 2. Chip select activation does not cause extra writes to the SPI bus
>> 3. Chip select activation does not use SPIDEF for control. =A0This change
>> =A0 =A0 =A0 =A0will also allow for implementation of inverted (active hi=
gh)
>> =A0 =A0 =A0 =A0chip selects in the future.
>> 4. Added back gpio chip select capability from the old driver
>> 5. Fixed prescale calculation for non-integer fractions of spi clock
>> 6. Allow specification of SPI transfer parameters on a per-device
>> =A0 =A0 =A0 =A0(instead of per-controller) basis
>> 7. Allow specification of polled, interrupt-based, or DMA operation on
>> =A0 =A0 =A0 =A0a per-device basis
>> 8. Allow DMA with when more than one device is connected
>> 9. Combined pio and dma txrx_bufs functions into one since they share
>> =A0 =A0 =A0 =A0large parts of their functionality, and to simplify item =
(8).
>> 10. Use only SPIFMT0 to allow more than 4 devices
>>
>> TESTING
>>
>> I have tested the driver using a custom SPI stress test on my
>> OMAP-L138-based board with three devices connected. =A0I have tested
>> configurations with all three devices polled, all three interrupt-based,
>> all three DMA, and a mixture.
>>
>> I have compiled with the davinci_all_defconfig, but I don't have EVMs
>> for the other davinci platforms to test with.
>>
>> Signed-off-by: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
>
> Hi Brian,
>
> I'm getting a little frustrated, and I wouldn't be surprised if you're
> getting a little frustrated too, but I cannot merge this as is. =A0It is
> just too big to be able to review sanely, when I know there are
> bite-size chunks that can be factored out into separate patches and
> can be merged independently.
>
> At a *bare minimum* I would need acks from several davinci users that
> it is tested and working before I'd merge something like this, but
> even then I'm not sure I would. =A0It certainly will not make me happy.
> It also means that when someone does have problems with the new driver
> over the old that they won't have a hope of bisecting it to figure out
> which change broken their system. =A0There will be less pain all around
> if you split it up instead.
>
> ...
>
> In fact, after taking another look at it, I insist. =A0I can tell that
> while major changes have been made, it is *still* the same driver with
> changes that can be logically identified. =A0Split it up.
>
> I'm more than happy to help you with the tools and techniques for
> splitting a single monolithic patch into logical changes if you've not
> done that before. =A0Send me a private email if you prefer.
>
> Comments below:
>
>> ---
>> =A0arch/arm/mach-davinci/board-dm355-evm.c =A0 =A0 | =A0 10 +
>> =A0arch/arm/mach-davinci/board-dm355-leopard.c | =A0 10 +
>> =A0arch/arm/mach-davinci/board-dm365-evm.c =A0 =A0 | =A0 10 +
>> =A0arch/arm/mach-davinci/dm355.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A08 =
+-
>> =A0arch/arm/mach-davinci/dm365.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A06 -
>> =A0arch/arm/mach-davinci/include/mach/spi.h =A0 =A0| =A0 35 +-
>> =A0drivers/spi/davinci_spi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | 1098 =
++++++++++++---------------
>> =A07 files changed, 521 insertions(+), 656 deletions(-)
>>
>> diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-dav=
inci/board-dm355-evm.c
>> index a319101..ad8779b 100644
>> --- a/arch/arm/mach-davinci/board-dm355-evm.c
>> +++ b/arch/arm/mach-davinci/board-dm355-evm.c
>> @@ -32,6 +32,7 @@
>> =A0#include <mach/nand.h>
>> =A0#include <mach/mmc.h>
>> =A0#include <mach/usb.h>
>> +#include <mach/spi.h>
>>
>> =A0/* NOTE: =A0this is geared for the standard config, with a socketed
>> =A0* 2 GByte Micron NAND (MT29F16G08FAA) using 128KB sectors. =A0If you
>> @@ -300,10 +301,19 @@ static struct spi_eeprom at25640a =3D {
>> =A0 =A0 =A0 =A0.flags =A0 =A0 =A0 =A0 =A0=3D EE_ADDR2,
>> =A0};
>>
>> +static struct davinci_spi_config at25640a_spi_cfg =3D {
>> + =A0 =A0 =A0 .parity_enable =A0=3D false,
>> + =A0 =A0 =A0 .intr_level =A0 =A0 =3D 0,
>> + =A0 =A0 =A0 .io_type =A0 =A0 =A0 =A0=3D SPI_IO_TYPE_DMA,
>> + =A0 =A0 =A0 .wdelay =A0 =A0 =A0 =A0 =3D 0,
>> + =A0 =A0 =A0 .timer_disable =A0=3D true,
>> +};
>> +
>> =A0static struct spi_board_info dm355_evm_spi_info[] __initconst =3D {
>> =A0 =A0 =A0 =A0{
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.modalias =A0 =A0 =A0 =3D "at25",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.platform_data =A0=3D &at25640a,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .controller_data =3D &at25640a_spi_cfg,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.max_speed_hz =A0 =3D 10 * 1000 * 1000, =
=A0 =A0 /* at 3v3 */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.bus_num =A0 =A0 =A0 =A0=3D 0,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.chip_select =A0 =A0=3D 0,
>> diff --git a/arch/arm/mach-davinci/board-dm355-leopard.c b/arch/arm/mach=
-davinci/board-dm355-leopard.c
>> index f1d8132..b2d8d48 100644
>> --- a/arch/arm/mach-davinci/board-dm355-leopard.c
>> +++ b/arch/arm/mach-davinci/board-dm355-leopard.c
>> @@ -29,6 +29,7 @@
>> =A0#include <mach/nand.h>
>> =A0#include <mach/mmc.h>
>> =A0#include <mach/usb.h>
>> +#include <mach/spi.h>
>>
>> =A0/* NOTE: =A0this is geared for the standard config, with a socketed
>> =A0* 2 GByte Micron NAND (MT29F16G08FAA) using 128KB sectors. =A0If you
>> @@ -222,10 +223,19 @@ static struct spi_eeprom at25640a =3D {
>> =A0 =A0 =A0 =A0.flags =A0 =A0 =A0 =A0 =A0=3D EE_ADDR2,
>> =A0};
>>
>> +static struct davinci_spi_config at25640a_spi_cfg =3D {
>> + =A0 =A0 =A0 .parity_enable =A0=3D false,
>> + =A0 =A0 =A0 .intr_level =A0 =A0 =3D 0,
>> + =A0 =A0 =A0 .io_type =A0 =A0 =A0 =A0=3D SPI_IO_TYPE_DMA,
>> + =A0 =A0 =A0 .wdelay =A0 =A0 =A0 =A0 =3D 0,
>> + =A0 =A0 =A0 .timer_disable =A0=3D true,
>> +};
>> +
>> =A0static struct spi_board_info dm355_leopard_spi_info[] __initconst =3D=
 {
>> =A0 =A0 =A0 =A0{
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.modalias =A0 =A0 =A0 =3D "at25",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.platform_data =A0=3D &at25640a,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .controller_data =3D &at25640a_spi_cfg,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.max_speed_hz =A0 =3D 10 * 1000 * 1000, =
=A0 =A0 /* at 3v3 */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.bus_num =A0 =A0 =A0 =A0=3D 0,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.chip_select =A0 =A0=3D 0,
>> diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-dav=
inci/board-dm365-evm.c
>> index 5bb86b2..db85372 100644
>> --- a/arch/arm/mach-davinci/board-dm365-evm.c
>> +++ b/arch/arm/mach-davinci/board-dm365-evm.c
>> @@ -39,6 +39,7 @@
>> =A0#include <mach/mmc.h>
>> =A0#include <mach/nand.h>
>> =A0#include <mach/keyscan.h>
>> +#include <mach/spi.h>
>>
>> =A0#include <media/tvp514x.h>
>>
>> @@ -579,10 +580,19 @@ static struct spi_eeprom at25640 =3D {
>> =A0 =A0 =A0 =A0.flags =A0 =A0 =A0 =A0 =A0=3D EE_ADDR2,
>> =A0};
>>
>> +static struct davinci_spi_config at25640_spi_cfg =3D {
>> + =A0 =A0 =A0 .parity_enable =A0=3D false,
>> + =A0 =A0 =A0 .intr_level =A0 =A0 =3D 0,
>> + =A0 =A0 =A0 .io_type =A0 =A0 =A0 =A0=3D SPI_IO_TYPE_DMA,
>> + =A0 =A0 =A0 .wdelay =A0 =A0 =A0 =A0 =3D 0,
>> + =A0 =A0 =A0 .timer_disable =A0=3D true,
>> +};
>> +
>> =A0static struct spi_board_info dm365_evm_spi_info[] __initconst =3D {
>> =A0 =A0 =A0 =A0{
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.modalias =A0 =A0 =A0 =3D "at25",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.platform_data =A0=3D &at25640,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .controller_data =3D &at25640_spi_cfg,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.max_speed_hz =A0 =3D 10 * 1000 * 1000,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.bus_num =A0 =A0 =A0 =A0=3D 0,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.chip_select =A0 =A0=3D 0,
>> diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355=
.c
>> index 3834781..b79b798 100644
>> --- a/arch/arm/mach-davinci/dm355.c
>> +++ b/arch/arm/mach-davinci/dm355.c
>> @@ -410,14 +410,8 @@ static struct resource dm355_spi0_resources[] =3D {
>> =A0};
>>
>> =A0static struct davinci_spi_platform_data dm355_spi0_pdata =3D {
>> - =A0 =A0 =A0 .version =A0 =A0 =A0 =A0=3D SPI_VERSION_1,
>> + =A0 =A0 =A0 .version =A0 =A0 =A0 =A0=3D SPI_VERSION_0,
>> =A0 =A0 =A0 =A0.num_chipselect =3D 2,
>> - =A0 =A0 =A0 .clk_internal =A0 =3D 1,
>> - =A0 =A0 =A0 .cs_hold =A0 =A0 =A0 =A0=3D 1,
>> - =A0 =A0 =A0 .intr_level =A0 =A0 =3D 0,
>> - =A0 =A0 =A0 .poll_mode =A0 =A0 =A0=3D 1, =A0 =A0/* 0 -> interrupt mode=
 1-> polling mode */
>> - =A0 =A0 =A0 .c2tdelay =A0 =A0 =A0 =3D 0,
>> - =A0 =A0 =A0 .t2cdelay =A0 =A0 =A0 =3D 0,
>> =A0};
>> =A0static struct platform_device dm355_spi0_device =3D {
>> =A0 =A0 =A0 =A0.name =3D "spi_davinci",
>> diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365=
.c
>> index 652f4b6..4aea346 100644
>> --- a/arch/arm/mach-davinci/dm365.c
>> +++ b/arch/arm/mach-davinci/dm365.c
>> @@ -625,12 +625,6 @@ static u64 dm365_spi0_dma_mask =3D DMA_BIT_MASK(32);
>> =A0static struct davinci_spi_platform_data dm365_spi0_pdata =3D {
>> =A0 =A0 =A0 =A0.version =A0 =A0 =A0 =A0=3D SPI_VERSION_1,
>> =A0 =A0 =A0 =A0.num_chipselect =3D 2,
>> - =A0 =A0 =A0 .clk_internal =A0 =3D 1,
>> - =A0 =A0 =A0 .cs_hold =A0 =A0 =A0 =A0=3D 1,
>> - =A0 =A0 =A0 .intr_level =A0 =A0 =3D 0,
>> - =A0 =A0 =A0 .poll_mode =A0 =A0 =A0=3D 1, =A0 =A0/* 0 -> interrupt mode=
 1-> polling mode */
>> - =A0 =A0 =A0 .c2tdelay =A0 =A0 =A0 =3D 0,
>> - =A0 =A0 =A0 .t2cdelay =A0 =A0 =A0 =3D 0,
>> =A0};
>>
>> =A0static struct resource dm365_spi0_resources[] =3D {
>> diff --git a/arch/arm/mach-davinci/include/mach/spi.h b/arch/arm/mach-da=
vinci/include/mach/spi.h
>> index 910efbf..3f77dab 100644
>> --- a/arch/arm/mach-davinci/include/mach/spi.h
>> +++ b/arch/arm/mach-davinci/include/mach/spi.h
>> @@ -19,26 +19,35 @@
>> =A0#ifndef __ARCH_ARM_DAVINCI_SPI_H
>> =A0#define __ARCH_ARM_DAVINCI_SPI_H
>>
>> +#define SPI_INTERN_CS =A00xFF
>> +
>> =A0enum {
>> - =A0 =A0 =A0 SPI_VERSION_1, /* For DM355/DM365/DM6467 */
>> + =A0 =A0 =A0 SPI_VERSION_0, /* For DM355 (reduced features, no Tx inter=
rupt) */
>> + =A0 =A0 =A0 SPI_VERSION_1, /* For DM365/DM6467 (reduced features) */
>> =A0 =A0 =A0 =A0SPI_VERSION_2, /* For DA8xx */
>> =A0};
>>
>> =A0struct davinci_spi_platform_data {
>> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0version;
>> - =A0 =A0 =A0 u8 =A0 =A0 =A0num_chipselect;
>> - =A0 =A0 =A0 u8 =A0 =A0 =A0wdelay;
>> - =A0 =A0 =A0 u8 =A0 =A0 =A0odd_parity;
>> - =A0 =A0 =A0 u8 =A0 =A0 =A0parity_enable;
>> - =A0 =A0 =A0 u8 =A0 =A0 =A0wait_enable;
>> - =A0 =A0 =A0 u8 =A0 =A0 =A0timer_disable;
>> - =A0 =A0 =A0 u8 =A0 =A0 =A0clk_internal;
>> - =A0 =A0 =A0 u8 =A0 =A0 =A0cs_hold;
>> + =A0 =A0 =A0 u16 =A0 =A0 num_chipselect;
>> + =A0 =A0 =A0 u8 =A0 =A0 =A0*chip_sel;
>> +};
>> +
>> +struct davinci_spi_config {
>> + =A0 =A0 =A0 bool =A0 =A0odd_parity;
>> + =A0 =A0 =A0 bool =A0 =A0parity_enable;
>> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0intr_level;
>> - =A0 =A0 =A0 u8 =A0 =A0 =A0poll_mode;
>> - =A0 =A0 =A0 u8 =A0 =A0 =A0use_dma;
>> - =A0 =A0 =A0 u8 =A0 =A0 =A0c2tdelay;
>> - =A0 =A0 =A0 u8 =A0 =A0 =A0t2cdelay;
>> + =A0 =A0 =A0 u8 =A0 =A0 =A0io_type;
>> +#define SPI_IO_TYPE_INTR =A0 =A00
>> +#define SPI_IO_TYPE_POLL =A0 =A01
>> +#define SPI_IO_TYPE_DMA =A0 =A0 2
>> + =A0 =A0 =A0 u8 =A0 =A0 =A0bytes_per_word;
>> + =A0 =A0 =A0 u8 =A0 =A0 =A0wdelay;
>> + =A0 =A0 =A0 bool =A0 =A0timer_disable;
>> + =A0 =A0 =A0 u8 =A0 =A0 =A0c2t_delay;
>> + =A0 =A0 =A0 u8 =A0 =A0 =A0t2c_delay;
>> + =A0 =A0 =A0 u8 =A0 =A0 =A0t2e_delay;
>> + =A0 =A0 =A0 u8 =A0 =A0 =A0c2e_delay;
>> =A0};
>>
>> =A0#endif /* __ARCH_ARM_DAVINCI_SPI_H */
>> diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
>> index b85090c..5c9e9ce 100644
>> --- a/drivers/spi/davinci_spi.c
>> +++ b/drivers/spi/davinci_spi.c
>> @@ -1,5 +1,6 @@
>> =A0/*
>> =A0* Copyright (C) 2009 Texas Instruments.
>> + * Copyright (C) 2010 EF Johnson Technologies
>> =A0*
>> =A0* This program is free software; you can redistribute it and/or modify
>> =A0* it under the terms of the GNU General Public License as published by
>> @@ -27,21 +28,19 @@
>> =A0#include <linux/dma-mapping.h>
>> =A0#include <linux/spi/spi.h>
>> =A0#include <linux/spi/spi_bitbang.h>
>> -#include <linux/slab.h>
>>
>> =A0#include <mach/spi.h>
>> =A0#include <mach/edma.h>
>>
>> =A0#define SPI_NO_RESOURCE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0((resource_siz=
e_t)-1)
>>
>> -#define SPI_MAX_CHIPSELECT =A0 =A0 2
>> -
>> =A0#define CS_DEFAULT =A0 =A0 0xFF
>>
>> =A0#define SPI_BUFSIZ =A0 =A0 (SMP_CACHE_BYTES + 1)
>> -#define DAVINCI_DMA_DATA_TYPE_S8 =A0 =A0 =A0 0x01
>> -#define DAVINCI_DMA_DATA_TYPE_S16 =A0 =A0 =A00x02
>> -#define DAVINCI_DMA_DATA_TYPE_S32 =A0 =A0 =A00x04
>> +
>> +#define RX_DMA_INDEX =A0 =A0 =A0 =A0 =A0 0
>> +#define TX_DMA_INDEX =A0 =A0 =A0 =A0 =A0 1
>> +#define EVENTQ_DMA_INDEX =A0 =A0 =A0 2
>>
>> =A0#define SPIFMT_PHASE_MASK =A0 =A0 =A0BIT(16)
>> =A0#define SPIFMT_POLARITY_MASK =A0 BIT(17)
>> @@ -53,9 +52,11 @@
>> =A0#define SPIFMT_WDELAY_MASK =A0 =A0 0x3f000000u
>> =A0#define SPIFMT_WDELAY_SHIFT =A0 =A024
>> =A0#define SPIFMT_CHARLEN_MASK =A0 =A00x0000001Fu
>> +#define SPIFMT_PRESCALE_SHIFT =A08
>>
>> =A0/* SPIGCR1 */
>> -#define SPIGCR1_SPIENA_MASK =A0 =A00x01000000u
>> +#define SPIGCR1_SPIENA_MASK =A0 =A0BIT(24)
>> +#define SPIGCR1_POWERDOWN_MASK BIT(8)
>>
>> =A0/* SPIPC0 */
>> =A0#define SPIPC0_DIFUN_MASK =A0 =A0 =A0BIT(11) =A0 =A0 =A0 =A0 /* MISO =
*/
>> @@ -66,20 +67,38 @@
>> =A0#define SPIPC0_EN0FUN_MASK =A0 =A0 BIT(0)
>>
>> =A0#define SPIINT_MASKALL =A0 =A0 =A0 =A0 0x0101035F
>> +#define SPIINT_MASKINT =A0 =A0 =A0 =A0 0x0000035F
>> =A0#define SPI_INTLVL_1 =A0 =A0 =A0 =A0 =A0 0x000001FFu
>> =A0#define SPI_INTLVL_0 =A0 =A0 =A0 =A0 =A0 0x00000000u
>>
>> =A0/* SPIDAT1 */
>> +#define SPIDAT1_CSHOLD_MASK =A0 =A0BIT(28)
>> =A0#define SPIDAT1_CSHOLD_SHIFT =A0 28
>> +#define SPIDAT1_WDEL_MASK =A0 =A0 =A0BIT(26)
>> +#define SPIDAT1_CSNR_MASK =A0 =A0 =A00x00FF0000u
>> =A0#define SPIDAT1_CSNR_SHIFT =A0 =A0 16
>> +#define SPIDAT1_DFSEL_MASK =A0 =A0 (BIT(24 | BIT(25))
>> =A0#define SPIGCR1_CLKMOD_MASK =A0 =A0BIT(1)
>> -#define SPIGCR1_MASTER_MASK =A0 =A0 BIT(0)
>> +#define SPIGCR1_MASTER_MASK =A0 =A0BIT(0)
>> =A0#define SPIGCR1_LOOPBACK_MASK =A0BIT(16)
>>
>> =A0/* SPIBUF */
>> =A0#define SPIBUF_TXFULL_MASK =A0 =A0 BIT(29)
>> =A0#define SPIBUF_RXEMPTY_MASK =A0 =A0BIT(31)
>>
>> +/* SPIDELAY */
>> +#define SPIDELAY_C2TDELAY_MASK =A00xFF000000u
>> +#define SPIDELAY_C2TDELAY_SHIFT 24
>> +#define SPIDELAY_T2CDELAY_MASK =A00x00FF0000u
>> +#define SPIDELAY_T2CDELAY_SHIFT 16
>> +#define SPIDELAY_T2EDELAY_MASK =A00x0000FF00u
>> +#define SPIDELAY_T2EDELAY_SHIFT 8
>> +#define SPIDELAY_C2EDELAY_MASK =A00x000000FFu
>> +#define SPIDELAY_C2EDELAY_SHIFT 0
>> +
>> +/* SPIDEF */
>> +#define SPIDEF_CSDEF_MASK =A0 =A0 =A0 0x000000FFu
>> +
>> =A0/* Error Masks */
>> =A0#define SPIFLG_DLEN_ERR_MASK =A0 =A0 =A0 =A0 =A0 BIT(0)
>> =A0#define SPIFLG_TIMEOUT_MASK =A0 =A0 =A0 =A0 =A0 =A0BIT(1)
>> @@ -90,11 +109,12 @@
>> =A0#define SPIFLG_RX_INTR_MASK =A0 =A0 =A0 =A0 =A0 =A0BIT(8)
>> =A0#define SPIFLG_TX_INTR_MASK =A0 =A0 =A0 =A0 =A0 =A0BIT(9)
>> =A0#define SPIFLG_BUF_INIT_ACTIVE_MASK =A0 =A0BIT(24)
>> -#define SPIFLG_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(SPIFLG_DLEN=
_ERR_MASK \
>> +#define SPIFLG_ERROR_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0(SPIFLG_DLEN_ERR_M=
ASK \
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| SPIFLG_=
TIMEOUT_MASK | SPIFLG_PARERR_MASK \
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| SPIFLG_=
DESYNC_MASK | SPIFLG_BITERR_MASK \
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | SPIFLG_O=
VRRUN_MASK | SPIFLG_RX_INTR_MASK \
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | SPIFLG_T=
X_INTR_MASK \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | SPIFLG_O=
VRRUN_MASK)
>> +#define SPIFLG_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(SPIFLG_ERRO=
R_MASK \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | SPIFLG_R=
X_INTR_MASK | SPIFLG_TX_INTR_MASK \
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| SPIFLG_=
BUF_INIT_ACTIVE_MASK)
>>
>> =A0#define SPIINT_DLEN_ERR_INTR =A0 BIT(0)
>> @@ -139,11 +159,10 @@
>> =A0#define TGINTVEC0 =A0 =A0 =A00x60
>> =A0#define TGINTVEC1 =A0 =A0 =A00x64
>>
>> -struct davinci_spi_slave {
>> - =A0 =A0 =A0 u32 =A0 =A0 cmd_to_write;
>> - =A0 =A0 =A0 u32 =A0 =A0 clk_ctrl_to_write;
>> - =A0 =A0 =A0 u32 =A0 =A0 bytes_per_word;
>> - =A0 =A0 =A0 u8 =A0 =A0 =A0active_cs;
>> +const char * const io_type_names[] =3D {
>> + =A0 =A0 =A0 [SPI_IO_TYPE_INTR] =3D "Interrupt",
>> + =A0 =A0 =A0 [SPI_IO_TYPE_POLL] =3D "Polled",
>> + =A0 =A0 =A0 [SPI_IO_TYPE_DMA] =3D "DMA",
>> =A0};
>>
>> =A0/* We have 2 DMA channels per CS, one for RX and one for TX */
>> @@ -152,10 +171,8 @@ struct davinci_spi_dma {
>> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_rx_channe=
l;
>> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_tx_sync_d=
ev;
>> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_rx_sync_d=
ev;
>> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dummy_param_sl=
ot;
>> =A0 =A0 =A0 =A0enum dma_event_q =A0 =A0 =A0 =A0eventq;
>> -
>> - =A0 =A0 =A0 struct completion =A0 =A0 =A0 dma_tx_completion;
>> - =A0 =A0 =A0 struct completion =A0 =A0 =A0 dma_rx_completion;
>> =A0};
>>
>> =A0/* SPI Controller driver's private data. */
>> @@ -173,51 +190,53 @@ struct davinci_spi {
>> =A0 =A0 =A0 =A0const void =A0 =A0 =A0 =A0 =A0 =A0 =A0*tx;
>> =A0 =A0 =A0 =A0void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*rx;
>> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*tmp_buf;
>> - =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 count;
>> - =A0 =A0 =A0 struct davinci_spi_dma =A0*dma_channels;
>> - =A0 =A0 =A0 struct =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0davinci_spi_plat=
form_data *pdata;
>> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rcount;
>> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wcount;
>> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 errors;
>> + =A0 =A0 =A0 struct davinci_spi_dma =A0dma_channels;
>> + =A0 =A0 =A0 struct davinci_spi_platform_data *pdata;
>>
>> =A0 =A0 =A0 =A0void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(*get_rx)(u32=
 rx_data, struct davinci_spi *);
>> =A0 =A0 =A0 =A0u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (*get_tx)(str=
uct davinci_spi *);
>> -
>> - =A0 =A0 =A0 struct davinci_spi_slave slave[SPI_MAX_CHIPSELECT];
>> =A0};
>>
>> -static unsigned use_dma;
>> -
>> =A0static void davinci_spi_rx_buf_u8(u32 data, struct davinci_spi *davin=
ci_spi)
>> =A0{
>> - =A0 =A0 =A0 u8 *rx =3D davinci_spi->rx;
>> -
>> - =A0 =A0 =A0 *rx++ =3D (u8)data;
>> - =A0 =A0 =A0 davinci_spi->rx =3D rx;
>> + =A0 =A0 =A0 if (davinci_spi->rx) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u8 *rx =3D davinci_spi->rx;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *rx++ =3D (u8)data;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->rx =3D rx;
>> + =A0 =A0 =A0 }
>> =A0}
>>
>> =A0static void davinci_spi_rx_buf_u16(u32 data, struct davinci_spi *davi=
nci_spi)
>> =A0{
>> - =A0 =A0 =A0 u16 *rx =3D davinci_spi->rx;
>> -
>> - =A0 =A0 =A0 *rx++ =3D (u16)data;
>> - =A0 =A0 =A0 davinci_spi->rx =3D rx;
>> + =A0 =A0 =A0 if (davinci_spi->rx) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u16 *rx =3D davinci_spi->rx;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *rx++ =3D (u16)data;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->rx =3D rx;
>> + =A0 =A0 =A0 }
>> =A0}
>>
>> =A0static u32 davinci_spi_tx_buf_u8(struct davinci_spi *davinci_spi)
>> =A0{
>> - =A0 =A0 =A0 u32 data;
>> - =A0 =A0 =A0 const u8 *tx =3D davinci_spi->tx;
>> -
>> - =A0 =A0 =A0 data =3D *tx++;
>> - =A0 =A0 =A0 davinci_spi->tx =3D tx;
>> + =A0 =A0 =A0 u32 data =3D 0;
>> + =A0 =A0 =A0 if (davinci_spi->tx) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 const u8 *tx =3D davinci_spi->tx;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data =3D *tx++;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->tx =3D tx;
>> + =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0return data;
>> =A0}
>
> Here's an excellent candidate for a separate patch. =A0Validation of the
> rx/tx buffer before transfering data to/from it.
>
>>
>> =A0static u32 davinci_spi_tx_buf_u16(struct davinci_spi *davinci_spi)
>> =A0{
>> - =A0 =A0 =A0 u32 data;
>> - =A0 =A0 =A0 const u16 *tx =3D davinci_spi->tx;
>> -
>> - =A0 =A0 =A0 data =3D *tx++;
>> - =A0 =A0 =A0 davinci_spi->tx =3D tx;
>> + =A0 =A0 =A0 u32 data =3D 0;
>> + =A0 =A0 =A0 if (davinci_spi->tx) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 const u16 *tx =3D davinci_spi->tx;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data =3D *tx++;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->tx =3D tx;
>> + =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0return data;
>> =A0}
>>
>> @@ -237,26 +256,6 @@ static inline void clear_io_bits(void __iomem *addr=
, u32 bits)
>> =A0 =A0 =A0 =A0iowrite32(v, addr);
>> =A0}
>>
>> -static inline void set_fmt_bits(void __iomem *addr, u32 bits, int cs_nu=
m)
>> -{
>> - =A0 =A0 =A0 set_io_bits(addr + SPIFMT0 + (0x4 * cs_num), bits);
>> -}
>> -
>> -static inline void clear_fmt_bits(void __iomem *addr, u32 bits, int cs_=
num)
>> -{
>> - =A0 =A0 =A0 clear_io_bits(addr + SPIFMT0 + (0x4 * cs_num), bits);
>> -}
>> -
>> -static void davinci_spi_set_dma_req(const struct spi_device *spi, int e=
nable)
>> -{
>> - =A0 =A0 =A0 struct davinci_spi *davinci_spi =3D spi_master_get_devdata=
(spi->master);
>> -
>> - =A0 =A0 =A0 if (enable)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_io_bits(davinci_spi->base + SPIINT, SP=
IINT_DMA_REQ_EN);
>> - =A0 =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 clear_io_bits(davinci_spi->base + SPIINT, =
SPIINT_DMA_REQ_EN);
>> -}
>> -
>> =A0/*
>> =A0* Interface to control the chip select signal
>> =A0*/
>> @@ -264,25 +263,54 @@ static void davinci_spi_chipselect(struct spi_devi=
ce *spi, int value)
>> =A0{
>> =A0 =A0 =A0 =A0struct davinci_spi *davinci_spi;
>> =A0 =A0 =A0 =A0struct davinci_spi_platform_data *pdata;
>> - =A0 =A0 =A0 u32 data1_reg_val =3D 0;
>> + =A0 =A0 =A0 u8 i, chip_sel =3D spi->chip_select;
>> + =A0 =A0 =A0 u32 spidat1;
>> + =A0 =A0 =A0 u16 spidat1_cfg;
>>
>> =A0 =A0 =A0 =A0davinci_spi =3D spi_master_get_devdata(spi->master);
>> =A0 =A0 =A0 =A0pdata =3D davinci_spi->pdata;
>>
>> - =A0 =A0 =A0 /*
>> - =A0 =A0 =A0 =A0* Board specific chip select logic decides the polarity=
 and cs
>> - =A0 =A0 =A0 =A0* line for the controller
>> - =A0 =A0 =A0 =A0*/
>> - =A0 =A0 =A0 if (value =3D=3D BITBANG_CS_INACTIVE) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_io_bits(davinci_spi->base + SPIDEF, CS=
_DEFAULT);
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 data1_reg_val |=3D CS_DEFAULT << SPIDAT1_C=
SNR_SHIFT;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite32(data1_reg_val, davinci_spi->base=
 + SPIDAT1);
>> + =A0 =A0 =A0 spidat1 =3D SPIDAT1_CSNR_MASK;
>> + =A0 =A0 =A0 if (value =3D=3D BITBANG_CS_ACTIVE)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spidat1 |=3D SPIDAT1_CSHOLD_MASK;
>> + =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spidat1 |=3D SPIDAT1_WDEL_MASK;
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 while ((ioread32(davinci_spi->base + SPIBU=
F)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 & SPIBUF_RXEMPTY_MASK) =3D=3D 0)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax();
>> + =A0 =A0 =A0 if (pdata->chip_sel =3D=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (value =3D=3D BITBANG_CS_ACTIVE)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spidat1 &=3D ~((0x1 << chi=
p_sel) << SPIDAT1_CSNR_SHIFT);
>> + =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < pdata->num_chipselect; i=
++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pdata->chip_sel[i] =3D=
=3D SPI_INTERN_CS) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((i =3D=
=3D chip_sel) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (v=
alue =3D=3D BITBANG_CS_ACTIVE)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 spidat1 &=3D ~((0x1 << chip_sel)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 << SPIDAT1_CSNR_SHIFT);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (value =
=3D=3D BITBANG_CS_INACTIVE)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 gpio_set_value(pdata->chip_sel[i], 1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (i=
 =3D=3D chip_sel)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 gpio_set_value(pdata->chip_sel[i], 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0}
>> +
>> + =A0 =A0 =A0 spidat1_cfg =3D spidat1 >> SPIDAT1_CSNR_SHIFT;
>> + =A0 =A0 =A0 iowrite16(spidat1_cfg, davinci_spi->base + SPIDAT1 + 2);
>> +}
>> +
>> +/**
>> + * davinci_spi_get_prescale - Calculates the correct prescale value
>> + * @max_speed_hz: the maximum rate the SPI clock can run at
>> + *
>> + * This function calculates the prescale value that generates a clock r=
ate
>> + * less than or equal to the specified maximum
>> + */
>> +static inline u32 davinci_spi_get_prescale(struct davinci_spi *davinci_=
spi,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 u32 max_speed_hz)
>> +{
>> + =A0 =A0 =A0 return ((clk_get_rate(davinci_spi->clk) - 1) / max_speed_h=
z) & 0xff;
>> =A0}
>>
>> =A0/**
>> @@ -297,14 +325,15 @@ static void davinci_spi_chipselect(struct spi_devi=
ce *spi, int value)
>> =A0static int davinci_spi_setup_transfer(struct spi_device *spi,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct spi_transfer *t)
>> =A0{
>> -
>> =A0 =A0 =A0 =A0struct davinci_spi *davinci_spi;
>> =A0 =A0 =A0 =A0struct davinci_spi_platform_data *pdata;
>> + =A0 =A0 =A0 struct davinci_spi_config *spi_cfg;
>> =A0 =A0 =A0 =A0u8 bits_per_word =3D 0;
>> - =A0 =A0 =A0 u32 hz =3D 0, prescale =3D 0, clkspeed;
>> + =A0 =A0 =A0 u32 hz =3D 0, spifmt =3D 0, prescale, delay =3D 0;
>>
>> =A0 =A0 =A0 =A0davinci_spi =3D spi_master_get_devdata(spi->master);
>> =A0 =A0 =A0 =A0pdata =3D davinci_spi->pdata;
>> + =A0 =A0 =A0 spi_cfg =3D spi->controller_data;
>>
>> =A0 =A0 =A0 =A0if (t) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bits_per_word =3D t->bits_per_word;
>> @@ -322,76 +351,112 @@ static int davinci_spi_setup_transfer(struct spi_=
device *spi,
>> =A0 =A0 =A0 =A0if (bits_per_word <=3D 8 && bits_per_word >=3D 2) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0davinci_spi->get_rx =3D davinci_spi_rx_bu=
f_u8;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0davinci_spi->get_tx =3D davinci_spi_tx_bu=
f_u8;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->slave[spi->chip_select].bytes=
_per_word =3D 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi_cfg->bytes_per_word =3D 1;
>> =A0 =A0 =A0 =A0} else if (bits_per_word <=3D 16 && bits_per_word >=3D 2)=
 {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0davinci_spi->get_rx =3D davinci_spi_rx_bu=
f_u16;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0davinci_spi->get_tx =3D davinci_spi_tx_bu=
f_u16;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->slave[spi->chip_select].bytes=
_per_word =3D 2;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi_cfg->bytes_per_word =3D 2;
>> =A0 =A0 =A0 =A0} else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>>
>> =A0 =A0 =A0 =A0if (!hz)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hz =3D spi->max_speed_hz;
>>
>> - =A0 =A0 =A0 clear_fmt_bits(davinci_spi->base, SPIFMT_CHARLEN_MASK,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi->chip_select);
>> - =A0 =A0 =A0 set_fmt_bits(davinci_spi->base, bits_per_word & 0x1f,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi->chip_select);
>> + =A0 =A0 =A0 prescale =3D davinci_spi_get_prescale(davinci_spi, hz);
>> + =A0 =A0 =A0 spifmt |=3D (prescale << SPIFMT_PRESCALE_SHIFT);
>> +
>> + =A0 =A0 =A0 spifmt |=3D (bits_per_word & 0x1f);
>> +
>> + =A0 =A0 =A0 if (spi->mode & SPI_LSB_FIRST)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spifmt |=3D SPIFMT_SHIFTDIR_MASK;
>> +
>> + =A0 =A0 =A0 if (spi->mode & SPI_CPOL)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spifmt |=3D SPIFMT_POLARITY_MASK;
>> +
>> + =A0 =A0 =A0 if (!(spi->mode & SPI_CPHA))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spifmt |=3D SPIFMT_PHASE_MASK;
>> +
>> + =A0 =A0 =A0 if (davinci_spi->version =3D=3D SPI_VERSION_2) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spifmt |=3D ((spi_cfg->wdelay << SPIFMT_WD=
ELAY_SHIFT)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & SPIFMT_W=
DELAY_MASK);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (spi_cfg->odd_parity)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spifmt |=3D SPIFMT_ODD_PAR=
ITY_MASK;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (spi_cfg->parity_enable)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spifmt |=3D SPIFMT_PARITYE=
NA_MASK;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (spi->mode & SPI_READY) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spifmt |=3D SPIFMT_WAITENA=
_MASK;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 delay |=3D (spi_cfg->t2e_d=
elay
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 << SPIDELAY_T2EDELAY_SHIFT)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 & SPIDELAY_T2EDELAY_MASK;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 delay |=3D (spi_cfg->c2e_d=
elay
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 << SPIDELAY_C2EDELAY_SHIFT)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 & SPIDELAY_C2EDELAY_MASK;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (spi_cfg->timer_disable) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spifmt |=3D SPIFMT_DISTIME=
R_MASK;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 delay |=3D (spi_cfg->c2t_d=
elay
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 << SPIDELAY_C2TDELAY_SHIFT)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 & SPIDELAY_C2TDELAY_MASK;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 delay |=3D (spi_cfg->t2c_d=
elay
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 << SPIDELAY_T2CDELAY_SHIFT)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 & SPIDELAY_T2CDELAY_MASK;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>
>> - =A0 =A0 =A0 clkspeed =3D clk_get_rate(davinci_spi->clk);
>> - =A0 =A0 =A0 if (hz > clkspeed / 2)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 prescale =3D 1 << 8;
>> - =A0 =A0 =A0 if (hz < clkspeed / 256)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 prescale =3D 255 << 8;
>> - =A0 =A0 =A0 if (!prescale)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 prescale =3D ((clkspeed / hz - 1) << 8) & =
0x0000ff00;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite32(delay, davinci_spi->base + SPIDE=
LAY);
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 iowrite32(spifmt, davinci_spi->base + SPIFMT0);
>>
>> - =A0 =A0 =A0 clear_fmt_bits(davinci_spi->base, 0x0000ff00, spi->chip_se=
lect);
>> - =A0 =A0 =A0 set_fmt_bits(davinci_spi->base, prescale, spi->chip_select=
);
>> + =A0 =A0 =A0 if (spi_cfg->intr_level)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite32(SPI_INTLVL_1, davinci_spi->base =
+ SPILVL);
>> + =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite32(SPI_INTLVL_0, davinci_spi->base =
+ SPILVL);
>> +
>> + =A0 =A0 =A0 if (spi->mode & SPI_LOOP)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_io_bits(davinci_spi->base + SPIGCR1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SPIGCR1_LO=
OPBACK_MASK);
>> + =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clear_io_bits(davinci_spi->base + SPIGCR1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SPIGCR1_LO=
OPBACK_MASK);
>>
>> =A0 =A0 =A0 =A0return 0;
>> =A0}
>>
>> =A0static void davinci_spi_dma_rx_callback(unsigned lch, u16 ch_status, =
void *data)
>> =A0{
>> - =A0 =A0 =A0 struct spi_device *spi =3D (struct spi_device *)data;
>> - =A0 =A0 =A0 struct davinci_spi *davinci_spi;
>> + =A0 =A0 =A0 struct davinci_spi *davinci_spi =3D data;
>> =A0 =A0 =A0 =A0struct davinci_spi_dma *davinci_spi_dma;
>> =A0 =A0 =A0 =A0struct davinci_spi_platform_data *pdata;
>>
>> - =A0 =A0 =A0 davinci_spi =3D spi_master_get_devdata(spi->master);
>> - =A0 =A0 =A0 davinci_spi_dma =3D &(davinci_spi->dma_channels[spi->chip_=
select]);
>> + =A0 =A0 =A0 davinci_spi_dma =3D &(davinci_spi->dma_channels);
>> =A0 =A0 =A0 =A0pdata =3D davinci_spi->pdata;
>>
>> + =A0 =A0 =A0 edma_stop(davinci_spi_dma->dma_rx_channel);
>> +
>> =A0 =A0 =A0 =A0if (ch_status =3D=3D DMA_COMPLETE)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 edma_stop(davinci_spi_dma->dma_rx_channel);
>> - =A0 =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 edma_clean_channel(davinci_spi_dma->dma_rx=
_channel);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->rcount =3D 0;
>>
>> - =A0 =A0 =A0 complete(&davinci_spi_dma->dma_rx_completion);
>> - =A0 =A0 =A0 /* We must disable the DMA RX request */
>> - =A0 =A0 =A0 davinci_spi_set_dma_req(spi, 0);
>> + =A0 =A0 =A0 complete(&davinci_spi->done);
>> =A0}
>>
>> =A0static void davinci_spi_dma_tx_callback(unsigned lch, u16 ch_status, =
void *data)
>> =A0{
>> - =A0 =A0 =A0 struct spi_device *spi =3D (struct spi_device *)data;
>> - =A0 =A0 =A0 struct davinci_spi *davinci_spi;
>> + =A0 =A0 =A0 struct davinci_spi *davinci_spi =3D data;
>> =A0 =A0 =A0 =A0struct davinci_spi_dma *davinci_spi_dma;
>> =A0 =A0 =A0 =A0struct davinci_spi_platform_data *pdata;
>>
>> - =A0 =A0 =A0 davinci_spi =3D spi_master_get_devdata(spi->master);
>> - =A0 =A0 =A0 davinci_spi_dma =3D &(davinci_spi->dma_channels[spi->chip_=
select]);
>> + =A0 =A0 =A0 davinci_spi_dma =3D &(davinci_spi->dma_channels);
>> =A0 =A0 =A0 =A0pdata =3D davinci_spi->pdata;
>>
>> - =A0 =A0 =A0 if (ch_status =3D=3D DMA_COMPLETE)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 edma_stop(davinci_spi_dma->dma_tx_channel);
>> - =A0 =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 edma_clean_channel(davinci_spi_dma->dma_tx=
_channel);
>> + =A0 =A0 =A0 edma_stop(davinci_spi_dma->dma_tx_channel);
>>
>> - =A0 =A0 =A0 complete(&davinci_spi_dma->dma_tx_completion);
>> - =A0 =A0 =A0 /* We must disable the DMA TX request */
>> - =A0 =A0 =A0 davinci_spi_set_dma_req(spi, 0);
>> + =A0 =A0 =A0 if (ch_status =3D=3D DMA_COMPLETE)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->wcount =3D 0;
>> =A0}
>>
>> =A0static int davinci_spi_request_dma(struct spi_device *spi)
>> @@ -403,30 +468,51 @@ static int davinci_spi_request_dma(struct spi_devi=
ce *spi)
>> =A0 =A0 =A0 =A0int r;
>>
>> =A0 =A0 =A0 =A0davinci_spi =3D spi_master_get_devdata(spi->master);
>> - =A0 =A0 =A0 davinci_spi_dma =3D &davinci_spi->dma_channels[spi->chip_s=
elect];
>> + =A0 =A0 =A0 davinci_spi_dma =3D &davinci_spi->dma_channels;
>> =A0 =A0 =A0 =A0pdata =3D davinci_spi->pdata;
>> =A0 =A0 =A0 =A0sdev =3D davinci_spi->bitbang.master->dev.parent;
>>
>> =A0 =A0 =A0 =A0r =3D edma_alloc_channel(davinci_spi_dma->dma_rx_sync_dev,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_sp=
i_dma_rx_callback, spi,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_sp=
i_dma_rx_callback, davinci_spi,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0davinci_s=
pi_dma->eventq);
>> =A0 =A0 =A0 =A0if (r < 0) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(sdev, "Unable to request DMA chann=
el for SPI RX\n");
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EAGAIN;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(sdev, "Unable to request DMA chann=
el for MibSPI RX\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D =A0-EAGAIN;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto rx_dma_failed;
>> =A0 =A0 =A0 =A0}
>> =A0 =A0 =A0 =A0davinci_spi_dma->dma_rx_channel =3D r;
>> +
>> =A0 =A0 =A0 =A0r =3D edma_alloc_channel(davinci_spi_dma->dma_tx_sync_dev,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_sp=
i_dma_tx_callback, spi,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_sp=
i_dma_tx_callback, davinci_spi,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0davinci_s=
pi_dma->eventq);
>> =A0 =A0 =A0 =A0if (r < 0) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 edma_free_channel(davinci_spi_dma->dma_rx_=
channel);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi_dma->dma_rx_channel =3D -1;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(sdev, "Unable to request DMA chann=
el for SPI TX\n");
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EAGAIN;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(sdev, "Unable to request DMA chann=
el for MibSPI TX\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D -EAGAIN;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto tx_dma_failed;
>> =A0 =A0 =A0 =A0}
>> =A0 =A0 =A0 =A0davinci_spi_dma->dma_tx_channel =3D r;
>>
>> + =A0 =A0 =A0 r =3D edma_alloc_slot(EDMA_CTLR(davinci_spi_dma->dma_tx_sy=
nc_dev),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EDMA_SLOT_=
ANY);
>> + =A0 =A0 =A0 if (r < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(sdev, "Unable to request SPI DMA p=
aram slot\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D -EAGAIN;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto param_failed;
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 davinci_spi_dma->dummy_param_slot =3D r;
>> + =A0 =A0 =A0 edma_link(davinci_spi_dma->dummy_param_slot,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi_dma->dummy_param_slot);
>> +
>> =A0 =A0 =A0 =A0return 0;
>> +
>> +param_failed:
>> + =A0 =A0 =A0 edma_free_channel(davinci_spi_dma->dma_tx_channel);
>> + =A0 =A0 =A0 davinci_spi_dma->dma_tx_channel =3D -1;
>> +tx_dma_failed:
>> + =A0 =A0 =A0 edma_free_channel(davinci_spi_dma->dma_rx_channel);
>> + =A0 =A0 =A0 davinci_spi_dma->dma_rx_channel =3D -1;
>> +rx_dma_failed:
>> + =A0 =A0 =A0 return r;
>> =A0}
>>
>> =A0/**
>> @@ -438,129 +524,54 @@ static int davinci_spi_request_dma(struct spi_dev=
ice *spi)
>>
>> =A0static int davinci_spi_setup(struct spi_device *spi)
>> =A0{
>> - =A0 =A0 =A0 int retval;
>> + =A0 =A0 =A0 int retval =3D 0;
>> =A0 =A0 =A0 =A0struct davinci_spi *davinci_spi;
>> - =A0 =A0 =A0 struct davinci_spi_dma *davinci_spi_dma;
>> - =A0 =A0 =A0 struct device *sdev;
>> + =A0 =A0 =A0 struct davinci_spi_dma *davinci_dma;
>> + =A0 =A0 =A0 struct davinci_spi_platform_data *pdata;
>> + =A0 =A0 =A0 struct davinci_spi_config *spi_cfg;
>> + =A0 =A0 =A0 u32 prescale;
>>
>> =A0 =A0 =A0 =A0davinci_spi =3D spi_master_get_devdata(spi->master);
>> - =A0 =A0 =A0 sdev =3D davinci_spi->bitbang.master->dev.parent;
>> + =A0 =A0 =A0 pdata =3D davinci_spi->pdata;
>> + =A0 =A0 =A0 spi_cfg =3D (struct davinci_spi_config *)spi->controller_d=
ata;
>> + =A0 =A0 =A0 davinci_dma =3D &(davinci_spi->dma_channels);
>>
>> =A0 =A0 =A0 =A0/* if bits per word length is zero then set it default 8 =
*/
>> =A0 =A0 =A0 =A0if (!spi->bits_per_word)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spi->bits_per_word =3D 8;
>>
>> - =A0 =A0 =A0 davinci_spi->slave[spi->chip_select].cmd_to_write =3D 0;
>> + =A0 =A0 =A0 if (!(spi->mode & SPI_NO_CS)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((pdata->chip_sel =3D=3D NULL) ||
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (pdata->chip_sel[spi->chip_select]=
 =3D=3D SPI_INTERN_CS))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_io_bits(davinci_spi->b=
ase + SPIPC0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 1 << spi->chip_select);
>>
>> - =A0 =A0 =A0 if (use_dma && davinci_spi->dma_channels) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi_dma =3D &davinci_spi->dma_chan=
nels[spi->chip_select];
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((davinci_spi_dma->dma_rx_channel =3D=
=3D -1)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 || (davinc=
i_spi_dma->dma_tx_channel =3D=3D -1)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D davinci_spi_req=
uest_dma(spi);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (retval < 0)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret=
val;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 /*
>> - =A0 =A0 =A0 =A0* SPI in DaVinci and DA8xx operate between
>> - =A0 =A0 =A0 =A0* 600 KHz and 50 MHz
>> - =A0 =A0 =A0 =A0*/
>> - =A0 =A0 =A0 if (spi->max_speed_hz < 600000 || spi->max_speed_hz > 5000=
0000) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(sdev, "Operating frequency is not =
in acceptable "
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "range\n");
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> =A0 =A0 =A0 =A0}
>>
>> - =A0 =A0 =A0 /*
>> - =A0 =A0 =A0 =A0* Set up SPIFMTn register, unique to this chipselect.
>> - =A0 =A0 =A0 =A0*
>> - =A0 =A0 =A0 =A0* NOTE: we could do all of these with one write. =A0Als=
o, some
>> - =A0 =A0 =A0 =A0* of the "version 2" features are found in chips that d=
on't
>> - =A0 =A0 =A0 =A0* support all of them...
>> - =A0 =A0 =A0 =A0*/
>> - =A0 =A0 =A0 if (spi->mode & SPI_LSB_FIRST)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_fmt_bits(davinci_spi->base, SPIFMT_SHI=
FTDIR_MASK,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi->chip_=
select);
>> - =A0 =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 clear_fmt_bits(davinci_spi->base, SPIFMT_S=
HIFTDIR_MASK,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi->chip_=
select);
>> + =A0 =A0 =A0 if (spi->mode & SPI_READY)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_io_bits(davinci_spi->base + SPIPC0, SP=
IPC0_SPIENA_MASK);
>>
>> - =A0 =A0 =A0 if (spi->mode & SPI_CPOL)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_fmt_bits(davinci_spi->base, SPIFMT_POL=
ARITY_MASK,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi->chip_=
select);
>> - =A0 =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 clear_fmt_bits(davinci_spi->base, SPIFMT_P=
OLARITY_MASK,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi->chip_=
select);
>> + =A0 =A0 =A0 if (spi_cfg->io_type =3D=3D SPI_IO_TYPE_DMA) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_dma =3D &(davinci_spi->dma_channel=
s);
>>
>> - =A0 =A0 =A0 if (!(spi->mode & SPI_CPHA))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_fmt_bits(davinci_spi->base, SPIFMT_PHA=
SE_MASK,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi->chip_=
select);
>> - =A0 =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 clear_fmt_bits(davinci_spi->base, SPIFMT_P=
HASE_MASK,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi->chip_=
select);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((davinci_dma->dma_tx_sync_dev =3D=3D S=
PI_NO_RESOURCE) ||
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (davinci_dma->dma_rx_sync_dev =3D=
=3D SPI_NO_RESOURCE) ||
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (davinci_dma->eventq =3D=3D SPI_NO=
_RESOURCE))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi_cfg->io_type =3D SPI_I=
O_TYPE_INTR;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if ((davinci_dma->dma_rx_channel =3D=
=3D -1) ||
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(davinci_dma->dma_tx_ch=
annel =3D=3D -1))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D davinci_spi_req=
uest_dma(spi);
>> + =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 =A0/*
>> - =A0 =A0 =A0 =A0* Version 1 hardware supports two basic SPI modes:
>> - =A0 =A0 =A0 =A0* =A0- Standard SPI mode uses 4 pins, with chipselect
>> - =A0 =A0 =A0 =A0* =A0- 3 pin SPI is a 4 pin variant without CS (SPI_NO_=
CS)
>> - =A0 =A0 =A0 =A0* =A0 =A0 =A0(distinct from SPI_3WIRE, with just one da=
ta wire;
>> - =A0 =A0 =A0 =A0* =A0 =A0 =A0or similar variants without MOSI or withou=
t MISO)
>> - =A0 =A0 =A0 =A0*
>> - =A0 =A0 =A0 =A0* Version 2 hardware supports an optional handshaking s=
ignal,
>> - =A0 =A0 =A0 =A0* so it can support two more modes:
>> - =A0 =A0 =A0 =A0* =A0- 5 pin SPI variant is standard SPI plus SPI_READY
>> - =A0 =A0 =A0 =A0* =A0- 4 pin with enable is (SPI_READY | SPI_NO_CS)
>> + =A0 =A0 =A0 =A0* Validate desired clock rate
>> =A0 =A0 =A0 =A0 */
>> + =A0 =A0 =A0 prescale =3D davinci_spi_get_prescale(davinci_spi, spi->ma=
x_speed_hz);
>> + =A0 =A0 =A0 if ((prescale < 2) || (prescale > 255))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>>
>> - =A0 =A0 =A0 if (davinci_spi->version =3D=3D SPI_VERSION_2) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 clear_fmt_bits(davinci_spi->base, SPIFMT_W=
DELAY_MASK,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi->chip_=
select);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_fmt_bits(davinci_spi->base,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (davinci_s=
pi->pdata->wdelay
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 << SPIFMT_WDELAY_SHIFT)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 & SPIFMT_WDELAY_MASK,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi->chip_=
select);
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (davinci_spi->pdata->odd_parity)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_fmt_bits(davinci_spi->=
base,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 SPIFMT_ODD_PARITY_MASK,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 spi->chip_select);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clear_fmt_bits(davinci_spi=
->base,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 SPIFMT_ODD_PARITY_MASK,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 spi->chip_select);
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (davinci_spi->pdata->parity_enable)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_fmt_bits(davinci_spi->=
base,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 SPIFMT_PARITYENA_MASK,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 spi->chip_select);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clear_fmt_bits(davinci_spi=
->base,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 SPIFMT_PARITYENA_MASK,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 spi->chip_select);
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (davinci_spi->pdata->wait_enable)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_fmt_bits(davinci_spi->=
base,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 SPIFMT_WAITENA_MASK,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 spi->chip_select);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clear_fmt_bits(davinci_spi=
->base,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 SPIFMT_WAITENA_MASK,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 spi->chip_select);
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (davinci_spi->pdata->timer_disable)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_fmt_bits(davinci_spi->=
base,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 SPIFMT_DISTIMER_MASK,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 spi->chip_select);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clear_fmt_bits(davinci_spi=
->base,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 SPIFMT_DISTIMER_MASK,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 spi->chip_select);
>> - =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 retval =3D davinci_spi_setup_transfer(spi, NULL);
>> + =A0 =A0 =A0 dev_info(&spi->dev, "DaVinci SPI driver in %s mode\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 io_type_names[spi_cfg->io_=
type]);
>>
>> =A0 =A0 =A0 =A0return retval;
>> =A0}
>> @@ -569,50 +580,19 @@ static void davinci_spi_cleanup(struct spi_device =
*spi)
>> =A0{
>> =A0 =A0 =A0 =A0struct davinci_spi *davinci_spi =3D spi_master_get_devdat=
a(spi->master);
>> =A0 =A0 =A0 =A0struct davinci_spi_dma *davinci_spi_dma;
>> + =A0 =A0 =A0 struct davinci_spi_platform_data *pdata;
>>
>> - =A0 =A0 =A0 davinci_spi_dma =3D &davinci_spi->dma_channels[spi->chip_s=
elect];
>> -
>> - =A0 =A0 =A0 if (use_dma && davinci_spi->dma_channels) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi_dma =3D &davinci_spi->dma_chan=
nels[spi->chip_select];
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((davinci_spi_dma->dma_rx_channel !=3D =
-1)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && (davinc=
i_spi_dma->dma_tx_channel !=3D -1)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 edma_free_channel(davinci_=
spi_dma->dma_tx_channel);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 edma_free_channel(davinci_=
spi_dma->dma_rx_channel);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 }
>> -}
>> -
>> -static int davinci_spi_bufs_prep(struct spi_device *spi,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct =
davinci_spi *davinci_spi)
>> -{
>> - =A0 =A0 =A0 int op_mode =3D 0;
>> -
>> - =A0 =A0 =A0 /*
>> - =A0 =A0 =A0 =A0* REVISIT =A0unless devices disagree about SPI_LOOP or
>> - =A0 =A0 =A0 =A0* SPI_READY (SPI_NO_CS only allows one device!), this
>> - =A0 =A0 =A0 =A0* should not need to be done before each message...
>> - =A0 =A0 =A0 =A0* optimize for both flags staying cleared.
>> - =A0 =A0 =A0 =A0*/
>> -
>> - =A0 =A0 =A0 op_mode =3D SPIPC0_DIFUN_MASK
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 | SPIPC0_DOFUN_MASK
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 | SPIPC0_CLKFUN_MASK;
>> - =A0 =A0 =A0 if (!(spi->mode & SPI_NO_CS))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 op_mode |=3D 1 << spi->chip_select;
>> - =A0 =A0 =A0 if (spi->mode & SPI_READY)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 op_mode |=3D SPIPC0_SPIENA_MASK;
>> + =A0 =A0 =A0 davinci_spi_dma =3D &davinci_spi->dma_channels;
>> + =A0 =A0 =A0 pdata =3D davinci_spi->pdata;
>>
>> - =A0 =A0 =A0 iowrite32(op_mode, davinci_spi->base + SPIPC0);
>> + =A0 =A0 =A0 if (davinci_spi_dma->dma_rx_channel !=3D -1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 edma_free_channel(davinci_spi_dma->dma_rx_=
channel);
>>
>> - =A0 =A0 =A0 if (spi->mode & SPI_LOOP)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_io_bits(davinci_spi->base + SPIGCR1,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SPIGCR1_LO=
OPBACK_MASK);
>> - =A0 =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 clear_io_bits(davinci_spi->base + SPIGCR1,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SPIGCR1_LO=
OPBACK_MASK);
>> + =A0 =A0 =A0 if (davinci_spi_dma->dma_tx_channel !=3D -1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 edma_free_channel(davinci_spi_dma->dma_tx_=
channel);
>>
>> - =A0 =A0 =A0 return 0;
>> + =A0 =A0 =A0 if (davinci_spi_dma->dummy_param_slot !=3D -1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 edma_free_slot(davinci_spi_dma->dummy_para=
m_slot);
>> =A0}
>>
>> =A0static int davinci_spi_check_error(struct davinci_spi *davinci_spi,
>> @@ -660,355 +640,242 @@ static int davinci_spi_check_error(struct davinc=
i_spi *davinci_spi,
>> =A0}
>>
>> =A0/**
>> - * davinci_spi_bufs - functions which will handle transfer data
>> - * @spi: spi device on which data transfer to be done
>> - * @t: spi transfer in which transfer info is filled
>> + * davinci_spi_process_events - check for and handle any SPI controller=
 events
>> + * @davinci_spi: the controller data
>> =A0*
>> - * This function will put data to be transferred into data register
>> - * of SPI controller and then wait until the completion will be marked
>> - * by the IRQ Handler.
>> + * This function will check the SPIFLG register and handle any events t=
hat are
>> + * detected there
>> =A0*/
>> -static int davinci_spi_bufs_pio(struct spi_device *spi, struct spi_tran=
sfer *t)
>> +static int davinci_spi_process_events(struct davinci_spi *davinci_spi)
>> =A0{
>> - =A0 =A0 =A0 struct davinci_spi *davinci_spi;
>> - =A0 =A0 =A0 int int_status, count, ret;
>> - =A0 =A0 =A0 u8 conv, tmp;
>> - =A0 =A0 =A0 u32 tx_data, data1_reg_val;
>> - =A0 =A0 =A0 u32 buf_val, flg_val;
>> - =A0 =A0 =A0 struct davinci_spi_platform_data *pdata;
>> -
>> - =A0 =A0 =A0 davinci_spi =3D spi_master_get_devdata(spi->master);
>> - =A0 =A0 =A0 pdata =3D davinci_spi->pdata;
>> -
>> - =A0 =A0 =A0 davinci_spi->tx =3D t->tx_buf;
>> - =A0 =A0 =A0 davinci_spi->rx =3D t->rx_buf;
>> -
>> - =A0 =A0 =A0 /* convert len to words based on bits_per_word */
>> - =A0 =A0 =A0 conv =3D davinci_spi->slave[spi->chip_select].bytes_per_wo=
rd;
>> - =A0 =A0 =A0 davinci_spi->count =3D t->len / conv;
>> -
>> - =A0 =A0 =A0 INIT_COMPLETION(davinci_spi->done);
>> -
>> - =A0 =A0 =A0 ret =3D davinci_spi_bufs_prep(spi, davinci_spi);
>> - =A0 =A0 =A0 if (ret)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> -
>> - =A0 =A0 =A0 /* Enable SPI */
>> - =A0 =A0 =A0 set_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_SPIENA_MA=
SK);
>> -
>> - =A0 =A0 =A0 iowrite32(0 | (pdata->c2tdelay << SPI_C2TDELAY_SHIFT) |
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (pdata->t2cdelay << SPI_T2=
CDELAY_SHIFT),
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->base + SPIDEL=
AY);
>> -
>> - =A0 =A0 =A0 count =3D davinci_spi->count;
>> - =A0 =A0 =A0 data1_reg_val =3D pdata->cs_hold << SPIDAT1_CSHOLD_SHIFT;
>> - =A0 =A0 =A0 tmp =3D ~(0x1 << spi->chip_select);
>> -
>> - =A0 =A0 =A0 clear_io_bits(davinci_spi->base + SPIDEF, ~tmp);
>> -
>> - =A0 =A0 =A0 data1_reg_val |=3D tmp << SPIDAT1_CSNR_SHIFT;
>> -
>> - =A0 =A0 =A0 while ((ioread32(davinci_spi->base + SPIBUF)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & SPIBUF_R=
XEMPTY_MASK) =3D=3D 0)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax();
>> -
>> - =A0 =A0 =A0 /* Determine the command to execute READ or WRITE */
>> - =A0 =A0 =A0 if (t->tx_buf) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 clear_io_bits(davinci_spi->base + SPIINT, =
SPIINT_MASKALL);
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (1) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_data =3D davinci_spi->g=
et_tx(davinci_spi);
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data1_reg_val &=3D ~(0xFFF=
F);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data1_reg_val |=3D (0xFFFF=
 & tx_data);
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf_val =3D ioread32(davin=
ci_spi->base + SPIBUF);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((buf_val & SPIBUF_TXFU=
LL_MASK) =3D=3D 0) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite32(=
data1_reg_val,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->base + SPIDAT1);
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 count--;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (ioread32(davinci_sp=
i->base + SPIBUF)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 & SPIBUF_RXEMPTY_MASK)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax(=
);
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* getting the returned by=
te */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (t->rx_buf) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf_val =
=3D ioread32(davinci_spi->base + SPIBUF);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_sp=
i->get_rx(buf_val, davinci_spi);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (count <=3D 0)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 } else {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pdata->poll_mode) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (1) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* keeps t=
he serial clock going */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((iorea=
d32(davinci_spi->base + SPIBUF)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 & SPIBUF_TXFULL_MASK) =3D=3D 0)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 iowrite32(data1_reg_val,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->base + SPIDAT1);
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (ior=
ead32(davinci_spi->base + SPIBUF) &
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 SPIBUF_RXEMPTY_MASK)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 cpu_relax();
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flg_val =
=3D ioread32(davinci_spi->base + SPIFLG);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf_val =
=3D ioread32(davinci_spi->base + SPIBUF);
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_sp=
i->get_rx(buf_val, davinci_spi);
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 count--;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (count =
<=3D 0)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 break;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else { =A0 =A0 =A0 =A0/* Receive in Inte=
rrupt mode */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int i;
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < davinci_=
spi->count; i++) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_io_bit=
s(davinci_spi->base + SPIINT,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 SPIINT_BITERR_INTR
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 | SPIINT_OVRRUN_INTR
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 | SPIINT_RX_INTR);
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite32(=
data1_reg_val,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->base + SPIDAT1);
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (ior=
ead32(davinci_spi->base + SPIINT) &
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 SPIINT_RX_INTR)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 cpu_relax();
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite32((data1_reg_val &=
 0x0ffcffff),
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 davinci_spi->base + SPIDAT1);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 u32 status, tx_data, rx_data, spidat1;
>> + =A0 =A0 =A0 u8 tx_word =3D 0;
>> +
>> + =A0 =A0 =A0 status =3D ioread32(davinci_spi->base + SPIFLG);
>> +
>> + =A0 =A0 =A0 if ((davinci_spi->version !=3D SPI_VERSION_0) &&
>> + =A0 =A0 =A0 =A0 =A0 (likely(status & SPIFLG_TX_INTR_MASK)) &&
>> + =A0 =A0 =A0 =A0 =A0 (likely(davinci_spi->wcount > 0)))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_word =3D 1;
>> +
>> + =A0 =A0 =A0 if (likely(status & SPIFLG_RX_INTR_MASK)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_data =3D ioread32(davinci_spi->base + S=
PIBUF) & 0xFFFF;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->get_rx(rx_data, davinci_spi);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->rcount--;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((davinci_spi->version =3D=3D SPI_VERSI=
ON_0) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (likely(davinci_spi->wcount > 0)))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_word =3D 1;
>> =A0 =A0 =A0 =A0}
>>
>> - =A0 =A0 =A0 /*
>> - =A0 =A0 =A0 =A0* Check for bit error, desync error,parity error,timeou=
t error and
>> - =A0 =A0 =A0 =A0* receive overflow errors
>> - =A0 =A0 =A0 =A0*/
>> - =A0 =A0 =A0 int_status =3D ioread32(davinci_spi->base + SPIFLG);
>> -
>> - =A0 =A0 =A0 ret =3D davinci_spi_check_error(davinci_spi, int_status);
>> - =A0 =A0 =A0 if (ret !=3D 0)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 =A0 if (unlikely(status & SPIFLG_ERROR_MASK)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->errors =3D (status & SPIFLG_E=
RROR_MASK);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>> + =A0 =A0 =A0 }
>>
>> - =A0 =A0 =A0 /* SPI Framework maintains the count only in bytes so conv=
ert back */
>> - =A0 =A0 =A0 davinci_spi->count *=3D conv;
>> + =A0 =A0 =A0 if (likely(tx_word)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spidat1 =3D ioread32(davinci_spi->base + S=
PIDAT1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->wcount--;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_data =3D davinci_spi->get_tx(davinci_sp=
i);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spidat1 &=3D 0xFFFF0000;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spidat1 |=3D (tx_data & 0xFFFF);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite32(spidat1, davinci_spi->base + SPI=
DAT1);
>> + =A0 =A0 =A0 }
>>
>> - =A0 =A0 =A0 return t->len;
>> + =A0 =A0 =A0 return 0;
>> =A0}
>>
>> -#define DAVINCI_DMA_DATA_TYPE_S8 =A0 =A0 =A0 0x01
>> -#define DAVINCI_DMA_DATA_TYPE_S16 =A0 =A0 =A00x02
>> -#define DAVINCI_DMA_DATA_TYPE_S32 =A0 =A0 =A00x04
>> -
>> -static int davinci_spi_bufs_dma(struct spi_device *spi, struct spi_tran=
sfer *t)
>> +/**
>> + * davinci_spi_txrx_bufs - function which will handle transfer data
>> + * @spi: spi device on which data transfer to be done
>> + * @t: spi transfer in which transfer info is filled
>> + *
>> + * This function will put data to be transferred into data register
>> + * of SPI controller and then wait until the completion will be marked
>> + * by the IRQ Handler.
>> + */
>> +static int davinci_spi_txrx_bufs(struct spi_device *spi, struct spi_tra=
nsfer *t)
>> =A0{
>> =A0 =A0 =A0 =A0struct davinci_spi *davinci_spi;
>> - =A0 =A0 =A0 int int_status =3D 0;
>> - =A0 =A0 =A0 int count, temp_count;
>> - =A0 =A0 =A0 u8 conv =3D 1;
>> - =A0 =A0 =A0 u8 tmp;
>> - =A0 =A0 =A0 u32 data1_reg_val;
>> - =A0 =A0 =A0 struct davinci_spi_dma *davinci_spi_dma;
>> - =A0 =A0 =A0 int word_len, data_type, ret;
>> - =A0 =A0 =A0 unsigned long tx_reg, rx_reg;
>> + =A0 =A0 =A0 int data_type, ret =3D 0;
>> + =A0 =A0 =A0 u32 tx_data, spidat1;
>> + =A0 =A0 =A0 u16 tx_buf_count =3D 0, rx_buf_count =3D 0;
>> + =A0 =A0 =A0 struct davinci_spi_config *spi_cfg;
>> =A0 =A0 =A0 =A0struct davinci_spi_platform_data *pdata;
>> + =A0 =A0 =A0 struct davinci_spi_dma *davinci_dma;
>> =A0 =A0 =A0 =A0struct device *sdev;
>> + =A0 =A0 =A0 dma_addr_t tx_reg, rx_reg;
>> + =A0 =A0 =A0 void *tx_buf, *rx_buf;
>> + =A0 =A0 =A0 struct edmacc_param rx_param, tx_param;
>>
>> =A0 =A0 =A0 =A0davinci_spi =3D spi_master_get_devdata(spi->master);
>> =A0 =A0 =A0 =A0pdata =3D davinci_spi->pdata;
>> - =A0 =A0 =A0 sdev =3D davinci_spi->bitbang.master->dev.parent;
>> -
>> - =A0 =A0 =A0 davinci_spi_dma =3D &davinci_spi->dma_channels[spi->chip_s=
elect];
>> -
>> - =A0 =A0 =A0 tx_reg =3D (unsigned long)davinci_spi->pbase + SPIDAT1;
>> - =A0 =A0 =A0 rx_reg =3D (unsigned long)davinci_spi->pbase + SPIBUF;
>> + =A0 =A0 =A0 spi_cfg =3D (struct davinci_spi_config *)spi->controller_d=
ata;
>> + =A0 =A0 =A0 davinci_dma =3D &(davinci_spi->dma_channels);
>>
>> =A0 =A0 =A0 =A0davinci_spi->tx =3D t->tx_buf;
>> =A0 =A0 =A0 =A0davinci_spi->rx =3D t->rx_buf;
>> + =A0 =A0 =A0 davinci_spi->wcount =3D t->len / spi_cfg->bytes_per_word;
>> + =A0 =A0 =A0 davinci_spi->rcount =3D davinci_spi->wcount;
>> + =A0 =A0 =A0 davinci_spi->errors =3D 0;
>>
>> - =A0 =A0 =A0 /* convert len to words based on bits_per_word */
>> - =A0 =A0 =A0 conv =3D davinci_spi->slave[spi->chip_select].bytes_per_wo=
rd;
>> - =A0 =A0 =A0 davinci_spi->count =3D t->len / conv;
>> + =A0 =A0 =A0 spidat1 =3D ioread32(davinci_spi->base + SPIDAT1);
>>
>> - =A0 =A0 =A0 INIT_COMPLETION(davinci_spi->done);
>> -
>> - =A0 =A0 =A0 init_completion(&davinci_spi_dma->dma_rx_completion);
>> - =A0 =A0 =A0 init_completion(&davinci_spi_dma->dma_tx_completion);
>> -
>> - =A0 =A0 =A0 word_len =3D conv * 8;
>> -
>> - =A0 =A0 =A0 if (word_len <=3D 8)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 data_type =3D DAVINCI_DMA_DATA_TYPE_S8;
>> - =A0 =A0 =A0 else if (word_len <=3D 16)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 data_type =3D DAVINCI_DMA_DATA_TYPE_S16;
>> - =A0 =A0 =A0 else if (word_len <=3D 32)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 data_type =3D DAVINCI_DMA_DATA_TYPE_S32;
>> - =A0 =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> -
>> - =A0 =A0 =A0 ret =3D davinci_spi_bufs_prep(spi, davinci_spi);
>> - =A0 =A0 =A0 if (ret)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> -
>> - =A0 =A0 =A0 /* Put delay val if required */
>> - =A0 =A0 =A0 iowrite32(0 | (pdata->c2tdelay << SPI_C2TDELAY_SHIFT) |
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (pdata->t2cdelay << SPI_T2=
CDELAY_SHIFT),
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->base + SPIDEL=
AY);
>> -
>> - =A0 =A0 =A0 count =3D davinci_spi->count; =A0 =A0 /* the number of ele=
ments */
>> - =A0 =A0 =A0 data1_reg_val =3D pdata->cs_hold << SPIDAT1_CSHOLD_SHIFT;
>> -
>> - =A0 =A0 =A0 /* CS default =3D 0xFF */
>> - =A0 =A0 =A0 tmp =3D ~(0x1 << spi->chip_select);
>> -
>> - =A0 =A0 =A0 clear_io_bits(davinci_spi->base + SPIDEF, ~tmp);
>> -
>> - =A0 =A0 =A0 data1_reg_val |=3D tmp << SPIDAT1_CSNR_SHIFT;
>> -
>> - =A0 =A0 =A0 /* disable all interrupts for dma transfers */
>> - =A0 =A0 =A0 clear_io_bits(davinci_spi->base + SPIINT, SPIINT_MASKALL);
>> - =A0 =A0 =A0 /* Disable SPI to write configuration bits in SPIDAT */
>> - =A0 =A0 =A0 clear_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_SPIENA_=
MASK);
>> - =A0 =A0 =A0 iowrite32(data1_reg_val, davinci_spi->base + SPIDAT1);
>> - =A0 =A0 =A0 /* Enable SPI */
>> + =A0 =A0 =A0 clear_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_POWERDO=
WN_MASK);
>> =A0 =A0 =A0 =A0set_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_SPIENA_M=
ASK);
>>
>> - =A0 =A0 =A0 while ((ioread32(davinci_spi->base + SPIBUF)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & SPIBUF_R=
XEMPTY_MASK) =3D=3D 0)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax();
>> -
>> + =A0 =A0 =A0 INIT_COMPLETION(davinci_spi->done);
>>
>> - =A0 =A0 =A0 if (t->tx_buf) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 t->tx_dma =3D dma_map_single(&spi->dev, (v=
oid *)t->tx_buf, count,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DMA_TO_DEV=
ICE);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dma_mapping_error(&spi->dev, t->tx_dma=
)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(sdev, "Unable to D=
MA map a %d bytes"
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " TX buffe=
r\n", count);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> + =A0 =A0 =A0 if ((spi_cfg->io_type =3D=3D SPI_IO_TYPE_INTR) ||
>> + =A0 =A0 =A0 =A0 =A0 (spi_cfg->io_type =3D=3D SPI_IO_TYPE_POLL)) {
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (spi_cfg->io_type =3D=3D SPI_IO_TYPE_IN=
TR)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_io_bits(davinci_spi->b=
ase + SPIINT, SPIINT_MASKINT);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* start the transfer */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->wcount--;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_data =3D davinci_spi->get_tx(davinci_sp=
i);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spidat1 &=3D 0xFFFF0000;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spidat1 |=3D (tx_data & 0xFFFF);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite32(spidat1, davinci_spi->base + SPI=
DAT1);
>> +
>> + =A0 =A0 =A0 } else if (spi_cfg->io_type =3D=3D SPI_IO_TYPE_DMA) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data_type =3D spi_cfg->bytes_per_word;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_reg =3D (dma_addr_t)davinci_spi->pbase =
+ SPIDAT1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_reg =3D (dma_addr_t)davinci_spi->pbase =
+ SPIBUF;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (t->tx_buf) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_buf =3D ((void *)t->tx_=
buf);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_buf_count =3D davinci_s=
pi->wcount;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_buf =3D (void *)davinci=
_spi->tmp_buf;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_buf_count =3D SPI_BUFSI=
Z;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_count =3D count;
>> - =A0 =A0 =A0 } else {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* We need TX clocking for RX transaction =
*/
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 t->tx_dma =3D dma_map_single(&spi->dev,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (void *)da=
vinci_spi->tmp_buf, count + 1,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DMA_TO_DEV=
ICE);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dma_mapping_error(&spi->dev, t->tx_dma=
)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(sdev, "Unable to D=
MA map a %d bytes"
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " TX tmp b=
uffer\n", count);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (t->rx_buf) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_buf =3D (void *)t->rx_b=
uf;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_buf_count =3D davinci_s=
pi->rcount;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_buf =3D (void *)davinci=
_spi->tmp_buf;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_buf_count =3D SPI_BUFSI=
Z;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_count =3D count + 1;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 t->tx_dma =3D dma_map_single(&spi->dev, tx=
_buf,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 tx_buf_count, DMA_TO_DEVICE);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 t->rx_dma =3D dma_map_single(&spi->dev, rx=
_buf,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 rx_buf_count, DMA_FROM_DEVICE);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_param.opt =3D TCINTEN | EDMA_TCC(davinc=
i_dma->dma_tx_channel);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_param.src =3D t->tx_buf ? t->tx_dma : t=
x_reg;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_param.a_b_cnt =3D davinci_spi->wcount <=
< 16 | data_type;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_param.dst =3D tx_reg;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_param.src_dst_bidx =3D t->tx_buf ? data=
_type : 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_param.link_bcntrld =3D 0xffff;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_param.src_dst_cidx =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_param.ccnt =3D 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 edma_write_slot(davinci_dma->dma_tx_channe=
l, &tx_param);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 edma_link(davinci_dma->dma_tx_channel,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_dma->dummy_par=
am_slot);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_param.opt =3D TCINTEN | EDMA_TCC(davinc=
i_dma->dma_rx_channel);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_param.src =3D rx_reg;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_param.a_b_cnt =3D davinci_spi->rcount <=
< 16 | data_type;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_param.dst =3D t->rx_dma;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_param.src_dst_bidx =3D (t->rx_buf ? dat=
a_type : 0) << 16;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_param.link_bcntrld =3D 0xffff;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_param.src_dst_cidx =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_param.ccnt =3D 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 edma_write_slot(davinci_dma->dma_rx_channe=
l, &rx_param);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite16(spidat1 >> SPIDAT1_CSNR_SHIFT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_sp=
i->base + SPIDAT1 + 2);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 edma_start(davinci_dma->dma_rx_channel);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 edma_start(davinci_dma->dma_tx_channel);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_io_bits(davinci_spi->base + SPIINT, SP=
IINT_DMA_REQ_EN);
>> =A0 =A0 =A0 =A0}
>>
>> - =A0 =A0 =A0 edma_set_transfer_params(davinci_spi_dma->dma_tx_channel,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 data_type, temp_count, 1, 0, ASYNC);
>> - =A0 =A0 =A0 edma_set_dest(davinci_spi_dma->dma_tx_channel, tx_reg, INC=
R, W8BIT);
>> - =A0 =A0 =A0 edma_set_src(davinci_spi_dma->dma_tx_channel, t->tx_dma, I=
NCR, W8BIT);
>> - =A0 =A0 =A0 edma_set_src_index(davinci_spi_dma->dma_tx_channel, data_t=
ype, 0);
>> - =A0 =A0 =A0 edma_set_dest_index(davinci_spi_dma->dma_tx_channel, 0, 0);
>> -
>> - =A0 =A0 =A0 if (t->rx_buf) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* initiate transaction */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite32(data1_reg_val, davinci_spi->base=
 + SPIDAT1);
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 t->rx_dma =3D dma_map_single(&spi->dev, (v=
oid *)t->rx_buf, count,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DMA_FROM_D=
EVICE);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dma_mapping_error(&spi->dev, t->rx_dma=
)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(sdev, "Couldn't DM=
A map a %d bytes RX buffer\n",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 count);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (t->tx_buf !=3D NULL)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_unmap_=
single(NULL, t->tx_dma,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0count, DMA_TO_DEVICE);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> + =A0 =A0 =A0 /* Wait for the transfer to complete */
>> + =A0 =A0 =A0 if (spi_cfg->io_type !=3D SPI_IO_TYPE_POLL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wait_for_completion_interruptible(&(davinc=
i_spi->done));
>> + =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while ((davinci_spi->rcount > 0) && (ret =
=3D=3D 0)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D davinci_spi_proces=
s_events(davinci_spi);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax();
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 edma_set_transfer_params(davinci_spi_dma->=
dma_rx_channel,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data_type,=
 count, 1, 0, ASYNC);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 edma_set_src(davinci_spi_dma->dma_rx_chann=
el,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_reg, IN=
CR, W8BIT);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 edma_set_dest(davinci_spi_dma->dma_rx_chan=
nel,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 t->rx_dma,=
 INCR, W8BIT);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 edma_set_src_index(davinci_spi_dma->dma_rx=
_channel, 0, 0);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 edma_set_dest_index(davinci_spi_dma->dma_r=
x_channel,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data_type,=
 0);
>> =A0 =A0 =A0 =A0}
>>
>> - =A0 =A0 =A0 if ((t->tx_buf) || (t->rx_buf))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 edma_start(davinci_spi_dma->dma_tx_channel=
);
>> -
>> - =A0 =A0 =A0 if (t->rx_buf)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 edma_start(davinci_spi_dma->dma_rx_channel=
);
>> -
>> - =A0 =A0 =A0 if ((t->rx_buf) || (t->tx_buf))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi_set_dma_req(spi, 1);
>> -
>> - =A0 =A0 =A0 if (t->tx_buf)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 wait_for_completion_interruptible(
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &davinci_s=
pi_dma->dma_tx_completion);
>> -
>> - =A0 =A0 =A0 if (t->rx_buf)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 wait_for_completion_interruptible(
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &davinci_s=
pi_dma->dma_rx_completion);
>> -
>> - =A0 =A0 =A0 dma_unmap_single(NULL, t->tx_dma, temp_count, DMA_TO_DEVIC=
E);
>> -
>> - =A0 =A0 =A0 if (t->rx_buf)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_unmap_single(NULL, t->rx_dma, count, D=
MA_FROM_DEVICE);
>> -
>> - =A0 =A0 =A0 /*
>> - =A0 =A0 =A0 =A0* Check for bit error, desync error,parity error,timeou=
t error and
>> - =A0 =A0 =A0 =A0* receive overflow errors
>> - =A0 =A0 =A0 =A0*/
>> - =A0 =A0 =A0 int_status =3D ioread32(davinci_spi->base + SPIFLG);
>> + =A0 =A0 =A0 clear_io_bits(davinci_spi->base + SPIINT, SPIINT_MASKALL);
>> + =A0 =A0 =A0 if (spi_cfg->io_type =3D=3D SPI_IO_TYPE_DMA) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_unmap_single(NULL, t->tx_dma, tx_buf_c=
ount,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 DMA_TO_DEVICE);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_unmap_single(NULL, t->rx_dma, rx_buf_c=
ount,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 DMA_FROM_DEVICE);
>> + =A0 =A0 =A0 }
>>
>> - =A0 =A0 =A0 ret =3D davinci_spi_check_error(davinci_spi, int_status);
>> - =A0 =A0 =A0 if (ret !=3D 0)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 =A0 clear_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_SPIENA_=
MASK);
>> + =A0 =A0 =A0 set_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_POWERDOWN=
_MASK);
>>
>> - =A0 =A0 =A0 /* SPI Framework maintains the count only in bytes so conv=
ert back */
>> - =A0 =A0 =A0 davinci_spi->count *=3D conv;
>> + =A0 =A0 =A0 if (davinci_spi->errors) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D davinci_spi_check_error(davinci_sp=
i, davinci_spi->errors);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret !=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 if ((davinci_spi->rcount !=3D 0) || (davinci_spi->wcount !=
=3D 0)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdev =3D davinci_spi->bitbang.master->dev.=
parent;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(sdev, "SPI data transfer error\n"=
);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
>> + =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 =A0return t->len;
>> =A0}
>>
>> =A0/**
>> - * davinci_spi_irq - IRQ handler for DaVinci SPI
>> + * davinci_spi_irq - probe function for SPI Master Controller
>
> This doesn't look right.
>
>> =A0* @irq: IRQ number for this SPI Master
>> =A0* @context_data: structure for SPI Master controller davinci_spi
>> + *
>> + * ISR will determine that interrupt arrives either for READ or WRITE c=
ommand.
>> + * According to command it will do the appropriate action. It will check
>> + * transfer length and if it is not zero then dispatch transfer command=
 again.
>> + * If transfer length is zero then it will indicate the COMPLETION so t=
hat
>> + * davinci_spi_bufs function can go ahead.
>> =A0*/
>> =A0static irqreturn_t davinci_spi_irq(s32 irq, void *context_data)
>> =A0{
>> =A0 =A0 =A0 =A0struct davinci_spi *davinci_spi =3D context_data;
>> - =A0 =A0 =A0 u32 int_status, rx_data =3D 0;
>> - =A0 =A0 =A0 irqreturn_t ret =3D IRQ_NONE;
>> + =A0 =A0 =A0 int status;
>>
>> - =A0 =A0 =A0 int_status =3D ioread32(davinci_spi->base + SPIFLG);
>> + =A0 =A0 =A0 status =3D davinci_spi_process_events(davinci_spi);
>> + =A0 =A0 =A0 if (unlikely(status !=3D 0))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clear_io_bits(davinci_spi->base + SPIINT, =
SPIINT_MASKINT);
>>
>> - =A0 =A0 =A0 while ((int_status & SPIFLG_RX_INTR_MASK)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (likely(int_status & SPIFLG_RX_INTR_MAS=
K)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D IRQ_HANDLED;
>> + =A0 =A0 =A0 if ((davinci_spi->rcount =3D=3D 0) || (status !=3D 0))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 complete(&(davinci_spi->done));
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_data =3D ioread32(davin=
ci_spi->base + SPIBUF);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->get_rx(rx_dat=
a, davinci_spi);
>> + =A0 =A0 =A0 return IRQ_HANDLED;
>> +}
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Disable Receive Interru=
pt */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite32(~(SPIINT_RX_INTR=
 | SPIINT_TX_INTR),
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 davinci_spi->base + SPIINT);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (void)davinci_spi_check_er=
ror(davinci_spi, int_status);
>> +resource_size_t davinci_spi_get_dma_by_index(struct platform_device *de=
v,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long index)
>> +{
>> + =A0 =A0 =A0 struct resource *r;
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 int_status =3D ioread32(davinci_spi->base =
+ SPIFLG);
>> - =A0 =A0 =A0 }
>> + =A0 =A0 =A0 r =3D platform_get_resource(dev, IORESOURCE_DMA, index);
>> + =A0 =A0 =A0 if (r !=3D NULL)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return r->start;
>>
>> - =A0 =A0 =A0 return ret;
>> + =A0 =A0 =A0 return SPI_NO_RESOURCE;
>> =A0}
>>
>> =A0/**
>> =A0* davinci_spi_probe - probe function for SPI Master Controller
>> =A0* @pdev: platform_device structure which contains plateform specific =
data
>> + *
>> + * According to Linux Device Model this function will be invoked by Lin=
ux
>> + * with platform_device struct which contains the device specific info.
>> + * This function will map the SPI controller's memory, register IRQ,
>> + * Reset SPI controller and setting its registers to default value.
>> + * It will invoke spi_bitbang_start to create work queue so that client=
 driver
>> + * can register transfer method to work queue.
>
> Another candidate; improve documentation
>
>> =A0*/
>> =A0static int davinci_spi_probe(struct platform_device *pdev)
>> =A0{
>> @@ -1020,6 +887,7 @@ static int davinci_spi_probe(struct platform_device=
 *pdev)
>> =A0 =A0 =A0 =A0resource_size_t dma_tx_chan =3D SPI_NO_RESOURCE;
>> =A0 =A0 =A0 =A0resource_size_t dma_eventq =3D SPI_NO_RESOURCE;
>> =A0 =A0 =A0 =A0int i =3D 0, ret =3D 0;
>> + =A0 =A0 =A0 u32 spipc0;
>>
>> =A0 =A0 =A0 =A0pdata =3D pdev->dev.platform_data;
>> =A0 =A0 =A0 =A0if (pdata =3D=3D NULL) {
>> @@ -1071,10 +939,12 @@ static int davinci_spi_probe(struct platform_devi=
ce *pdev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto unmap_io;
>> =A0 =A0 =A0 =A0}
>>
>> - =A0 =A0 =A0 ret =3D request_irq(davinci_spi->irq, davinci_spi_irq, IRQ=
F_DISABLED,
>> + =A0 =A0 =A0 ret =3D request_irq(davinci_spi->irq, davinci_spi_irq, 0,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_name(&pdev->dev),=
 davinci_spi);
>> - =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 if (ret !=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EAGAIN;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto unmap_io;
>> + =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 =A0/* Allocate tmp_buf for tx_buf */
>> =A0 =A0 =A0 =A0davinci_spi->tmp_buf =3D kzalloc(SPI_BUFSIZ, GFP_KERNEL);
>> @@ -1104,55 +974,23 @@ static int davinci_spi_probe(struct platform_devi=
ce *pdev)
>>
>> =A0 =A0 =A0 =A0davinci_spi->bitbang.chipselect =3D davinci_spi_chipselec=
t;
>> =A0 =A0 =A0 =A0davinci_spi->bitbang.setup_transfer =3D davinci_spi_setup=
_transfer;
>> + =A0 =A0 =A0 davinci_spi->bitbang.txrx_bufs =3D davinci_spi_txrx_bufs;
>>
>> =A0 =A0 =A0 =A0davinci_spi->version =3D pdata->version;
>> - =A0 =A0 =A0 use_dma =3D pdata->use_dma;
>>
>> =A0 =A0 =A0 =A0davinci_spi->bitbang.flags =3D SPI_NO_CS | SPI_LSB_FIRST =
| SPI_LOOP;
>> =A0 =A0 =A0 =A0if (davinci_spi->version =3D=3D SPI_VERSION_2)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0davinci_spi->bitbang.flags |=3D SPI_READY;
>>
>> - =A0 =A0 =A0 if (use_dma) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D platform_get_resourc=
e(pdev, IORESOURCE_DMA, 0);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (r)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_rx_cha=
n =3D r->start;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D platform_get_resourc=
e(pdev, IORESOURCE_DMA, 1);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (r)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_tx_cha=
n =3D r->start;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D platform_get_resourc=
e(pdev, IORESOURCE_DMA, 2);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (r)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_eventq=
 =3D r->start;
>> - =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 if (!use_dma ||
>> - =A0 =A0 =A0 =A0 =A0 dma_rx_chan =3D=3D SPI_NO_RESOURCE ||
>> - =A0 =A0 =A0 =A0 =A0 dma_tx_chan =3D=3D SPI_NO_RESOURCE ||
>> - =A0 =A0 =A0 =A0 =A0 dma_eventq =A0=3D=3D SPI_NO_RESOURCE) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->bitbang.txrx_bufs =3D davinci=
_spi_bufs_pio;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 use_dma =3D 0;
>> - =A0 =A0 =A0 } else {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->bitbang.txrx_bufs =3D davinci=
_spi_bufs_dma;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->dma_channels =3D kzalloc(mast=
er->num_chipselect
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * sizeof(s=
truct davinci_spi_dma), GFP_KERNEL);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (davinci_spi->dma_channels =3D=3D NULL)=
 {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_clk;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < master->num_chipselect; =
i++) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->dma_channels[=
i].dma_rx_channel =3D -1;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->dma_channels[=
i].dma_rx_sync_dev =3D
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_rx_cha=
n;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->dma_channels[=
i].dma_tx_channel =3D -1;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->dma_channels[=
i].dma_tx_sync_dev =3D
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_tx_cha=
n;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->dma_channels[=
i].eventq =3D dma_eventq;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(&pdev->dev, "DaVinci SPI driver i=
n EDMA mode\n"
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Using RX =
channel =3D %d , TX channel =3D %d and "
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "event que=
ue =3D %d", dma_rx_chan, dma_tx_chan,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_eventq=
);
>> - =A0 =A0 =A0 }
>> + =A0 =A0 =A0 dma_rx_chan =3D davinci_spi_get_dma_by_index(pdev, RX_DMA_=
INDEX);
>> + =A0 =A0 =A0 dma_tx_chan =3D davinci_spi_get_dma_by_index(pdev, TX_DMA_=
INDEX);
>> + =A0 =A0 =A0 dma_eventq =A0=3D davinci_spi_get_dma_by_index(pdev, EVENT=
Q_DMA_INDEX);
>> + =A0 =A0 =A0 davinci_spi->dma_channels.dma_rx_channel =3D -1;
>> + =A0 =A0 =A0 davinci_spi->dma_channels.dma_rx_sync_dev =3D dma_rx_chan;
>> + =A0 =A0 =A0 davinci_spi->dma_channels.dma_tx_channel =3D -1;
>> + =A0 =A0 =A0 davinci_spi->dma_channels.dma_tx_sync_dev =3D dma_tx_chan;
>> + =A0 =A0 =A0 davinci_spi->dma_channels.dummy_param_slot =3D -1;
>> + =A0 =A0 =A0 davinci_spi->dma_channels.eventq =3D dma_eventq;
>>
>> =A0 =A0 =A0 =A0davinci_spi->get_rx =3D davinci_spi_rx_buf_u8;
>> =A0 =A0 =A0 =A0davinci_spi->get_tx =3D davinci_spi_tx_buf_u8;
>> @@ -1164,31 +1002,28 @@ static int davinci_spi_probe(struct platform_dev=
ice *pdev)
>> =A0 =A0 =A0 =A0udelay(100);
>> =A0 =A0 =A0 =A0iowrite32(1, davinci_spi->base + SPIGCR0);
>>
>> - =A0 =A0 =A0 /* Clock internal */
>> - =A0 =A0 =A0 if (davinci_spi->pdata->clk_internal)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_io_bits(davinci_spi->base + SPIGCR1,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SPIGCR1_CL=
KMOD_MASK);
>> - =A0 =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 clear_io_bits(davinci_spi->base + SPIGCR1,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SPIGCR1_CL=
KMOD_MASK);
>> + =A0 =A0 =A0 /* Set up SPIPC0. =A0CS and ENA init is done in davinci_sp=
i_setup */
>> + =A0 =A0 =A0 spipc0 =3D SPIPC0_DIFUN_MASK | SPIPC0_DOFUN_MASK | SPIPC0_=
CLKFUN_MASK;
>> + =A0 =A0 =A0 iowrite32(spipc0, davinci_spi->base + SPIPC0);
>>
>> - =A0 =A0 =A0 /* master mode default */
>> - =A0 =A0 =A0 set_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_MASTER_MA=
SK);
>> + =A0 =A0 =A0 /* initialize chip selects */
>> + =A0 =A0 =A0 if (pdata->chip_sel !=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < pdata->num_chipselect; i=
++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pdata->chip_sel[i] !=
=3D SPI_INTERN_CS)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_direc=
tion_output(pdata->chip_sel[i], 1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 iowrite32(SPIDEF_CSDEF_MASK, davinci_spi->base + SPIDEF);
>>
>> - =A0 =A0 =A0 if (davinci_spi->pdata->intr_level)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite32(SPI_INTLVL_1, davinci_spi->base =
+ SPILVL);
>> - =A0 =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite32(SPI_INTLVL_0, davinci_spi->base =
+ SPILVL);
>> + =A0 =A0 =A0 set_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_CLKMOD_MA=
SK);
>> + =A0 =A0 =A0 set_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_MASTER_MA=
SK);
>> + =A0 =A0 =A0 set_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_POWERDOWN=
_MASK);
>>
>> =A0 =A0 =A0 =A0ret =3D spi_bitbang_start(&davinci_spi->bitbang);
>> - =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 if (ret !=3D 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto free_clk;
>>
>> - =A0 =A0 =A0 dev_info(&pdev->dev, "Controller at 0x%p \n", davinci_spi-=
>base);
>> -
>> - =A0 =A0 =A0 if (!pdata->poll_mode)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(&pdev->dev, "Operating in interru=
pt mode"
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " using IRQ %d\n", davinci=
_spi->irq);
>> + =A0 =A0 =A0 dev_info(&pdev->dev, "Controller at 0x%p\n", davinci_spi->=
base);
>>
>> =A0 =A0 =A0 =A0return ret;
>>
>> @@ -1220,7 +1055,7 @@ err:
>> =A0* It will also call spi_bitbang_stop to destroy the work queue which =
was
>> =A0* created by spi_bitbang_start.
>> =A0*/
>> -static int __exit davinci_spi_remove(struct platform_device *pdev)
>> +static int __devexit davinci_spi_remove(struct platform_device *pdev)
>> =A0{
>> =A0 =A0 =A0 =A0struct davinci_spi *davinci_spi;
>> =A0 =A0 =A0 =A0struct spi_master *master;
>> @@ -1242,8 +1077,11 @@ static int __exit davinci_spi_remove(struct platf=
orm_device *pdev)
>> =A0}
>>
>> =A0static struct platform_driver davinci_spi_driver =3D {
>> - =A0 =A0 =A0 .driver.name =3D "spi_davinci",
>> - =A0 =A0 =A0 .remove =3D __exit_p(davinci_spi_remove),
>> + =A0 =A0 =A0 .driver =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "spi_davinci",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =3D THIS_MODULE,
>> + =A0 =A0 =A0 },
>> + =A0 =A0 =A0 .remove =3D __devexit_p(davinci_spi_remove),
>> =A0};
>
> Another candidate. =A0Corrections to platform_driver structure and
> __devexit annotations.
>
>>
>> =A0static int __init davinci_spi_init(void)
>> --
>> 1.6.3.3
>>
>>
>
>
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
>

---------------------------------------------------------------------------=
---
The Palm PDK Hot Apps Program offers developers who use the
Plug-In Development Kit to bring their C/C++ apps to Palm for a share
of $1 Million in cash or HP Products. Visit us here for more details:
http://p.sf.net/sfu/dev2dev-palm
