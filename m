From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: bcm2835: transform native-cs to gpio-cs on first
 spi_setup
Date: Mon, 6 Apr 2015 18:45:52 +0100
Message-ID: <20150406174552.GY6023@sirena.org.uk>
References: <1428340592-3196-2-git-send-email-kernel@martin.sperl.org>
 <20150406172913.GW6023@sirena.org.uk>
 <12F93D4D-EDCB-4F48-B42B-049ECAD7F5E8@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hDuGXNMqfWt9/5DW"
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <12F93D4D-EDCB-4F48-B42B-049ECAD7F5E8-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--hDuGXNMqfWt9/5DW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 06, 2015 at 07:35:37PM +0200, Martin Sperl wrote:
> > On 06.04.2015, at 19:29, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > I'm not seeing any particular complexity here.  Can you be more explicit
> > please?

> I just see the high-possibility of bitrot for something that is IMO better
> moved to a modified device-tree config.

Requiring every system to update the DT to specify information that we
can already get easily (and using a less readable format in that update)
doesn't seem like a clear win for me...

--hDuGXNMqfWt9/5DW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVIsZPAAoJECTWi3JdVIfQec0H/3dV7kpKWw15fpX5XvHxgDEF
/F5vuXUqRIC/KgD4wrXTI5yomWN1F1gBA2g7CzLOO8bpQ7zRggj85olKTHgI6GBx
LTHwWz9Eh7ighT4l1Z8XHMF6xrTo1BxcjDWUsAXo5lrf816HJrsmI7JbefeuVoHA
AJap6oLwB/tkuIhiL/aibIZmcCUr0nqzNHjfKwVHNH1vw4WwARj9daMUO63G0Bs0
fWdyrngLSCL/rJKNJPbsJQ0wVw96Msid4hfrGv5D5jl7rnnmIT1eH2qzkiLxi4n4
13LPoDFTctQumSsNTrBeInePLQZorkl+8mavY8cyBLVt4loL3HxrIpdsJdON4HM=
=2ij6
-----END PGP SIGNATURE-----

--hDuGXNMqfWt9/5DW--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
