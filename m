From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2] SPI: BCM2835: allow arbitrary GPIO to act as
 SPI-chip_select
Date: Fri, 20 Mar 2015 09:52:47 +0000
Message-ID: <20150320095247.GE2869@sirena.org.uk>
References: <1426755714-28130-1-git-send-email-kernel@martin.sperl.org>
 <1426755714-28130-2-git-send-email-kernel@martin.sperl.org>
 <550BAA89.5090707@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="B3XPdYri2NuANWBV"
Cc: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <550BAA89.5090707-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--B3XPdYri2NuANWBV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2015 at 11:05:13PM -0600, Stephen Warren wrote:
> On 03/19/2015 03:01 AM, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:
> > From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
> >=20
> > use cs-gpios for the spi bus master and standard gpio operation
> > instead of relying on the HW with just 2 chip_selects.
>=20
> A changelog between v1 and v2 would be useful. I think this looks OK
> though, so,
> Acked-by: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>

Note that none of these patches appear to have been sent to me, Stephen
has CCed me in as far as I can tell...

--B3XPdYri2NuANWBV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVC+3uAAoJECTWi3JdVIfQTE8H/janLisG6U+HUb/43oDN8S5e
USCqyuEtjLY0W1QE+A19qesTrDuARQDd66lMXvoqSLAh7gx6CnSs386T6vfI287w
rZMiFTxrybL4UVSq+10N3rXR2LVRDkwdffytXJIJdRu4W4tvHqPGL06hNrlSFU7K
pVn2fR/4rDR7GmEwvpO1jVL53a5JTseVfCnbpE1KEBwqyy3ccnaQaoG8Chqt6pBL
8cD+AI6cqFAPHY650tbUOpShpY0mtdlp3qLvnkPkkeWVcX7lCSAl+1dkvV4mb/r6
LzxRfI4dIMfSuYb/+ZtO0NjSl+O2S1gf5Cd1izCpHAESJRNFi0rxpIRVEIjRS9I=
=5BYm
-----END PGP SIGNATURE-----

--B3XPdYri2NuANWBV--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
