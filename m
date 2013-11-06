From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Depreciated spi_master.transfer and "prepared spi messages" for
 an optimized pipelined-SPI-DMA-driver
Date: Wed, 6 Nov 2013 09:48:54 +0000
Message-ID: <20131106094854.GF11602@sirena.org.uk>
References: <06C7F4D3-EC91-46CF-90BE-FC24D54F2389@sperl.org>
 <02BFF0F6-3836-4DEC-AA53-FF100E037DE9@sperl.org>
 <20131030171902.GL2493@sirena.org.uk>
 <8D8B0BAD-0E00-4147-B4C8-FBB18F060C96@sperl.org>
 <20131030215716.GV2493@sirena.org.uk>
 <3342FD19-4438-463B-89B2-A83D3475AC22@sperl.org>
 <20131031001004.GW2493@sirena.org.uk>
 <18639D9A-630E-44F3-AA7A-ADFF5D5E8B56@sperl.org>
 <20131104184511.GR2493@sirena.org.uk>
 <5A55A832-5313-499C-A483-BF5A6649D69D@sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JSkcQAAxhB1h8DcT"
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
To: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5A55A832-5313-499C-A483-BF5A6649D69D-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--JSkcQAAxhB1h8DcT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 04, 2013 at 10:43:03PM +0100, Martin Sperl wrote:

> again: first the dma-engine part would need to be upstream before I assume
> you would accept to merge the driver, as the functionality would NOT work
> otherwise. So we talk about 3.15 at the very earliest...

Well, v3.14 should be possible - we're just coming up to the merge
window for v3.13 so v3.14 is still wide open.

> So is the presented idea an approach to move forward on?
> Or do you have a better approach which we could follow to get us out of t=
his=20
> tie?

I think the current approach seems fine.

> /* generic wrapper functions for device drivers to use */
> static int bcm2835dma_spi_prepare_message(struct spi_device *spi,
> 	struct spi_message *msg)
> {
> 	if(spi->master->prepare_message) {
> 		return spi->master->prepare_message(spi,msg);
> 	} else {
> 		return 0;
> 	}
> }

Like I said earlier I'm concerned about the idea of drivers calling
these functions directly, this should all be factored out of drivers
since there's nothing really driver specific here.

--JSkcQAAxhB1h8DcT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSehCDAAoJELSic+t+oim9/78P/1yHQqgN0gEzCrNSdWG/V/R0
dtnur3DXzlnK266fbVhEJIz/Lk+bXAmtYg/zcaE9z1K4hVZLpaNWk8l8HTVk6t4S
aimBYepJ8/L1r8BJ2k+YMJrI8tqq8ABOmmPQZoC5l9Vj29lUbcH2Q6Qa9lwqTwv2
T3UHQ84JmT7jFcDWNpmF2NeHpy/Two9e08r9dMuYnF3brzdZRCY+Teuuue74lHCy
irbRS+TxrUlx6FPfOayKOfg7RclOfRsrS1iaioJAf+SErD6EXpFSsY9KcOw28fGF
0lb4vUqCpK3MUffRUgzxciIx9L1vn0aId03G3nxIMtCIloTex3mRA4BqAeQFz0gM
MtYQ35A0mfesQOjPCWv46vC2WkO5iu7vlcan5f5HaICMTiBd84wv2PHS58WPXCiX
oryu3mTIJW4AHp1knALiJvsF8s4w3imJ+61TqnF8v7F3ILDfrXpFcITInuKjcfyM
xteEtzXSWKFmsiN2PtHTgitjSfM6a1X50pjSUEF4jNoqvcb4rfNZdSHn5M2dJlas
nFLrWmKPL+2FngmhMNv+KkcnARdi/vM1GnfqnzPtjgR+7O0LjP7SSleBGGf7Fjgp
8b7bQDAuH1fkJVXGw99nEl1sbCJlzJPmGKo0Mb8QPEelm4rOByPHYl+uXGo4ZtoD
T1JABTBUSkdI8uDspAIh
=UrS8
-----END PGP SIGNATURE-----

--JSkcQAAxhB1h8DcT--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
