From: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>
Subject: Re: [PATCH v2] spi: New driver for Altera SPI
Date: Mon, 17 Jan 2011 16:59:58 +1100
Message-ID: <20110117165958.f89e8220.sfr@canb.auug.org.au>
References: <1254981838-20584-1-git-send-email-thomas@wytron.com.tw>
	<1295243200-28230-1-git-send-email-thomas@wytron.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4420359061905633112=="
Cc: nios2-dev-1eJk0qcHJCcaeqlQEoCUNoJY59XmG8rH@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1295243200-28230-1-git-send-email-thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-spi.vger.kernel.org

--===============4420359061905633112==
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__17_Jan_2011_16_59_58_+1100_o1M42irch8Wbv.GQ"

--Signature=_Mon__17_Jan_2011_16_59_58_+1100_o1M42irch8Wbv.GQ
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Mon, 17 Jan 2011 13:46:40 +0800 Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org> wrote:
>
> This patch adds a new SPI driver to support the Altera SOPC Builder
> SPI component. It uses the bitbanging library.

Just a general query.

> diff --git a/include/linux/spi/spi_altera.h b/include/linux/spi/spi_alter=
a.h
> new file mode 100644
> index 0000000..b3d7f69
> --- /dev/null
> +++ b/include/linux/spi/spi_altera.h
> @@ -0,0 +1,12 @@
> +#ifndef _LINUX_SPI_SPI_ALTERA_H
> +#define _LINUX_SPI_SPI_ALTERA_H
> +
> +/*
> + * struct altera_spi_platform_data - platform data of the Altera SPI
> + * @interrupt:	use intrrupt driven data transfer.
> + */
> +struct altera_spi_platform_data {
> +	int interrupt;
> +};

Is there some reason that this struct definition cannot just be placed
in spi_altera.c and so save a whole extra file (and its inclusion)?

--=20
Cheers,
Stephen Rothwell                    sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__17_Jan_2011_16_59_58_+1100_o1M42irch8Wbv.GQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJNM9reAAoJEDMEi1NhKgbsZqAH/jh2V0e38zKKPugvDETezbC9
1/KuXsK+Q3nq7+5r7jDBkQeyx1jbPwGoFBVNRAh34+CekvrpMc69XdFqGoIMRMBw
HVKWBMhCAL73IS0PK21ewOGIlI4pyNf0XJS5iS3WmllZxSIOn2UI0soGhW1ic/Ya
eVOwFawjCJ1OTnAFMrNfpYUD6VqG32r53mSMjWsalHvX/7yJYZFJKPY2NDq4c2b6
wMatp9/tgDf0ajbauJr6BvJ4ti8wTf5rWf0enxheG1VMYp/Qgoz81g3gQ9iyK5S6
pUuPs0wxkJI+z6p5YGSgZKRRrPubyvYBY2tuWph/az0qZ8NxDEOgIcHGSm6xXKk=
=gZYc
-----END PGP SIGNATURE-----

--Signature=_Mon__17_Jan_2011_16_59_58_+1100_o1M42irch8Wbv.GQ--

--===============4420359061905633112==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============4420359061905633112==--
