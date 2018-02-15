From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/4] spi: orion: Software control for inter-word delays
Date: Thu, 15 Feb 2018 15:49:45 +0000
Message-ID: <20180215154945.GF8374@sirena.org.uk>
References: <bc8bf712358fbb000ea7e2ea9e1aec42b21988e6.1518704854.git.jan.kundrat@cesnet.cz>
 <475b63c52b17187089d3f2ecf8ff4b8c45a7e58b.1518704854.git.jan.kundrat@cesnet.cz>
 <20180215151907.GD8374@sirena.org.uk>
 <c5d27950-0d13-422c-afe9-990b4adad45a@cesnet.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b8GWCKCLzrXbuNet"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
        Chris Packham <Chris.Packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>,
        Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        Christophe JAILLET <christophe.jaillet-39ZsbGIQGT5GWvitb5QawA@public.gmane.org>,
        Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>,
        Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
To: Jan =?iso-8859-1?Q?Kundr=E1t?= <jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <c5d27950-0d13-422c-afe9-990b4adad45a-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--b8GWCKCLzrXbuNet
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2018 at 04:45:55PM +0100, Jan Kundr=E1t wrote:

> How should the interface look like? Is spi_controller->mode_bits a good
> place for controllers to advertise this feature (SPI_WORD_DELAY, perhaps?)
> as supported, with spi-orion being the only implementation now? If we all=
ow

Yup.

> each spi_transfer to override this value, is there a common place in the =
SPI
> core which somehow validates a spi_transfer against each controller's
> capabilities? I see a code like that (bad_bits, ugly_bits) in spi_setup
> which looks like something to be called per-device, not per-transfer.

__spi_validate().

> My most important use case is, however, the userspace-facing spidev, and =
its
> ioctl complicates stuff a bit. The relevant struct has a 16bit padding now
> (used to be 32bit prior to https://patchwork.kernel.org/patch/3715391/). =
Is
> it OK to use this padding for this feature? Or should I perhaps eat just
> 8bits and limit the delays to an arbitrary value of 255us? Or should I not
> care about that now and let somebody else come up with another "bigger"
> ioctl when they need that space?

Ugh.  Using the whole padding is probably OK.

--b8GWCKCLzrXbuNet
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqFrBgACgkQJNaLcl1U
h9Bwkwf7BOOb3KVuSIOBmHAqX1mEEM6qnrN9oxJzNnzyCQlIype1emleKqztIcVo
3eHvcj9KHzbMc/6nmcM+uCqHp4yvnUwB7YPJ6jOZa1pRmSOVnvhrAQeje1huKhAJ
e65TyAznnJtjnGV2hRMdXY1HiaJkWjIDKRGPwC7XX7QhelYBETdF4x0380Ax8fGS
vmWxg1YAGwb0C3o9Dbxf+Y6kmW/YPP/vNmjJaTPl7jp1SR8KD8NxXTdML3zv1hDg
NTlwIVWsJ190QsMaHU8+rGFfoNcVyzeUIq0cIceG5K1iTSijjv7vhL6ZwffxjQ1b
AOh+3g2Sn0P5KPi8QBKwRuh0znO4QQ==
=IoD8
-----END PGP SIGNATURE-----

--b8GWCKCLzrXbuNet--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
