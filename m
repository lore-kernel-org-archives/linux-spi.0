From: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH linux-next v5 1/5] mtd: spi-nor: notify (Q)SPI controller
 about protocol change
Date: Wed, 26 Aug 2015 16:02:49 +0200
Message-ID: <CAOiHx=n+byfsbJNhnboqDEwhruOT8uKDJ+CcES7QBqPDLVAMsw@mail.gmail.com>
References: <cover.1440580764.git.cyrille.pitchen@atmel.com> <464fce12d75a5ba2105456cfd0a385b2d40305ba.1440580764.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"Bean Huo (beanhuo)" <beanhuo-AL4WhLSQfzjQT0dZR+AlfA@public.gmane.org>,
	Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>,
	=?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex-ynQEQJNshbs@public.gmane.org>,
	shijie.huang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <464fce12d75a5ba2105456cfd0a385b2d40305ba.1440580764.git.cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Aug 26, 2015 at 2:30 PM, Cyrille Pitchen
<cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org> wrote:
> Once the Quad SPI mode has been enabled on a Micron flash memory, this
> device expects ALL the following commands to use the SPI 4-4-4 protocol.
> The (Q)SPI controller needs to be notified about the protocol change so it
> can adapt and keep on dialoging with the Micron memory.

Doesn't that mean you need to disable quad mode on removal? Else the
following will break/fail:

insmod atmel-quadspi.ko ~> spi-nor attaches -> sees micron -> enables quad mode
rmmod atmel-quadspi.ko ~> spi-nor detaches
insmod atmel-quadspi.ko ~> spi-nor attaches -> fails to read the id
because flash is still in quad mode.

> Signed-off-by: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> Acked-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
> Acked-by: Bean Huo <beanhuo-AL4WhLSQfzjQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 21 +++++++++++++++++++++
>  include/linux/mtd/spi-nor.h   | 13 +++++++++++++
>  2 files changed, 34 insertions(+)
>
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index c27d427fead4..c8810313a752 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -165,6 +165,22 @@ static inline int write_disable(struct spi_nor *nor)
>         return nor->write_reg(nor, SPINOR_OP_WRDI, NULL, 0, 0);
>  }
>
> +/*
> + * Let the spi-nor framework notify lower layers, especially the driver of the
> + * (Q)SPI controller, about the new protocol to be used. Indeed, once the
> + * spi-nor framework has sent manufacturer specific commands to a memory to
> + * enable its Quad SPI mode, it should immediately after tell the QSPI
> + * controller to use the very same Quad SPI protocol as expected by the memory.
> + */
> +static inline int spi_nor_set_protocol(struct spi_nor *nor,
> +                                      enum spi_protocol proto)
> +{
> +       if (nor->set_protocol)
> +               return nor->set_protocol(nor, proto);
> +
> +       return 0;

Shouldn't the default assumption be that it won't support it? Also it
might make sense to first check if it's supported before enabling it
in the chip, so that we don't enable something just to then find out
we can't back out of it.

I also wonder if we need an extra flag for that as at least SPI has
RX_{DUAL,QUAD} and TX_{DUAL,QUAD} separated, so in theory there could
be a controller that supports quad read, but not quad write, so we
shouldn't be using the quad mode in that case. m25p80 currently sets
SPI_NOR_{DUAL,QUAD} only based on SPI_RX_{DUAL,QUAD}, so that would
then fail.

At least the n25q32 seems to support the "boring" 1_1_2 and 1_1_4
commands, so these should work in case the spi controller does not
support quad tx, but quad rx.

So maybe an additional flag for the "full" dual/quad modes would be in order.

Last but not least, the protocol probably should be stored somewhere
in the nor struct, so that users don't have to store it themselves (I
assume they will need to check it for each command again to know if
the cmd/address should be send in serial or quad mode).


Jonas
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
