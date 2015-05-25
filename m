From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH spi 1/7] spi-tegra20-slink: remove duplicate check on
 resource
Date: Mon, 25 May 2015 15:08:06 +0100
Message-ID: <20150525140806.GX21391@sirena.org.uk>
References: <1413885950-24208-1-git-send-email-varkab@cdac.in>
 <544F22C8.8040106@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZlyDGGI/Hohreivc"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "varkab-If5XQcfNmg0@public.gmane.org" <varkab-If5XQcfNmg0@public.gmane.org>
To: Varka Bhadram <varkabhadram-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <544F22C8.8040106-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--ZlyDGGI/Hohreivc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 28, 2014 at 10:29:52AM +0530, Varka Bhadram wrote:
> On 10/21/2014 03:35 PM, Varka Bhadram wrote:
> >Sanity check on resource happening with devm_ioremap_resource().

> >+
> >  	spi_irq = platform_get_irq(pdev, 0);
> >  	tspi->irq = spi_irq;
> >  	ret = request_threaded_irq(tspi->irq, tegra_slink_isr,

> Ping...

Please don't send content free pings, and always send patches to
maintainers as covered in SubmittingPatches.

--ZlyDGGI/Hohreivc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVYyzGAAoJECTWi3JdVIfQgyEH/R9znbzrIRPKEnEXjQOiUrqI
aEyf9sAXqpEQl5iByk1h/U8mlmH01V/pFzmyY1KQEztv0T/fOpghnVKr9ybX2p3A
ggBOo42rRaE3kI3zewo4gHDFini76RJkZ4o6rzmpME2tFefRdNfViiZZayeGYiRl
VG3yzYJ5TWS/eO3/FqsOKwVltaMqo+5dg6/JUC94Sh3C8RBr0CZd3LAgIFg+WbKJ
4/Ai/40fuLMIpBZLf6/sW8E1eFbovv8sxNBvbz2VvvIDXI5ZmAIonfndkwY8thFV
km0gtYgIJnbl4kEfAm/4EhXd4t2IeEXt77ZZlAa4N6QpnOTTqezADNGZ42eD9Vg=
=hYks
-----END PGP SIGNATURE-----

--ZlyDGGI/Hohreivc--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
