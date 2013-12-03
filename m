From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 27/39] spi: remove DEFINE_PCI_DEVICE_TABLE macro
Date: Tue, 3 Dec 2013 18:04:30 +0000
Message-ID: <20131203180430.GI27568@sirena.org.uk>
References: <001501ceefb1$69c96820$3d5c3860$%han@samsung.com>
 <003001ceefb5$c418c600$4c4a5200$%han@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="48DfXVLS5QXSkCLu"
Cc: 'Greg Kroah-Hartman' <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <003001ceefb5$c418c600$4c4a5200$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--48DfXVLS5QXSkCLu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 03, 2013 at 08:25:19AM +0900, Jingoo Han wrote:
> Don't use DEFINE_PCI_DEVICE_TABLE macro, because this macro
> is not preferred.

Applied, thanks.  It's on a topic branch by itself so I can easily drop
it if we decide to do something else.

--48DfXVLS5QXSkCLu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnh0rAAoJELSic+t+oim9GC4P/Rw8raDhr206VlAvoJdTOCXR
auyX6BQMhxgC4rBRUTH8SVXl8orVFzPFBnkeDvZHBFV5j+YbiG1CV7eJvJ5Eu2xu
qcQAmvt0FNWvy3Gr39MfvMLI4rGoz1a0P8BI6A24/gDHNlntCcDJTgCSeNUUD1/U
WXQqttCYJvS1HtEbIZhC/H4Ep065rNWrhscNC8J/dqCTrBmpU4Ufyivryly6FNgG
M6OgPOB5O0Zab79R3YlkfLWQGudw8bdPzCaa4uaZjMmITnSax7xVivNEbo1rMyip
chigavIra1pTLXlG3m4DV1EOwlSj3heF4Leg+N2bUquKsDsNp1lx8foCY7aQDPnS
9zKYGJKd0QMr3uPiO/82BYn9s1ApfmdyG+VKaO6pq8BVJ9Tt2rRK8YvxUuYxBtBs
cIShJs8in76GWq47EFq27exPko8rTbd1gkye38PKAv4+WZQOodU6zh7cCTF55Je1
ps3UtwEUh7jplycHSaF3RyL/XW9e7k1NnbA9STblW1MOS/k6K1Uuub7CdmS+n7RK
Okztb8KcgqIhmmrQmPu3sLW8VGH5DMEfakl7+tgL2q1UoCvGLfmjSUyTbmYxcxmW
tR92v4ONCJqEUzJYrBP9akdcNe5JgtIr1cj3GhX2IjwfxZfk5NWVxowrjOm+erfb
GENRPH1hYqYfxGO0jDV0
=wXhR
-----END PGP SIGNATURE-----

--48DfXVLS5QXSkCLu--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
