From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/4] spi: dw-mmio: prepare the clock before enabling
Date: Mon, 30 Dec 2013 13:25:58 +0000
Message-ID: <20131230132558.GB31886@sirena.org.uk>
References: <cover.1388040447.git.baruch@tkos.co.il>
 <1553b4e9cc24fb9fe1eb81b3ee77cdd2e1d3bc69.1388040447.git.baruch@tkos.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CdJmqRynzCmrDwyG"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1553b4e9cc24fb9fe1eb81b3ee77cdd2e1d3bc69.1388040447.git.baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--CdJmqRynzCmrDwyG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 26, 2013 at 09:00:13AM +0200, Baruch Siach wrote:
> This is required for common clock support.

This is fine but depends on the previous patch.  Consider moving the
clock management to runtime PM (the core has support for managing that
for normal transfers) so that it's only enabled when the IP is in use
which should save a little power.

--CdJmqRynzCmrDwyG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSwXRjAAoJELSic+t+oim9YMQP/3WJNzqWatRv1ZbpgqnqZQgw
aFQmNZjKrMzOjwOZvo+LRJWOXAxiW3DW8FtHRzTvyNPgUaHrF3k5VmOt7Fqy1FGb
la5+0Qe8sogkGmN+MD/GhIodyid31HGHI63MjUMHwuIls10FTt2RD6F8fDbGYJYT
K3RABdckAjNpEanUZDG/paw7UmM6Likl7iC2ojvcT6YUW1m5joQJjQ1QtFyJwPrN
Wkf8KCfktOAU8PpfPy0/9FPgXpd5N8xjwx4f9YJf0MLpIaQG5ARczwMJboMbcMVz
eZ4UmjqZIGZwxj80a3Rs4o5CduNUxfAfBGM+M8WDUsGAqBT+AcI5GdGMGgHwaCEq
VGrAzlyxIWcGy+R6NiJnQFJmvxEXvFcphfrPLXz8lwLqoaIjmjbQ9SGKkplH6W8f
veT4MVLfDWqU5GpO3SPIsL0O/1JDbrtGozfDu4r+2hUJUpKDb+psLaG0KcKyISJr
H44Gg9nOklBzp2Bz23J0BrTpeaVF6yMfyeG/5iJgvn76h7pjgmnAENfTMsWBYiHN
ORsdz6U8y9dzVKVI4sq+hOTL/FBR8z8hm+1J7uIHgPCeNqRTw1sAygQHt3lNCytm
x4dQ1LkRWDgAuzH5bZMfbo2UwGmhg+0NSxu5uexm92oZAU7znuKXRYj3Eog0KznB
Pi/oae6EquQZKgCBvFNR
=k5wm
-----END PGP SIGNATURE-----

--CdJmqRynzCmrDwyG--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
