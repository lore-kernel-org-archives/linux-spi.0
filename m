From: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 21/27] spi: omap2-mcspi: use
 pm_runtime_last_busy_and_autosuspend helper
Date: Wed, 24 Sep 2014 22:09:31 +0530
Message-ID: <20140924163931.GU24663@intel.com>
References: <1411575342-31048-1-git-send-email-vinod.koul@intel.com>
 <1411575342-31048-22-git-send-email-vinod.koul@intel.com>
 <20140924165855.GK16977@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6Vw0j8UKbyX0bfpA"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, subhransu.s.prusty-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140924165855.GK16977-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--6Vw0j8UKbyX0bfpA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2014 at 05:58:55PM +0100, Mark Brown wrote:
> On Wed, Sep 24, 2014 at 09:45:11PM +0530, Vinod Koul wrote:
> > Use the new pm_runtime_last_busy_and_autosuspend helper instead of open
> > coding the same code
>=20
> You haven't CCed me on anything earlier in the series so I've no idea
> what's going on here but it looks like there is probably some
> dependency?
And thats very surprsing :(

I used the Wolfram's cocci_cc script to auto cc and add everyone to cover
letter . Looks like it missed some. Sorry about that I should have been more
careful

FWIW here is cover letter https://lkml.org/lkml/2014/9/24/862

Thanks
--=20
~Vinod

--6Vw0j8UKbyX0bfpA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJUIvPDAAoJEHwUBw8lI4NH2A0QAKfmNRQwNx8qA6ctkD+H+sWB
9X9AksVTsVje/1PB8qhkdCp2JM/wd97CBJdlJLbRzck4rw5aXGKtdtmalQB3F8/6
mD1OvqVJxF4WP35xQdGvNJAT7ZmnOMWsvMc6HF0T4+rgd45gSWRdKVZl+T2cs7hj
UkLCK+RxdJbR5ZW84/3doHI1a4NMHmSBB/aRbMyYDBgTsybkhgA14uEIQOMrVxp7
dEiQmSN6T/uiYAxII5DyzOpp8iuMmPFl8U5twmQ3lnPVK/CfR9m2LIu2vRhtIpbR
g+MlvKzLwbnsUuZbOEWQ11bj+y14krO5TxAIRPYZWFasbKHiAy0xCiSmHt4imv/v
FOYi4xb/GtMRYCU6vYWmMo8UzHoexrlJO83TL4KaMfwfByoP2Z+p7tzSYp2bpaZV
gQrATpL0cMn79QaXSc3qc7xaUzQCjK6jz9P7M0RwldbjSg1fW1OkiGmKbViG2P9V
bEkJJS2foN+Kx+IPiAwmthnKFX97uANxB065ZBqXV+JzRaCfbcCijFs+iwVvIzmW
Y/EUTvOU5sbnw9BBVPv/2tkeDDoeU3CN0ODIarbTblBVq7knTefoaVYS6qGB3Hv7
F7uAypLKWV6UW7vpS7jXweBio6s/Xw0nlHq8BTkItKvPsSidjDhCA1ns8T0WtMLH
F9xM3OXDD+F0JhMeCRrG
=XSZK
-----END PGP SIGNATURE-----

--6Vw0j8UKbyX0bfpA--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
