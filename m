From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH v4] spi: Add PPC4xx SPI driver
Date: Thu, 20 Nov 2008 19:40:01 -0800
Message-ID: <200811201940.02277.david-b@pacbell.net>
References: <1225451266-23740-1-git-send-email-sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
To: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1225451266-23740-1-git-send-email-sr-ynQEQJNshbs@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Friday 31 October 2008, Stefan Roese wrote:
> +static int spi_ppc4xx_setupxfer(struct spi_device *spi, struct spi_trans=
fer *t)
> +{
> 		...
>
> +=A0=A0=A0=A0=A0=A0=A0if (in_8(&hw->regs->cdm) !=3D cdm)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0out_8(&hw->regs->cdm, cdm);

... writes to hardware, updating SPI the clock rate ...


> +static int spi_ppc4xx_setup(struct spi_device *spi)
> +{
> 	...
> +
> +=A0=A0=A0=A0=A0=A0=A0ret =3D spi_ppc4xx_setupxfer(spi, NULL);

... hence this also writes to the hardware.

Except ... the setup() method may be called for one SPI device
in the middle of a transfer for another device.  This might for
example cause the clock rate to speed up so it's too fast, thus
corrupting a transfer for that other device.  So you should NOT
be calling setupxfer() here.



> +=A0=A0=A0=A0=A0=A0=A0/* write new configration */
> +=A0=A0=A0=A0=A0=A0=A0out_8(&hw->regs->mode, mode);

Or here:  changing from a device using MSB-first mode 3 to
one using LSB-first mode 1.  This could also corrupt a transfer.


It might be better to have the setup() validate its inputs
and store them in the spi->controller_state, and then have
the setup_transfer() pull values from there ... but not make
setup() call setupxfer().  The best model would be that each
chipselect has its own set of speed/mode registers; if the
hardware doesn't work that way, then it can be emulated.


> +static int __init spi_ppc4xx_init(void)
> +{
> +=A0=A0=A0=A0=A0=A0=A0return of_register_platform_driver(&spi_ppc4xx_of_d=
river);
> +}
> +
> +static void __exit spi_ppc4xx_exit(void)
> +{
> +=A0=A0=A0=A0=A0=A0=A0of_unregister_platform_driver(&spi_ppc4xx_of_driver=
);
> +}
> +
> +module_init(spi_ppc4xx_init);
> +module_exit(spi_ppc4xx_exit);

I prefer to see module_{init,exit} annotations snugged up next
to the functions to which they apply ... just like EXPORT_SYMBOL
annotations, and for the same reasons.

- Dave

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
