From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 6/6] spi: octeon: Add thunderx driver
Date: Wed, 27 Jul 2016 20:08:55 +0100
Message-ID: <20160727190855.GA11806@sirena.org.uk>
References: <cover.1469174814.git.jglauber@cavium.com>
 <f87d7a5ef8a713fb6e64c5d9471e7e5bf2051d18.1469174814.git.jglauber@cavium.com>
 <20160724210452.GB6345@sirena.org.uk>
 <20160725155122.GA2710@hardcore>
 <20160725161632.GD11806@sirena.org.uk>
 <57963ED3.4090402@caviumnetworks.com>
 <20160727181205.GT11806@sirena.org.uk>
 <5798FC86.8040601@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Qn4G1eBrv+t66M9q"
Cc: Jan Glauber <jan.glauber-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"Steven J. Hill" <steven.hill-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>,
	David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
To: David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5798FC86.8040601-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Qn4G1eBrv+t66M9q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 27, 2016 at 11:25:10AM -0700, David Daney wrote:
> On 07/27/2016 11:12 AM, Mark Brown wrote:
> > On Mon, Jul 25, 2016 at 09:31:15AM -0700, David Daney wrote:

> > > ARCH_THUNDER needs to die, so perhaps it should be (ARM64 || COMPILE_TEST)
> > > && PCI && 64BIT if you really want to hide it from non-arm64 kernel configs.

> > It does?  Why?

> It adds clutter.  If we build a generic kernel, we first must select all the
> ARCH_*, then go back and select the devices we want.  Not much of a value
> add.

The value comes when moving to a new kernel version and updating your
config or doing a new board - if you're building for a specific system
then you get fewer new driver prompts (especially if you've got a
smaller number of hotpluggable buses enabled).  This is the much more
common case for people doing kernel configuration, it did bother people
a lot in the past.

> Better to just directly select the devices and remove this middle ARCH_*
> layer.

It's one option every time a new vendor appears rather than every time a
new driver appears - it's a useful quality of life improvement for
people who are doing system customization that is fairly painless for
those doing generic kernels (who can just enable everything).

> Also who is responsible for making sure the proper ARCH_* constraints are
> maintained?  If we remove ARCH_THUNDER, no need to worry about this.

People using the devices or writing drivers...  this really isn't
particularly challenging and it's not like it's hard to fix if people
notice issues.

--Qn4G1eBrv+t66M9q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXmQbGAAoJECTWi3JdVIfQVnIH/0e8h6u1HqlwqR+GLZ0haihW
/3UDaq83XQmQfBMD9JXEUnztKV59gQPvel4vK7AdOFHyCORcwM9I8T1xtbQP2sXs
pIrsm1KIAYLBXPDfIoTjwiRHy+rjz7/1iNuhKarUc1k/f4FUnHwmbMp4lXJCBz9a
HwULPWuCJ+ipn+FdZyfx5ecok5PnWXx/QTaJdQuW8bLLEPO1KZiDK2nQPT1tKmpF
twuk/OAJE/KbwafJa3s2Kg39JdiNV6/miuEfGgWkCOntgeAW0aivbUcgDNZmFnoa
ucU7eE7ZKugBTrGwCLKhSKjviuGAcZv4gIbiL2Z3d/Yk/xhCcLHO9F2iNvRYIKs=
=vlYs
-----END PGP SIGNATURE-----

--Qn4G1eBrv+t66M9q--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
