From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH, V4, 1/5] Documentation: dt: spi-bcm-qspi: NSP, NS2,
 BRCMSTB SoC bindings
Date: Thu, 23 Jun 2016 10:26:44 +0100
Message-ID: <20160623092644.GS28202@sirena.org.uk>
References: <1466197433-11290-1-git-send-email-kdasu.kdev@gmail.com>
 <20160622145141.GN28202@sirena.org.uk>
 <576AC69F.6080507@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="psiTe9LjpVyD9953"
Cc: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, vikram.prakash-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
	andy.fung-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
	Yendapally Reddy Dhananjaya Reddy
	<yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <576AC69F.6080507-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--psiTe9LjpVyD9953
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 22, 2016 at 10:10:55AM -0700, Florian Fainelli wrote:
> On 06/22/2016 07:51 AM, Mark Brown wrote:

> >> +- compatible:
> >> +    Must be one of :
> >> +    "brcm,spi-bcm-qspi"
> >> +    "brcm,spi-brmstb" spi-nor and/or "brcm,spi-brmstb-mspi" unmanaged SPI Master

> > What do these compatible strings mean, what are the differences between
> > them?  The last two sound like configuration of a single IP rather than
> > descriptions of hardware.

> The Broadcom STB SoCs have two instances of this SPI HW block, one which
> is MSPI+BSPI capable and another one which is MSPI only (or that's how
> we call them), the difference in the compatible strings tries to denote
> and capture that.

The point is that we need some words in the binding that explain this so
people know when to use them.

--psiTe9LjpVyD9953
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXa6tRAAoJECTWi3JdVIfQ9wgH/iLjAhNJAMo43TGRHBg22hXl
wb/lMj2mqCYocra9xiq+00+aaM/0DdOcOotJPyeQjF67MZE6K1FKMkDT1v2bNn0U
pUp+6Ll3sZ23vOKCodQvP4yt2oj9H1UDiw2ysexipcE1hqPSgF+NHbAzWExg3lBk
OVJ59ZCOWuRDgJ0cN72wz8KPRRb69WLBtCiWupbfTDYz/etZM4ZHXLy4G9D7oHYb
dBHLYZGP9+4w9gdsJfLbOftQJN2dXwrujeC+ClyfV30c+PaKbBgeUb2z+HpFWnW3
mvXdkVN04c/8YHIKBduibDJWFbedo+anYKn/6hFiF+x3y7pbSBtbfps+CHWu0zE=
=x9pg
-----END PGP SIGNATURE-----

--psiTe9LjpVyD9953--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
