From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: bcm2835: Allow platform to set realtime priority
Date: Thu, 23 Mar 2017 16:22:11 +0000
Message-ID: <20170323162211.azfzrafkcky6nyws@sirena.org.uk>
References: <c1ca8a5522272d06f5c3fb67d8442f148b2d6cfb.1490264661.git.lukas@wunner.de>
 <1503363fcfb92adfa765d1c1c3e69fc673e72dde.1490264661.git.lukas@wunner.de>
 <20170323110718.sncw32gspvls75u7@sirena.org.uk>
 <20170323120257.GC20546@h08.hostsharing.net>
 <20170323122118.i2gc77debz4eu5hq@sirena.org.uk>
 <36CAED84-34BB-43E8-8716-0187F3B7EFE0@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="is2pkatopdixdwbw"
Cc: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>,
        Mathias Duckeck <m.duckeck-XB/JSsFECOqzQB+pC5nmwQ@public.gmane.org>,
        Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <36CAED84-34BB-43E8-8716-0187F3B7EFE0-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--is2pkatopdixdwbw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 23, 2017 at 03:08:01PM +0100, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:

> * we use an =E2=80=9Cinline=E2=80=9D spi-pump if there are no messages in=
 the message
>   queue - the spi-message-pump-thread is not used in those cases.
>   So those spi messages are NOT handled with the proposed RT priority,
>   as they run within the context of the =E2=80=9Ccaller=E2=80=9D - which =
may even be
>   the priority of userspace if spidev is used.

Yeah, this might actually make things worse if the RT thread is used
since unless there's multiple contending users or async users the pump
is only responsible for idling the controller when it goes idle so
making it RT can result in more idle/resume cycles (though they are
fairly cheap usually) and context thrashing doing that.

> > This was being done via platform data not via device tree, unlike
> > platform data device tree should provide a long term stable OS neutral
> > ABI.

> Well - if it is really a necessity and as the mantra for DT is:
> "it should describe the HW only", why not use a module parameter
> instead or use chrt() from userspace?

Yes, those are fine.

--is2pkatopdixdwbw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljT9jMACgkQJNaLcl1U
h9DoAwf9EM9D0flYJWqrWl5RCHXKPf5VsBJQcv0HvfOyxhkwJWBz8P6jeJYQO4Po
u5Ao5C4FaqE0tLE8/hxbVgnuLvdDrSyRvDgBXy2mImV7QGtMoWSe8oISg7G7Qxu6
ZXkMICjNXKc80WncbJnPwgoBhiK6TkGyKH+VkocAQV8fkwktXC1YEaArTyXO1pYA
GeZe/6WXK0/6E6b9yyl83bht9lCdZgJffs02OJWDiIVaf6nUgxsSPZP/MwC7JP4/
RKTGFaxD9rXoleUsS3deDqeeMMJNya/rUMBW0x64F7LdkgFw9eySS0pUtw5fMbx6
PCTMVXhA5z5FLPoWn1zgXn3AOuLJrg==
=RGmA
-----END PGP SIGNATURE-----

--is2pkatopdixdwbw--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
