From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Re: dw-spi driver bus number
Date: Thu, 11 Aug 2016 17:40:27 +0100
Message-ID: <20160811164027.GW9347@sirena.org.uk>
References: <019c75c3a7b841eba898ca3542f2b5c9@CWMAIL-AP-F14.dji.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wfgmFf0LjPE7xkRl"
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Edison Chen <yongsen.chen-dS4nfl7sBO4@public.gmane.org>,
	Fang Yingju <yingju.fang-dS4nfl7sBO4@public.gmane.org>, Flare <jiaquan.su-dS4nfl7sBO4@public.gmane.org>
To: First Light <xiaoguang.chen-dS4nfl7sBO4@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <019c75c3a7b841eba898ca3542f2b5c9-wl3m2YU9F6jCyPUpEMH5pa0bRtRcJeJQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--wfgmFf0LjPE7xkRl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 11, 2016 at 01:13:27AM +0000, First Light wrote:
> > On Wed, Aug 10, 2016 at 08:50:08AM +0000, First Light wrote:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> > That shouldn't happen, if it does it's a bug - users should never see a negative
> > bus number, the core should dynamically assign one if it is given a negative bus
> > number.  Can you check what happens in spi_register_master()?  That's
> > where the dynamic bus number should be being assigned.

> [First Light] I'm using linux-4.4 kernel, and In spi-dw-mmio.c,
> I see that:
>  LINE74: dws->bus_num = pdev-->id; (dws is struct dw_spi, not struct spi_master)
>  LINE107: ret=dw_spi_add_host(&pdev->dev, dws);
> spi_register_master is called in dw_spi_add_host.
> So dws->bus_num is not dynamically assigned, but just one static value since pdev->id is not inited.

This doesn't matter so long as the default value passed into
spi_register_master() is negative.

> I think you are saying spi_master->bus_num is dynamically inited. Right?

Yes, but by spi_register_master().

> I also see that spi_master->bus_num is inited with dws->bus_number first, and the it finds that this bus_num < 0,
> then uses of_alias_get_id or atomic_dec_return(&dyn_bus_id) to get a dynamic one.

> Question is: do we need to update dws->bus_num again? It is -1 always.

No, just pass that into the core and the core should take care of
things.

> unlike other devices, like i2c0, i2c1,..., spi's device name is dw_spi65535,
> both of the spi devices I registered have this name. 65535 is -1.
> There must be something unmatched.

Please trace through the code and try to see where this is happening,
this doesn't seem to be affecting other users.

--wfgmFf0LjPE7xkRl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXrKp6AAoJECTWi3JdVIfQGm8H+wQbH7nzBStD24WdiCmggN+m
zn42xXkWdkiZnVbnc20nltwqZQ3aCg84c8Chg3UX6imcFZ7MCES0w3qs0WsmNxE3
SB07beoQj7MyXp4+KHFLwxjB5/PYm3QF1hIqRRTbH8o27WXu2eIwdkf1X4qsGFPW
9/Pqv3IwMbb3OPL1+9UTrZfjxqs2c+wPL4Z2tECpNNlfywU8vw4CrJHfF3I04uUa
SKQH38tXqCSNbGjVBkZirLYt9CSTk9akcy9BpbF+OFq5hwi5I2B07AtHO25VPzq0
+NML4FkqeEzqmXKf3uhRcixOrbE28z5+9FoS90NCHrEP9Wre94hnLRsUft8JZ/A=
=S/TZ
-----END PGP SIGNATURE-----

--wfgmFf0LjPE7xkRl--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
