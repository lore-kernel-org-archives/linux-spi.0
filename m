From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: davinci: support adding delay between
 transmission
Date: Mon, 8 Sep 2014 15:39:56 +0100
Message-ID: <20140908143956.GL4015@sirena.org.uk>
References: <1408634706-5762-1-git-send-email-grygorii.strashko@ti.com>
 <1408634706-5762-3-git-send-email-grygorii.strashko@ti.com>
 <20140821182035.GM24407@sirena.org.uk>
 <53F74695.3010902@ti.com>
 <20140822150644.GX24407@sirena.org.uk>
 <5409C704.5070303@ti.com>
 <20140906143113.GI2601@sirena.org.uk>
 <540DAF91.6090002@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rwgQ89ZNnFUwFHTC"
Cc: santosh.shilimkar-l0cyMroinI0@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	m-karicheri2-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <540DAF91.6090002-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--rwgQ89ZNnFUwFHTC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 08, 2014 at 04:30:57PM +0300, Grygorii Strashko wrote:

> I'll split this patch and first introduce WDELAY, C2TDELAY, T2CDELAY
> (with updated documentation).
> The only question is - Should they be somehow common or specific for spi-davinci?

If they don't have any impact on the device at the remote end of the
link then making them device specific is fine.

--rwgQ89ZNnFUwFHTC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUDb+3AAoJECTWi3JdVIfQwXUH/R1UsOJfdE5xKgajiOSfKPC8
8PT9MkwnBoE0/YWY8ljzOBZ2LVgayyNK8pcCc7eiu/m+TtOHIJINt5wCrBtmcIlf
fQ+SiJ9mVsZeSWLdv64x8JY9eDi4rjogBuEfeoHTQiRERfRYp8ucjUq04tdCCxxM
hvBkFpYgD6iJnPkkSzRUEXG5z9B5UomvWWTsWyp88n9MpAundf9cF9OpUdzBFGCY
xCgWY6XflYheG88DHXG00MqCCwXnBWXFvgDOtFW7lk56I6cd2Q5RL9gIU4AXv8AD
xB4mmO+8vvwchYQ5px1UkIqIWB2tMtzo7vsWK9ghfPgqyWWKfr1BI0h/wdg8r2s=
=zw4N
-----END PGP SIGNATURE-----

--rwgQ89ZNnFUwFHTC--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
