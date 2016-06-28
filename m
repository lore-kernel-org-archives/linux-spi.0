From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RESEND] spi: spidev: Allow matching DT compatible strings
 from ACPI
Date: Tue, 28 Jun 2016 16:07:52 +0100
Message-ID: <20160628150752.GO17217@sirena.org.uk>
References: <1467027248-6191-1-git-send-email-mika.westerberg@linux.intel.com>
 <20160627122448.GU28202@sirena.org.uk>
 <20160628092234.GG1711@lahna.fi.intel.com>
 <20160628114742.GM17217@sirena.org.uk>
 <20160628143528.GK1711@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NKtYx2Ppz7d1tORf"
Cc: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160628143528.GK1711-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--NKtYx2Ppz7d1tORf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 28, 2016 at 05:35:28PM +0300, Mika Westerberg wrote:
> On Tue, Jun 28, 2016 at 12:47:42PM +0100, Mark Brown wrote:

> > The big thing I need to check out here is if this breaks the check for
> > directly listing spidev in DT so we end up with the same abstraction
> > failures that plague DT since people refuse to describe their hardware.

> You are talking about this check, right?

>         if (spi->dev.of_node && !of_match_device(spidev_dt_ids, &spi->dev=
)) {
>                 dev_err(&spi->dev, "buggy DT: spidev listed directly in D=
T\n");
>                 WARN_ON(spi->dev.of_node &&
>                         !of_match_device(spidev_dt_ids, &spi->dev));
>         }=20

> As far as I can tell it should work, with the patch applied, just as it w=
orked
> before. For ACPI there is no possibility to list the node directly in ASL=
 code
> as we always require DT compatible string in _DSD.

Yes, but does of_node get set and does of_match_device() DTRT if it's a
DT into ACPI device?

> In other words we never match using name of the node.

If that's the case then it's definitely broken - we either always warn
or never warn, neither is good.

--NKtYx2Ppz7d1tORf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXcpLHAAoJECTWi3JdVIfQBcYH/A0oiKVdIybbIboxmuwmq32x
yItydwe7c2EBxg0dPZ2gS6466IsQqALzaD0E2pYDsxuMNUjOOLE6ozlEkQ9nfTzm
zA8ISCjt3ebuezazNesh4HiRM6up8wiYW/ueeTXgGjYG+3tnVpcWlM4mgCDCCkej
cIpwHzvYbW2Ze0WJ1SbA4vrZ57ZHOuIgXe0pqWJtDF6Vo9gbRhQEH5/9CHGXFwxn
xrpsEwu/zcVTQwpx2TOd3HtO1MhNrL9267OmAEN9DWzM8c2kJcxHvwcMhhvT5X0S
U/2mm4F1h79xTfLRF15l79D5TLBmQswn571v6RvxJsawIcrp53fax2xg0GCwG3o=
=sRxa
-----END PGP SIGNATURE-----

--NKtYx2Ppz7d1tORf--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
