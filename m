From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH] spi: add driver for BCM2835
Date: Tue, 12 Mar 2013 19:06:38 +0000
Message-ID: <20130312190638.GA19942@opensource.wolfsonmicro.com>
References: <1362538142-19246-1-git-send-email-swarren@wwwdotorg.org>
 <20130306040520.GA4896@opensource.wolfsonmicro.com>
 <5139815E.7020502@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0047860777639020381=="
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
 spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Chris Boot <bootc-1Slo4GeK4H1eoWH0uzbU5w@public.gmane.org>,
 linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <5139815E.7020502-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--===============0047860777639020381==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Hch1Uz/zGPcHFdv8"
Content-Disposition: inline


--Hch1Uz/zGPcHFdv8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2013 at 11:12:46PM -0700, Stephen Warren wrote:
> On 03/05/2013 09:05 PM, Mark Brown wrote:
> > On Tue, Mar 05, 2013 at 07:49:02PM -0700, Stephen Warren wrote:
>=20
> >> +	switch (bpw) { +	case 8: +		break; +	default: +
> >> dev_err(&spi->dev, "unsupported bits_per_word=3D%d\n", bpw); +
> >> return -EINVAL; +	}

> Is there an assumption in the SPI core that bpw will never be >32? The
> value is stored in a u8 in the controller and transfer structs, so
> large values are physically possible. So if there is no such
> assumption, then representing all of an SPI controller's supported BPW
> in a mask/list would be a little unwieldy, so doing central checking
> might not work well.

I don't think there's such an assumption, on the other hand such
hardware is exceptionally rare so it seems sensible to at least handle
the common case - for example, allow the driver to specify a bitmask and
if no mask is specified just accept anything and let the drive worry
about it.

--Hch1Uz/zGPcHFdv8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRP3y2AAoJELSic+t+oim9bhkP/j1zMhrbFWkIAEcG77dylHXu
vKVFlG7JySebA4gsfrbAQ0doxnTGCcfve0HRDJnLta89nns/0eoQTW8uC87PLvZS
dPgxPVyUrTEa5hX4Q7TwBEbBR6IzdenvAPw8M/1/4mcG0lkw7M0fFN2zMcESgHSd
6tHccYLwopS4D98wyd7LlhmDtV+/nSVxI2HUO0EGVS/BPtZYmNHGRa/rUSyYYIT7
qWO/QKqJUdOsBTrYFzuIOr8FRMf1l904AjOfYYY+fnQXvk+/LsSiOPURqsysofSh
kopWo0KuVb8nSUPoKbhoRcY/14ZEtCTPCsxc7DVnziK/xu2nkNGbu10dSxTOynGi
2NSRpmmymrTBDGqK5mBhnta2RamwMIAEPv9YGLjX+9WLgyBGJnTURghe4p2l76Wb
VA2eE0iuMgytzCfem3jUFFyHBsdn+wMJMhtxpk9BAwELBIDuWLxhKS4fV7LC0yNR
9tXTQLooCO7Y/uMDmg/URtNS/AMzg14eg4CpZfKWYMWFhnzksXrf1ckAzQrb575e
8318MN2h2RdMYJBuNhuIezNfeLS/gInpTZ+C0+oDAOLELPgrwmoKm9jD3BfsEPaN
sP0OgAzBw26DgqRiz07VCLVkhv+50M9+3EafWxhzn3fPMi51m48WNsxScPZVHavy
v3csses51/X4L/n78uDz
=Vp0b
-----END PGP SIGNATURE-----

--Hch1Uz/zGPcHFdv8--


--===============0047860777639020381==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-rpi-kernel mailing list
linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel

--===============0047860777639020381==--
