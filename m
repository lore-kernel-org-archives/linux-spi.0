From: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>
Subject: Re: [PATCH 3/4] [POWERPC][SPI] use
	brg-frequency for SPI in QE
Date: Thu, 20 Dec 2007 10:27:40 +1100
Message-ID: <20071220102740.4af61d8a.sfr@canb.auug.org.au>
References: <20071219203447.GA18285@localhost.localdomain>
	<20071219203805.GC20861@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1184597353=="
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20071219203805.GC20861-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

--===============1184597353==
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__20_Dec_2007_10_27_40_+1100_7Xa=zxImn+lBCF1h"

--Signature=_Thu__20_Dec_2007_10_27_40_+1100_7Xa=zxImn+lBCF1h
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 19 Dec 2007 23:38:05 +0300 Anton Vorontsov <avorontsov-hkdhdckH98/SCDK34cm6iQ@public.gmane.org=
m> wrote:
>
> +++ b/arch/powerpc/sysdev/fsl_soc.c
> @@ -1227,15 +1227,19 @@ int __init fsl_spi_init(struct spi_board_info *bo=
ard_infos,
> =20
>  	/* SPI controller is either clocked from QE or SoC clock */
>  	np =3D of_find_compatible_node(NULL, NULL, "fsl,qe");
> -	if (!np)
> +	if (np) {
> +		sysclk =3D of_get_property(np, "brg-frequency", NULL);
> +		if (!sysclk)
> +			return -ENODEV;

You need an of_node_put(np) in the failing case.

> +	} else {
>  		np =3D of_find_node_by_type(NULL, "soc");
> +		if (!np)
> +			return -ENODEV;
> =20
> -	if (!np)
> -		return -ENODEV;
> -
> -	sysclk =3D of_get_property(np, "bus-frequency", NULL);
> -	if (!sysclk)
> -		return -ENODEV;
> +		sysclk =3D of_get_property(np, "bus-frequency", NULL);
> +		if (!sysclk)
> +			return -ENODEV;

And again.

> +	}
> =20
>  	for (np =3D NULL, i =3D 1;

There should be an of_node_put(np) before this as well.

--=20
Cheers,
Stephen Rothwell                    sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__20_Dec_2007_10_27_40_+1100_7Xa=zxImn+lBCF1h
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHaajwTgG2atn1QN8RAmb2AJ49iL3O1v6tJO2hV970a21Ry935OwCdEAIj
TYHH4uLExEBHPW9lpzHQQKo=
=fkFU
-----END PGP SIGNATURE-----

--Signature=_Thu__20_Dec_2007_10_27_40_+1100_7Xa=zxImn+lBCF1h--


--===============1184597353==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services
for just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
--===============1184597353==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--===============1184597353==--
