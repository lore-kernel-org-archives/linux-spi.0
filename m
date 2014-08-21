From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: davinci: support adding delay between
 transmission
Date: Thu, 21 Aug 2014 13:20:35 -0500
Message-ID: <20140821182035.GM24407@sirena.org.uk>
References: <1408634706-5762-1-git-send-email-grygorii.strashko@ti.com>
 <1408634706-5762-3-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1f1tNaDgxoBnXskx"
Cc: santosh.shilimkar-l0cyMroinI0@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	m-karicheri2-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1408634706-5762-3-git-send-email-grygorii.strashko-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--1f1tNaDgxoBnXskx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 21, 2014 at 06:25:06PM +0300, Grygorii Strashko wrote:

> +- ti,davinci-spi-wdelay : delay between transmissions.

I don't understand why this is here - there is already standard support
in the SPI core for client drivers specifying inter-transfer delays.  If
there is a need to provide platform configuration for this in addition
to that then it should also be a standard property, there is nothing
device specific about these.

> +- ti,davinci-spi-odd-parity : odd partity enabled
> +   OR
> +  ti,davinci-spi-even-parity : even parity enabled

What do these mean?

> +- ti,davinci-spi-io-type: io type (check platform_data/spi-davinci.h)

The bindings should be independent of the kernel, the values need to be
included here (and the defines moved to include/dt-bindings so they can
be used when writing DTs).

> +- ti,davinci-spi-disable-timer: disable CS timer (SPIFMTn)
> +- ti,davinci-spi-c2t-delay: c2t delay
> +- ti,davinci-spi-t2c-delay: t2c delay
> +- ti,davinci-spi-t2e-delay: t2e delay
> +- ti,davinci-spi-c2e-delay: c2e delay

What are all these timers/delays - at least some reference to the
datasheet please?

--1f1tNaDgxoBnXskx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT9jhwAAoJELSic+t+oim96wkP/ReX0hFwObinVqEhKGscQhAT
/US3zqZPHGxVIOclnYISiHfbSCaQ5z/wyt9bMYzyZmDrS+gdx1iXW8U2s1PcRGh9
cF9MaoQwk2LbeHSkwJOSTIOX+bPL49mlebqBBj4xuQoOsEmxjogZdgUcUG3qpb5Q
8bMAkIiV87xBaJCMsfjD96XZjB81isfRWEe+mp3B1Kk0OGbEculR/K1PNLq1CDSJ
2RISS+nkFgDwikES6pwSc4+jKKx8ubm1Yt7x66jETbJ1J7kkoN9qaAiHMcRthJor
IxeDEKVF754n1lRWk6W4FGrdomAJv+Sz4AflIB7drRvjko6eIa/+JVqtYBtuBDHC
HgRqGIaKaOjvQNBF0kO/SpA4e8Tj2EAq+l0DWcAmApg0W8kI8LZQsmZ/atxLpMwO
1FUexpQV1OO2h4g2nFe06dNCwxJ83XaUA/rWhuOl4DHWGRDZOKOtK8S5WPFY1pxo
hns11eIT8l8ht0DFsxVGLOrL9L9NMYG7MJj7snwbNp0/aWMnkYAiuCPAQVBufKrC
mlN6LmuYO01pCvyTwPhZQI4DJ5zslucQFc6iHR36BI+K0OTMMv/K4siyl/G+n7oA
kItRqnGgAlFJHlC059GLjhEVz3zPEIXXJk6tkLeL+Fy1Xuhp8SqT2ou1PscOS5vW
zHMp+1iUHbMhaeaApa6U
=5BGf
-----END PGP SIGNATURE-----

--1f1tNaDgxoBnXskx--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
