From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: orion.c: Add direct access mode
Date: Fri, 25 Mar 2016 10:32:53 +0000
Message-ID: <20160325103253.GA2566@sirena.org.uk>
References: <1458663893-13766-1-git-send-email-sr@denx.de>
 <30176583.aSTyzO0qS3@wuerfel>
 <56F42939.4020803@denx.de>
 <12540712.SXPhdxqg9f@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Wcqk1U9YY/kgSQtH"
Cc: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
	Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <12540712.SXPhdxqg9f@wuerfel>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Wcqk1U9YY/kgSQtH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 24, 2016 at 09:07:32PM +0100, Arnd Bergmann wrote:
> On Thursday 24 March 2016 18:51:53 Stefan Roese wrote:

> > I see. But with this we are back to statically mapping the MBus
> > windows that are used. Resulting in potentially multiple windows
> > per SPI controller, which is not necessary (Andrew and Mark
> > objected against that).

> I'm not following here. Do you mean we should set up and tear
> down the windows in the runtime PM callbacks so they are only
> present when we actually access a device instead?

What we're trying to avoid is allocating a window to every single client
device attached to SPI, the controller can only talk to one device at
once anyway so having one per device is wasteful when this is a limited
resource.  Looking at this from the point of view of a SPI driver it
just seems obviously bad, in order to get the best performance with this
controller we need to do a special per-device magic binding.  That's not
good for usability, it's not ideal having to do it per controller but at
least then it's done for the SoC.

We also already apparently have some dynamic code for PCIe.=20

> Among the dts files we ship with the kernel, how many would
> actually use more than one mapping in practice if we decide to
> do the static ranges property? I had a quick look and could not
> even find one that has more than one chip-select connected.

Do any of these boards have things like expansion connectors?

> Ok, so with the static mapping it could be done very easily, or
> we need a more complex solution for the dynamic mapping.

Part of what I personally don't understand is why this is complicated?

--Wcqk1U9YY/kgSQtH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW9RPUAAoJECTWi3JdVIfQ6tEH/j4EiSyDcljDZ0CL5qZw77gA
H+eW8aK9dmW7kmTB7xukdXHsbVVyTR60GQHlq+572q3O0T53N9Tfu2CS6pVZYSA9
LYaH3tknOeT2db+84qxGwJLNFLTCEBo3GfAo6ow/FuUN9NQ6cZm1zSvqjMquZwdW
2m62B8EPftolXy2EYn7/ZPmk9kOZahOvB5JMCjjCMohLZAGrx+yVMNglIAa8M2Xk
OWvF7bLXdB4qSiENHlGsPHkQPzfDX9UHgtQ16Ar1v2QPI0/3Su3kZUKCoDtFZ/Mo
GNaLdwAEs/b4KIabKQ1BiQ/l16RKu8U8AyIuRZmLcrQ87h0tOaVDzuza0v7we6Q=
=5zgk
-----END PGP SIGNATURE-----

--Wcqk1U9YY/kgSQtH--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
