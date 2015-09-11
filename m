From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 5/6] spi/bcm63xx: move register definitions into the
 driver
Date: Fri, 11 Sep 2015 12:22:04 +0100
Message-ID: <20150911112204.GG12027@sirena.org.uk>
References: <1441894304-22316-1-git-send-email-jogo@openwrt.org>
 <1441894304-22316-6-git-send-email-jogo@openwrt.org>
 <55F1D5AC.5020407@openwrt.org>
 <CAOiHx=mXBnfMx1SO+iG=BB6038c99YS8MkM8Nn-itHOoHzAJiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wshT/1ut16otUOEK"
Cc: Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOiHx=mXBnfMx1SO+iG=BB6038c99YS8MkM8Nn-itHOoHzAJiQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--wshT/1ut16otUOEK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 11, 2015 at 12:27:02PM +0200, Jonas Gorski wrote:
> On Thu, Sep 10, 2015 at 9:10 PM, Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org> wrote:

> > This is a little fragile, I would rather create more specialized
> > platform_id names, like "bcm6348-spi" and "bcm6358-spi", very much like
> > what the FEC driver does, such that:

> Can we even associate more than one name with a driver? Else I would
> need to split this driver into two, and that sounds like a lot more
> work for IMHO not much gain, and a lot more opportunities to
> accidentially break things ;-)

Yes, of course - like Florian says look at the FEC driver for one
example.  Just set id_table.

> I'm also trying to not touch arch stuff, to keep the changes local to
> spi (easier merging). Apart from that, this is the legacy platform
> device registration route where we know exactly which values to
> expect, and the device tree path won't go there, so I would think this
> is okay for devices where we have full control over this (i.e. within
> the kernel).

Making the code more obscure and fragile to avoid such a minor issue
with integrating changes sounds like it's going in the wrong direction -
it creates long term complexity for a short term gain.

--wshT/1ut16otUOEK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEbBAEBCAAGBQJV8rlOAAoJECTWi3JdVIfQQrQH+KVWLuJIZpumzu92H+0MNU/9
J6Y15MSVUoBOOrGls1J/HG2IVH6vSnLKE/50CBPEITvtdvlyeM6koDfdRyGaMte0
yLdS/s5/EbSgsEuXgEKuOiGGfvGipU0WrXoPxWqZeI9wHnVUliVhHKjyQqDozxhJ
5d/+gRs1ogOzOaqW1/PYcWdTKd47n82BN/bL1q7mirG2wUTDBUw28UnJ/cMvAAoe
KbugxRrypkCLk30dq0XonuUlJb+YwYxoT4/CRjH8JSF05vX8dz6TbPeKkouREQAX
JBh1bMwXY25olksQd+LiqqTR6vDFlGPqvdfbKk1lCYdxbmRYU29fJZpKOawZKw==
=+Wbx
-----END PGP SIGNATURE-----

--wshT/1ut16otUOEK--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
