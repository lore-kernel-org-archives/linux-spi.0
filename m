From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: omap2: use SUPERH, not SH
Date: Mon, 10 Feb 2014 12:34:54 +0000
Message-ID: <20140210123454.GY1757@sirena.org.uk>
References: <1391893281.19595.3.camel@x220>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cDkCB6tn7aZ2Gopm"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1391893281.19595.3.camel@x220>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--cDkCB6tn7aZ2Gopm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 08, 2014 at 10:01:21PM +0100, Paul Bolle wrote:
> Commit 0079aae0f1e6 ("spi: omap2: Add build dependencies for
> writel_relaxed()") added an optional Kconfig dependency on SH. That
> Kconfig symbol doesn't exist. Apparently SUPERH was intended. Use that.

Applied, thanks.

--cDkCB6tn7aZ2Gopm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS+MdqAAoJELSic+t+oim9f+8P/A7PuVwrsU1oCk9DkpwnDPiI
AguG7+yMLFG2d9tk6JJr5zImdpGxFNRpMStnj2UxQuqaktwXPQ1SsLUMqdqoHbqt
szK5Z6D7T7ZUehO8sqIB5H9YeCyIyPLnuASfc3xEtnGSWovBU5V/PxgS6z4RnKKJ
CW7c44JqmQB2qn6NXyQhZKveb/6qvA5oCHhGm2vWIwnEHP/HRv+l3WdUEyXv1V1J
X2KCcGSWqg3qn+olABqSHhdGvD1iyZ9tWJSrEMqNa0E8mVAoUNXKWmZvsIojYryo
GG4dpXGyjvHvr7BVuBRwYQzXF3otZMx7hofyz/ZjnBchVGs3HgPe4dK3HkTJEZQg
RHn7UMDssNGExVgWgHbJW2emvOZnGkllvE8KTvbt8aOFEgRAh/Mli4uKeh4tiL7Y
UCE6lXTtHg5cbXpE/qbgczBBz/XRmiRq0ThBKdrNdZPF2nOQeqZmaqW1QM513Iqz
3k18pBkudEhGEOtA4r0905aBVoOnJuGY0vGBhrKvfs0m4+bN1bSeuXLD3UUmr9xQ
TR3TWMvat9sFGB1C4cZanfmOIrCt9v724bXSHxexeb+XpqN3hQsOhTuZrN441uPO
Q4hViLw/HTx4vQL9dpAupm+jajYjuqkam1Yvl601gdXVADg+Ssfc1FLtvUQz/RNA
voDyRn1br+gPohoA9GX6
=gACo
-----END PGP SIGNATURE-----

--cDkCB6tn7aZ2Gopm--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
