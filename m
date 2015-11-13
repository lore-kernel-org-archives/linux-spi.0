From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: spidev locking ("spi: spidev: fix possible NULL dereference")
Date: Fri, 13 Nov 2015 17:28:34 +0000
Message-ID: <20151113172834.GS12392@sirena.org.uk>
References: <5645FE28.3070501@oracle.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hOmQO3H5Qmmwdmk8"
Cc: Sudip Mukherjee <sudip-ofJRbWXBVFamYgehrs7/Lw@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vegard Nossum <vegard.nossum-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5645FE28.3070501-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--hOmQO3H5Qmmwdmk8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 13, 2015 at 04:13:44PM +0100, Vegard Nossum wrote:

> spidev_remove() potentially sets spidev->spi to NULL, and this happens
> with the spidev->spi_lock taken, but without the device_list_lock mutex,
> and spidev_release() only takes the device_list_lock mutex for the
> spidev->spi dereference above, so presumably it is possible for a new
> caller to set spidev->spi to NULL while spidev_release() is in progress.

> I think it would be great if somebody who knows the code could have a
> look into this to see if there is indeed a problem, and there could be
> some comments added to the code to explain

There's definitely a potential race there.

> 1) why it is (not?) okay to check spidev->spi without the spinlock there,

> 2) why the ->spi_lock is not taken inside the device_list_lock mutex in
> spidev_remove(),

> 3) what are the potential interactions between spidev_release() and
> spidev_remove(), if any,

It's not safe to use spidev->spi there without the lock.  We're safe
otherwise because in order to have dereferenced spi elsewhere we must of
neccesity have a users refcount so spidev can't go away.  This is all
fairly standard really, it comes back to the issue Laurent was raising
on the kernel summit discussion list about not having helpful
infrastructure for managing lifetime with respect to both device removal
and files.

--hOmQO3H5Qmmwdmk8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWRh3CAAoJECTWi3JdVIfQ0LQH/iqYe/Ww1qd+iGGNvfTd94sp
fTTehO8Ynhn2GGTorPTqMGG3FchP3mubQ2hEDeIPbwU0Rfdn1A4ZjDd0nDg5oDfm
9taVygZ24uw9wofXFhjL/kZ+camPL5iY0UG0mBgEdbzJ4FgxNaYe84SQUcwEIPfV
Za8K7kLfxx5cdBAJNGTC5RcS1hpEpp9Cru9NN4z8cF9R+8L/Dir52h8cosWE7Qj3
bBhICKXh8Azz18+7WqMgggeRi5xelEOLwUQhSlwD04DrvjZjxH/8Iuhq9qkDhxK2
b9vkMPjg7PRFxj6Gs4sHEnmVG1RZougbE2Jvs6jgWuxffZaSja5BiuWdHj756ok=
=CL4H
-----END PGP SIGNATURE-----

--hOmQO3H5Qmmwdmk8--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
