From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2] spi: bcm2835: enabling polling mode for transfers
 shorter than 30us
Date: Sat, 18 Apr 2015 13:27:48 +0100
Message-ID: <20150418122748.GO26185@sirena.org.uk>
References: <1428340592-3196-1-git-send-email-kernel@martin.sperl.org>
 <20150410185132.GU6023@sirena.org.uk>
 <F35B7C71-1917-40AE-BA42-CB3E63B877EF@martin.sperl.org>
 <20150415185824.GU6023@sirena.org.uk>
 <262B0C8C-7728-458E-8748-06F79251BE0C@martin.sperl.org>
 <20150418104202.GA26185@sirena.org.uk>
 <54169601-55F7-464C-8A0E-ABF833C0F3BA@martin.sperl.org>
 <20150418115343.GI26185@sirena.org.uk>
 <EB2DE44C-29CA-422D-A89C-4173E02A2CEF@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WoqaC9TUMqqIOlla"
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <EB2DE44C-29CA-422D-A89C-4173E02A2CEF-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--WoqaC9TUMqqIOlla
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 18, 2015 at 02:13:56PM +0200, Martin Sperl wrote:
> > On 18.04.2015, at 13:53, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > As I've said several times now 1s seems far too long for a busy wait,
> > the driver should fall back to something that sleeps after an initial
> > busy wait (once it's clear we're over time).

> Then I have misread what you wrote - I understood you wanted to avoid
> having no timeout at all.

No, that's correct - we shouldn't be busy waiting for ever so we need
something that will terminate.

> So you want something like:
> * wait for 4 jiffies (which is 40ms typically)
> * if we exceed that, then enable interrupts for the rest of the transfer
> and let the 30s timeout handle everything else

That's probably fine, though the 40ms is a bit on the long side.  The
30s timeout could use pulling in too, that's going to fail very badly if
anything does go wronng.

--WoqaC9TUMqqIOlla
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVMk3DAAoJECTWi3JdVIfQz3cH/2VkIYx5BUJ5LOGgpTfe6t1M
QYuKQsAW76JiUwwbnrNRffFqLFntF3Rk5DAuLZYiDKaiEg6jnFhiIOp2F2WUmQmV
7YJRStNvXaJ/apFlQDmM4JKR5t1bH4g7i0q3Bp/lW6VYFjI6AUMt7DiYusVoLI6h
33C/CC0Pva3wgoq04hPJtEcM39cM0gZOPOw54oO9CE3FFszGvGqS0RJ9LD423RYD
XmHVEDGHNi5Q6PVjG7A6ar0RQLTKLxiqn1q4yuK7sV4SdpdCfGJKN4DuOJz/2BKL
Z2qG6JRpgP3zveu7ck3xvbdNgXypPdiSB5s6pi/zwD/5v/danjcXuLFnEp2RoB8=
=Hk2w
-----END PGP SIGNATURE-----

--WoqaC9TUMqqIOlla--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
