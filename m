From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: core: Do not mangle error code from kthread_run()
Date: Thu, 4 Dec 2014 22:42:47 +0000
Message-ID: <20141204224247.GD11764@sirena.org.uk>
References: <1417683745-26349-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T7mxYSe680VjQnyC"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1417683745-26349-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--T7mxYSe680VjQnyC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 04, 2014 at 11:02:25AM +0200, Jarkko Nikula wrote:
> kthread_run() could return ERR_PTR(-EINTR) from kthread_create_on_node().
> Return the actual error code in spi_init_queue() instead of mangling it to
> -ENOMEM.

Applied, thanks.

--T7mxYSe680VjQnyC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUgONnAAoJECTWi3JdVIfQLjEH/iNn3jCx0jEklSruI8OspxUc
u2ftdFFH/1pW3+5/UYxJccaxxUXx4rGYArshaBq0sP4CWxPjjMpLCBAafGr+chag
nMqy2ewj9Y4LpReK5N9OKOr1EwoAAVNSeM+6iKdC09IPb9aToA/4kwMTNLEj69G6
i4o3j4Es6eAemsWdWIRM5HI8+oaJv31WAZ7IQvxFSvViHfdqTp8OpJekRQzojxM5
CPUK692lVUTyqKZghIT/jneMLsz1nsIR6wDDJvF6ofCpCASNYyAil0X246ImwknH
JiBiC+Elk2j0cOVfMxvPflw7xO5gZlb3+enV6jyj0Czh75+7BC8CFJHFZPdLj4s=
=43IU
-----END PGP SIGNATURE-----

--T7mxYSe680VjQnyC--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
