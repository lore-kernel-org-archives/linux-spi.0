From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH RFC] spi/gpio: start with CS non-active
Date: Thu, 5 Jul 2012 09:45:40 +0200
Message-ID: <20120705074540.GF5398@pengutronix.de>
References: <1328822505-7039-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1328822505-7039-1-git-send-email-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Feb 09, 2012 at 10:21:45PM +0100, Uwe Kleine-K=F6nig wrote:
> The chip select line was configured as output with the initial value
> being active explicitly. It was later deasserted during
> spi_bitbang_setup() without any clock activity in between. So it makes
> no sense to activate the device at all and the chip select line can
> better start non-active.
> =

> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> ---
> Hello,
> =

> I'm not sure if an active chip select line without any clock activity can
> confuse a device. If so, this patch might qualify as fix. But with my
> limited knowledge about spi it's also possible that I just miss why the
> active chip select is important. For the devices I have it doesn't seem
> to make a difference.
ping

> =

> Best regards
> Uwe
> =

>  drivers/spi/spi-gpio.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> =

> diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
> index 0094c64..0b56cfc 100644
> --- a/drivers/spi/spi-gpio.c
> +++ b/drivers/spi/spi-gpio.c
> @@ -235,7 +235,8 @@ static int spi_gpio_setup(struct spi_device *spi)
>  			status =3D gpio_request(cs, dev_name(&spi->dev));
>  			if (status)
>  				return status;
> -			status =3D gpio_direction_output(cs, spi->mode & SPI_CS_HIGH);
> +			status =3D gpio_direction_output(cs,
> +					!(spi->mode & SPI_CS_HIGH));
>  		}
>  	}
>  	if (!status)
> -- =

> 1.7.9
> =

> =


-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

---------------------------------------------------------------------------=
---
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and =

threat landscape has changed and how IT managers can respond. Discussions =

will include endpoint security, mobile security and the latest in malware =

threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
