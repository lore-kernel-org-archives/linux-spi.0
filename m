From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC 2/2] spi core: Add new sysfs 'num_chipselect' file
Date: Mon, 18 Apr 2016 13:14:30 +0100
Message-ID: <20160418121430.GA3217@sirena.org.uk>
References: <1460978308-8062-1-git-send-email-bhuvanchandra.dv@toradex.com>
 <1460978308-8062-3-git-send-email-bhuvanchandra.dv@toradex.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1ozVqH6bFr/3sC51"
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, stefan-XLVq0VzYD2Y@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Stefan Agner <stefan.agner-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
To: Bhuvanchandra DV <bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1460978308-8062-3-git-send-email-bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--1ozVqH6bFr/3sC51
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 18, 2016 at 04:48:28PM +0530, Bhuvanchandra DV wrote:
> Add new sysfs 'num_chipselect' file to expose the maximum number
> of chipselects a SPI master can support.
> This allows to create a script in user space which automatically
> creates a new spidev instance for every chipselect on a bus.

This does not seem like a good idea, even if a chip select is supported
in the IP that doesn't mean it's brought out safely on a board and
pinmuxing may mean that the set of chip selects that can be used is
sparse.

--1ozVqH6bFr/3sC51
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXFM9SAAoJECTWi3JdVIfQ1Q0H/iMSAujby1d2bQ+QPcTil+Li
WZjl3QRdwwlDuftd4gww12j/KcYeXH+A8kY1aAsPC/uEokMxYYS1oZglBdh5bYoI
1+dfewldFWWx2+LOEvsZ5/F+5lGgV9HN1iVO7ij9NmrB6D6hf1IwbL4kS3waEQLz
nRqB40b4I6Bqo4eV1R/A7D0prdrZviixMXLy3w6ataEJTSFuHGwUZ5a9R1ZLpN1H
NtDydRn5sxr05IUh8FU/ufwHQuLYvgTgBfWACGkBJpAQ5TxLkYO6yJ1H2+Us44+1
5remg78tJxFKv6baVzFODuT1LXRXUzXagqTlhypv+y25MTrbZ5Hl1RzOSDsjJQY=
=0XLl
-----END PGP SIGNATURE-----

--1ozVqH6bFr/3sC51--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
