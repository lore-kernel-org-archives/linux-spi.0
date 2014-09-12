From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: SPI and module auto-loading
Date: Fri, 12 Sep 2014 11:14:42 +0100
Message-ID: <20140912101442.GR7960@sirena.org.uk>
References: <54119DB6.8020807@collabora.co.uk>
 <20140911193325.GT4015@sirena.org.uk>
 <5412C1DF.3040707@collabora.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6eUvXotnMb6+obQB"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org
To: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5412C1DF.3040707-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--6eUvXotnMb6+obQB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 12, 2014 at 11:50:23AM +0200, Javier Martinez Canillas wrote:
> On 09/11/2014 09:33 PM, Mark Brown wrote:

> > I'm not sure I see that as an interesting use case, it seems better to
> > have drivers usable without DT and it's trivial to do so.

> Yes, it's trivial but seems like an unnecessary duplication for me. AFAICT the
> OF tables are only used to match the devices in spi_match_device() but if both
> the OF and SPI tables must be kept in sync to properly report the module
> aliases to user-space then I wonder if the OF tables shouldn't just be removed
> from the SPI drivers since spi_match_device() will succeed anyways when
> calling spi_match_id().

The vendor identifier is an important part of the OF device ID, vendors
can and do end up with different devices of the same name.

--6eUvXotnMb6+obQB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUEseRAAoJECTWi3JdVIfQLgIH/3mMnuTYaQ0by3BYj4TI7PED
4Yttr0iYsNtUz/X070ERIAHgFULpgapFrOdTrdlCS4juYORZVVjYzQA0Xad6UMux
+4apRJ/k7/MkIt7HbR36gc+ADidmgFGGvLULMUezdjpvIVnO38w6AEMwdV33dofO
sdhc/GgcZGnQpKTdORBRt0i07Ql0vjEDDwoLqoHqBznAxoE7Zga7U643cPlwb9md
aZg+LAI8BmNaVVEp0vvpLDc+0nP1CcnMt3tDlhSATvqfBcHt/rl9+YFCzlBWK8gt
zt+B9s+T2Rm966QyVqa5/ICkHu9mCbzoWrpftRX2gGfxFSwwnARVcWA5TPabGck=
=sAgB
-----END PGP SIGNATURE-----

--6eUvXotnMb6+obQB--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
