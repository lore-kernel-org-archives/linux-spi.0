From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 21/27] spi: omap2-mcspi: use
 pm_runtime_last_busy_and_autosuspend helper
Date: Wed, 24 Sep 2014 17:58:55 +0100
Message-ID: <20140924165855.GK16977@sirena.org.uk>
References: <1411575342-31048-1-git-send-email-vinod.koul@intel.com>
 <1411575342-31048-22-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mGCtrYeZ202LI9ZG"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, subhransu.s.prusty-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1411575342-31048-22-git-send-email-vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--mGCtrYeZ202LI9ZG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 24, 2014 at 09:45:11PM +0530, Vinod Koul wrote:
> Use the new pm_runtime_last_busy_and_autosuspend helper instead of open
> coding the same code

You haven't CCed me on anything earlier in the series so I've no idea
what's going on here but it looks like there is probably some
dependency?

--mGCtrYeZ202LI9ZG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUIvhOAAoJECTWi3JdVIfQDaMH/130+TFZCEsIoVdMG2FNoNG5
8jdVavVu41kYH30h3NbB6SJ5/84NL2IjUkzOTxbLgOPBsaYNzpDrPPE7QDX8IkKW
oHrTtzNVv0NamzLyYWZ+fgwS+TaB+buL8bMMhe3xe9D71iZr0rEYoWuA+rNyZ7gv
y9NunQDC3jW9HFfpB+QTnd0IVLLhdu8W/RK0pXLWuo+Vb+hCaTw/pt1SsSD8ISEQ
Jwj4I0d3d7tFIFYnY3VGZlFdcn/gkcBXpMf3WiSBEA0Ksq/8OR2/DkdZg9Bhc/6k
3cf5kjmgI7lh3nJamj/Y7nJjOZT6Y9Pxy/5i1yMWeDBw85LuVLavtOifG/Rd2t8=
=+L+i
-----END PGP SIGNATURE-----

--mGCtrYeZ202LI9ZG--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
