From: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 1/2] spi: implemented driver for
	Cirrus EP93xx SPI controller
Date: Wed, 5 May 2010 11:04:15 +0200
Message-ID: <w2h63386a3d1005050204t13284de8p3fa692ed647e3bee@mail.gmail.com>
References: <cover.1272805161.git.mika.westerberg@iki.fi>
	<0dce0e9fdb6af35854d26d7bd0d8af5a5ea8f76a.1272805161.git.mika.westerberg@iki.fi>
	<h2r63386a3d1005021718k31125e4fz43a08025997b5c5c@mail.gmail.com>
	<0D753D10438DA54287A00B0270842697636E9BA5D3@AUSP01VMBX24.collaborationhost.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Mika Westerberg <mika.westerberg-X3B1VOXEql0@public.gmane.org>, Rabin Vincent <rabin-66gdRtMMWGc@public.gmane.org>,
	"ryan-7Wk5F4Od5/oYd5yxfr4S2w@public.gmane.org" <ryan-7Wk5F4Od5/oYd5yxfr4S2w@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"martinwguy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <martinwguy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: H Hartley Sweeten <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <0D753D10438DA54287A00B0270842697636E9BA5D3-gaq956PjLg32KbjnnMDalRurcAul1UnsRrxOEX5GOmysTnJN9+BGXg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

2010/5/3 H Hartley Sweeten <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>:
> On Sunday, May 02, 2010 5:19 PM, Linus Walleij wrote:

>> When I look at this it's quite obvious that this is the same hardware or=
 very
>> close (maybe a redux version) of the thing supported by
>> drivers/spi/amba-pl022.c.
>>
>> What is the difference really? I suspect this is a PL022 PrimeCell strai=
ght off.
>> Even the CPSR algorithm is the same, just written differently.
>>
>> Can you make a hexdump of the PrimeCell ID registers at offset
>> base+0xffe0..0xffff and post the contents?
>
> As Mika already pointed out, the ep93xx ssp peripheral does not have a va=
lid
> PeripheralID or PrimeCellID to identify it as an AMBA PL022 peripheral.

Yep, but how close is it... the raw PL022 and the ST Micro variant only dif=
fer
in a few small places.

> It probably was originally based on the PL022 but I think Cirrus hacked it
> enough that the generic amba-pl022 driver will not work with it, at least
> without a number of ugly #ifdef hacks.

The stuff we've done with vendor data is mostly done so that we alter
execution path in runtime rather than throwing in #ifdefs.

> Or, I could be wrong. =A0It appears the amba-pl022 driver doesn't actuall=
y match
> the ARM spec for the PL022.

You're right, the control registers are not cleanly separated into the vani=
lla
PL022 vs ST Micro Nomadik extensions. I will post a fixup patch soonish,
covering all the stuff you pointed out.

When you look at the code post-patch I think you will see that it
is actually even closer, to the vanilla PL022.

Sorry for the mess, I was retrofitting a driver for the ST extended
version to the plain PL022 found in U300 and missed some stuff.

By chance, Rabin pointed me to the same problems some day ago...

> The PL022 spec only shows the peripheral as supporting up to 16-bit trans=
fers.
> This is the limit for the EP93xx also but the amba-pl022 driver actually =
supports
> up to 32-bit transfers.

Actually the code execution path takes this into account in
the pl022_setup() function:

	if (chip_info->data_size <=3D 8) {
		dev_dbg(&spi->dev, "1 <=3D n <=3D8 bits per word\n");
		chip->n_bytes =3D 1;
		chip->read =3D READING_U8;
		chip->write =3D WRITING_U8;
	} else if (chip_info->data_size <=3D 16) {
		dev_dbg(&spi->dev, "9 <=3D n <=3D 16 bits per word\n");
		chip->n_bytes =3D 2;
		chip->read =3D READING_U16;
		chip->write =3D WRITING_U16;
	} else {
		if (pl022->vendor->max_bpw >=3D 32) {
			dev_dbg(&spi->dev, "17 <=3D n <=3D 32 bits per word\n");
			chip->n_bytes =3D 4;
			chip->read =3D READING_U32;
			chip->write =3D WRITING_U32;
		} else {
			dev_err(&spi->dev,
				"illegal data size for this controller!\n");
			dev_err(&spi->dev,
				"a standard pl022 can only handle "
				"1 <=3D n <=3D 16 bit words\n");
			goto err_config_params;
		}
	}

As you see 32bit transfers will only be accepted as configuration if the
vendor data indicates that this is possible on that version of the controll=
er.

> /*
> =A0* SSP Interrupt Mask Set/Clear Register - SSP_IMSC
> =A0*/
> #define SSP_IMSC_MASK_RORIM (0x1UL << 0) /* Receive Overrun Interrupt mas=
k */
> #define SSP_IMSC_MASK_RTIM =A0(0x1UL << 1) /* Receive timeout Interrupt m=
ask */
> #define SSP_IMSC_MASK_RXIM =A0(0x1UL << 2) /* Receive FIFO Interrupt mask=
 */
> #define SSP_IMSC_MASK_TXIM =A0(0x1UL << 3) /* Transmit FIFO Interrupt mas=
k */
>
> In the EP93xx this register is called SSPIIR / SSPICR. =A0It is the inter=
rupt
> status register for reads and the interrupt clear register for writes. =
=A0For
> reads it is defined as:
>
> 0 =A0RIS =A0 =A0SSP Receive FIFO service request
> 1 =A0TIS =A0 =A0SSP Transmit FIFO service request
> 2 =A0RORIS =A0SSP Receive FIFO overrun interrupt status

This seems like it is either a precursor to the PL022 or a seriously
stripped down version. I don't know if this alone warrants duplicating the
rest of the code, could be.

> The other registers listed for the amba-pl022 do not exist in the EP93xx
> implementation.

We have a stripped down version called "PL023" as well, it's simply
that we don't use the extended features and it just works, so I think
it's not much of a problem.

> The biggest problem I can see trying to use the amba-pl022 with the ep93xx
> are the missing Peripheral ID and PrimeCell ID registers. =A0The AMBA bus=
 driver
> will not be able to match the driver to the device.

That is actually not a problem at all, you can hardcode a PrimeCell
ID into the platform config, and the device will be registered on the
given ID instead, like this:

struct amba_device ssp0_device =3D {
        .dev =3D {
                .coherent_dma_mask =3D ~0,
                .init_name =3D "ssp0",
                .platform_data =3D &ssp0_platform_data,
        },
        .res =3D {
                .start =3D U8500_SSP0_BASE,
                .end   =3D U8500_SSP0_BASE + SZ_4K - 1,
                .flags =3D IORESOURCE_MEM,
        },
        .irq =3D {IRQ_SSP0, NO_IRQ },
        /* PL022 Device ID */
        .periphid =3D 0x00041022,
};

Then you have to register it on the PrimeCell bus with

static struct amba_device *amba_devs[] __initdata =3D {
        &ssp0_device,
};

for (i =3D 0; i < ARRAY_SIZE(amba_devs); i++)
         amba_device_register(amba_devs[i], &iomem_resource);

> Beyond that, once the amba-pl022 driver supports DMA transfers the implem=
entation
> needed for the EP93xx will be completely different.

The idea about the PrimeCell DMA is to use the DMAdevices in the
DMA engine only, to find some common ground exactly in order to
facilitate usage with diverse platforms.

I know that there are many custom DMA implementations, the idea
is that if we can unify these under DMA engine we can abstract away
the specifics. I have already done this for two very different DMA
engines: COH901318 and DMA40 and it works. DMA controllers IMO
are not so special at all, they all share the same features and
shall hopefully all go in behind the DMA engine API.

> I think it's best to leave these as separate drivers. =A0Cirrus has stopp=
ed
> development of their ARM processors so we have no hope of ever getting a =
full
> pl022 compatible version.

I think it's worth a try to use amba-pl022.c, but hey, it's just me...

Yours,
Linus Walleij

---------------------------------------------------------------------------=
---
