From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: omap2-mcspi: Remove list_empty checking in
 omap2_mcspi_transfer_one_message
Date: Wed, 19 Feb 2014 13:38:45 +0900
Message-ID: <20140219043845.GY2669@sirena.org.uk>
References: <1392732096.22192.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tfaCjp4mryZ5LVvS"
Cc: Stefan =?iso-8859-1?Q?S=F8rensen?=
	<stefan.sorensen-usnHOLptxrsHrNJx0XZkJA@public.gmane.org>,
	Victor Kamensky <victor.kamensky-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Illia Smyrnov <illia.smyrnov-hExfYMNmJl/Cnp4W7fqMDg@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1392732096.22192.0.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--tfaCjp4mryZ5LVvS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 10:01:36PM +0800, Axel Lin wrote:
> This checking is done in __spi_validate().

Applied both, thanks.

--tfaCjp4mryZ5LVvS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBDVSAAoJELSic+t+oim9Jv8QAILxDEJbRa3ZeV6wmPiCqsAt
Pf2Roa0M322+fQQEZbn4dMQffLnwNPiRtsNkFSpxdbB0SmiFUtWpV0vUmeVpR1rC
urSGNQ5c2EwwXprgoS2d70kfAd78s0gDE28ucBsXQNIesBDny6kWi2gzkSHcfFef
WC9YMS+li3O3KrHSfUR9frRzTwyr5ZadMq5ROmqGPZ1RMeGOEF5GYdwkZBPcMg9M
IxK5uqXoGhgbb8dpVzf6ZLNHoRRn+POgB1MKv7Pe8TeAbK1CMUafHzlmHeov/IqO
PjeJx2g1TD05GHBbJ05cbxNR+jCQey1oA/OhTpBvYMKzQFM+ZkEIIgzBdXkw1D7k
vrEvh8mfHsZbFjYbSp5gx7CSxfZwGg/AIHKzE3Td25GssfK+8zMKPFc+NdJCd9Qq
hd0E3oha9xZM3sh2sQl2GRnmZltusv+PxAeaALX/ooN6Uuv4EdIKDW+zBJGkzI1i
WJI8AZ+h1pFzObKYjv3xK+PHNArPk42Wn+sY8sCtW9MglJyw6nSe7nIuxbJgMl9z
sCHURS2D1yPEqyudd3Aqa7F+vmzPI1fWlrrReI5oVie0HVOYn1xBhYhhflFEnXBO
uUBHAGpuVFwWQgADVnEzCWiSzr5MQ88ZtZIs97EHHfSMcdKcem3HgEAM+VzJj0Xh
6OScN8VSIp7GSUrjDZwm
=juIW
-----END PGP SIGNATURE-----

--tfaCjp4mryZ5LVvS--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
