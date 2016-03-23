From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: orion.c: Add direct access mode
Date: Wed, 23 Mar 2016 18:29:16 +0000
Message-ID: <20160323182916.GQ2566@sirena.org.uk>
References: <1458663893-13766-1-git-send-email-sr@denx.de>
 <20160322173546.40d24cc2@free-electrons.com>
 <56F17684.2010307@denx.de>
 <20160323113316.GH2566@sirena.org.uk>
 <56F2852C.5010006@denx.de>
 <20160323125448.GM2566@sirena.org.uk>
 <56F295E1.4030505@denx.de>
 <20160323132732.GN2566@sirena.org.uk>
 <56F2D19A.7020604@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="x1boUlh8/WRmNQ6V"
Cc: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
	Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>,
	Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
To: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56F2D19A.7020604-ynQEQJNshbs@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--x1boUlh8/WRmNQ6V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 23, 2016 at 06:25:46PM +0100, Stefan Roese wrote:
> On 23.03.2016 14:27, Mark Brown wrote:

> >No, really - it's just unhelpful.  Putting this in the ABI means that
> >every single system integrator who cares about performance is going to
> >need to go and manually figure out how to configure this in DT and
> >manually select values.  That's not doing a good job for users, it's
> >making their lives harder for no gain.  If there are no physical
> >constraints then how we allocate space in the MBus should be a runtime
> >thing, it shouldn't be part of the ABI.

> Do I understand you correctly, that you want the complete MBus
> allocation and configuration to be included in the SPI driver
> instead of using the DT to describe the window (target, attribute,
> area)? If yes, then the SPI driver would be the first driver
> to do this "internally". All other drivers using MBus resources
> parse these from the DT (AFAIK) as this is highly SoC specific.

That seems pretty surprising, especially if there is a possibility that
we might run out of resources on the MBus even if just in some unusual
situation.  Why would this be manually configured in DT if there's no
hardware restriction?  Based on what people are saying I'd expect the
SPI controller to have a reference to the attached bus which it uses to
find the bus and then ask the bus to allocate it whatever it needs from
the space available.  I mean, I guess if that's what you're forcing
users to do that's what you're forcing users to do but it seems like
it's making people do manual work that should be automated.

It's possible I'm missing something about how this hardware works...

--x1boUlh8/WRmNQ6V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW8uB1AAoJECTWi3JdVIfQRWsH/1Ax5zki9SzGcbq/+UoeN1Z6
rCuPQ8D3r4pxzJ1WC9hPLmR3ZOGy5rvtS8LNtMrrtEif3eqiJDU4jNsNBo1XQhJw
t09rpqF8ZS+X632Bs+DogHISd5tvuHnwSpFfG4LiUMNiBVN8eNm/9jEyrxGuQOep
+PB7UXLXs856ngZiqQp4dodZNEhSSH/s2keK7fwALNliEzCF+eoHBw0Uy40HbAWD
0YYnqQLprQOwMzd5Tj8GQ1/1UnOeEjOazkJX7bvsFsVOmZNe++D0VStJhnCmY9Jh
Z4V91Z8dmnsSNJgwumzxI2hVcE/NcJ6ILPj3mi3jEheCIwOUJbK95PWjXQsSA5w=
=E55c
-----END PGP SIGNATURE-----

--x1boUlh8/WRmNQ6V--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
