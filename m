From: Maxime Ripard <mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 0/3] arm64: dts: sun50i: H6: Enable SPI controller
Date: Fri, 17 Jan 2020 19:24:16 +0100
Message-ID: <20200117182416.5y57aa6nwulztcot@gilmour.lan>
References: <20200116231148.1490-1-andre.przywara@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zxgtfc54oobnuhf2"
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200116231148.1490-1-andre.przywara-5wv7dgnIgG8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--zxgtfc54oobnuhf2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 16, 2020 at 11:11:45PM +0000, Andre Przywara wrote:
> Even though the SPI controller in the Allwinner H6 SoC is more advanced
> than in the previous generations (it supports 3-wire and 4-wire mode),
> the register set stays backwards-compatible. So we can use the existing
> driver to use the "normal" SPI mode, for instance to access the SPI
> flash soldered on the Pine H64 board.
>
> These two patches allow this by adding the SPI controller nodes to the
> DT. The compatible strings include an H6 specific name, so that any
> future 4-wire enhancements for instance would be automatically usable
> once the driver learns this new trick. For now we use the H3 fallback
> name to bind the current driver.
>
> This time I tested this actual branch  (on top of sunxi/dt-for-5.6),
> on a Pine H64, both the internal SPI flash as well with SPI flash
> connected to the other SPI controller available on the GPIO headers.
>
> As the SPI0-CS0 pin clashes with the eMMC CMD pin, we keep this
> node disabled by default, to avoid losing the eMMC if it probes last.
> People (or U-Boot) can enable it if needed.

Queued all three for 5.7, thanks!
Maxime

--zxgtfc54oobnuhf2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXiH70AAKCRDj7w1vZxhR
xTmeAP49nHNJa9zeo1OlCPzyy2qZK3R+gWNkj4KPdU33ab/+rQEA85fkrRDtIImN
woli9GP6PWrVOowW3vnovD0xbmYbDgc=
=/XyN
-----END PGP SIGNATURE-----

--zxgtfc54oobnuhf2--
