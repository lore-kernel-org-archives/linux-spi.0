From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [Patch V2 1/2] spi: imx: add lpspi bus driver
Date: Mon, 21 Nov 2016 17:24:15 +0000
Message-ID: <20161121172415.vtx7gahbzfgxconf@sirena.org.uk>
References: <1479216831-8709-1-git-send-email-pandy.gao@nxp.com>
 <20161116173228.cqtt5j5eczgg26gn@sirena.org.uk>
 <AM4PR0401MB1780CDE562EEA1CE202E9572F6B10@AM4PR0401MB1780.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mh7ev3k5wmticu4c"
Cc: "robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Frank Li <frank.li-3arQi8VN3Tc@public.gmane.org>, Andy Duan <fugang.duan-3arQi8VN3Tc@public.gmane.org>
To: Pandy Gao <pandy.gao-3arQi8VN3Tc@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AM4PR0401MB1780CDE562EEA1CE202E9572F6B10-4rsfagO7TJzc3fSXliz02I3W/0Ik+aLCnBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--mh7ev3k5wmticu4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 17, 2016 at 09:55:41AM +0000, Pandy Gao wrote:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> From: Mark Brown <mailto:broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> Sent: Thursday, November 17, 2016 1:32 AM

> > Why are we not also unpreparing the clock when the driver is idle?

> I use clk_enable()  rather than  clk_prepare_enable() here to avoid
> potential sleeping in runtime cause by clk_prepare().  clk is prepare
> in fsl_lpspi_probe() and unprepared in fsl_lpspi_remove().

It's absolutely fine to sleep in runtime PM and in the SPI hardware
prepare and unprepare.

> > Why are we doing this linearization into a single buffer?

> For a spi  transfer transmitted by lpspi,  the clk for the last bit is
> incomplete.  The last rising edge never comes unless  we manually
> de-assert SS.  In case that a spi message contains multiple transfers,
> SS should be de-asserted for each transfer.

> However, for spi device such as m25p80, SS should keep asserted during
> a whole message.  So we need do this linearization here.

And the hardware can't do any kind of scatter/gather?  There's two
things here - one is the combining everything into one hardware
operation which isn't that uncommon a limitation (though obviously it's
disappointing) and the other is the fact that in order to do this
everything gets copied into and out of this one buffer which obviously
adds quite a bit of overhead.

--mh7ev3k5wmticu4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYMy2/AAoJECTWi3JdVIfQ7c4H/2a0JcwXmVcZZbNi7qv3ekfC
Jv12+O/zado6/eN/w1QXoC18EFQVBdVOvEqNZuTx4NWjtMaKlw/9E4f+jNm3+hBL
msX4YT5oLZ7/rwOjzsxJPEuMNVb0/QjR/xQdv/52k7jLFIvrtrVGtw7b5ZhEu+1+
bCK2cdrkAqYYVw/RWOCZT+JLL+XZYZQTRjyj8ogqTTR75KYUPfPIBxkXjU4SQVSS
0GTPBlTfFkElZAd6AOALDoeCeazfS7TCekHuCYHscQuvL2EwMZ5uDDOmLcpE2Dl1
A5RHa0V7NvWMe9VzcXWdTIYw0IcMWdbSfjFpu2wjJpMoYSAvOKpA+Sm+vvDHRtM=
=yeys
-----END PGP SIGNATURE-----

--mh7ev3k5wmticu4c--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
