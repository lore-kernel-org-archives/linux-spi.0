From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [LINUX RFC v2 1/4] spi: add support of two chip selects & data
 stripe
Date: Fri, 4 Sep 2015 16:37:18 +0100
Message-ID: <20150904153718.GO5313@sirena.org.uk>
References: <1440570367-22569-1-git-send-email-ranjit.waghmode@xilinx.com>
 <1440570367-22569-2-git-send-email-ranjit.waghmode@xilinx.com>
 <20150903121232.GW12027@sirena.org.uk>
 <E4C1DE94-773C-498F-9CD5-639FBEEE3139@sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="44EoV7tf2AX9r8hV"
Cc: Ranjit Waghmode <ranjit.waghmode-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org,
	computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org,
	soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org,
	marex-ynQEQJNshbs@public.gmane.org, b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org, knut.wohlrab-V5te9oGctAVWk0Htik3J/w@public.gmane.org,
	juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org, beanhuo-AL4WhLSQfzjQT0dZR+AlfA@public.gmane.org,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, punnaia-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org
To: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <E4C1DE94-773C-498F-9CD5-639FBEEE3139-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--44EoV7tf2AX9r8hV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 04, 2015 at 02:35:52PM +0200, Martin Sperl wrote:
> > On 03.09.2015, at 14:12, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > This isn't saying that the controller supports more than one chip, it's
> > saying that the controller supports asserting more than one chip select
> > at once which isn't the same thing.  I'm also not entirely sure that
> > this makes sense as a separate feature to the data striping one - I'm
> > struggling to think of a way to use this sensibly separately to that.

> Well - there is one use-case that I can think of:
> fbtft has the requirement for some devices to control a GPIO to
> differentiate between command and data getting transferred
> - sort of 9 bit.

That's another thing again, isn't it?  It's one device switching between
two different control interfaces at runtime rather than two devices
controlled in lockstep.

--44EoV7tf2AX9r8hV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV6bqtAAoJECTWi3JdVIfQSWAH/RyMGYvMDGzkghmldJhBGlIe
znV2if8kHCD8A+HmG0ARvY/7DWz0qX3SAJoiGXhacIIN/cGBIdvzpeQ9JJQfH6oM
vnY7BZHZTP399C15beITAHiX7f4IlEnvlwbCOKDRKAhd4h4Aq1BhiKjM2ZvTmxH1
q5eI0cc7CHRPt1eMczPhh64tvYlA81L/N2+zqDedWjDf+ddGdoUv/3JwRTgTUClX
53atP1Jh7wYLRrao5T0SAwlkYz/JQRvxxwf1lah3dpB1bmFyHfRUBW1N/NG66fnn
Ca9dDuXEu+AZ+Ph/sUbqs3vitGZ0cdAqm3EpV4M9iDOKz/J/s7auV+zWuG++Kr8=
=eRVV
-----END PGP SIGNATURE-----

--44EoV7tf2AX9r8hV--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
