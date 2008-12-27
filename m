From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH v5] spi: Add PPC4xx SPI driver
Date: Sat, 27 Dec 2008 11:32:25 -0800
Message-ID: <200812271132.25468.david-b@pacbell.net>
References: <1227628088-10849-1-git-send-email-sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1227628088-10849-1-git-send-email-sr-ynQEQJNshbs@public.gmane.org>
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

Also:

> +static struct of_platform_driver spi_ppc4xx_of_driver =3D {
> +=A0=A0=A0=A0=A0=A0=A0.owner =3D THIS_MODULE,
> +=A0=A0=A0=A0=A0=A0=A0.name =3D DRIVER_NAME,

I'd hope the PPC folk eliminate this duplication soonish.
Those fields are obvious duplicates of the driver model
fields...


> +=A0=A0=A0=A0=A0=A0=A0.match_table =3D spi_ppc4xx_of_match,
> +=A0=A0=A0=A0=A0=A0=A0.probe =3D spi_ppc4xx_of_probe,
> +=A0=A0=A0=A0=A0=A0=A0.remove =3D __exit_p(spi_ppc4xx_of_remove),
> +=A0=A0=A0=A0=A0=A0=A0.driver =3D {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.name =3D DRIVER_NAME,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.owner =3D THIS_MODULE,
> +=A0=A0=A0=A0=A0=A0=A0},
> +};



---------------------------------------------------------------------------=
---
