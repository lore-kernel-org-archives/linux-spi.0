From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: imx6dl, spi: read/write problem with SPI-NOR on imx6d
Date: Mon, 2 Feb 2015 12:25:32 +0000
Message-ID: <20150202122532.GS21293@sirena.org.uk>
References: <54CB6D8F.5010804@denx.de>
 <20150202035430.GA27494@Robin-OptiPlex-780>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WG9qowv1NtzwMEkm"
Cc: Heiko Schocher <hs-ynQEQJNshbs@public.gmane.org>, Frank Li <Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Cajus Hahn <cajus.hahn-L9/KCGF6/QDQT0dZR+AlfA@public.gmane.org>,
	Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robin Gong <b38343-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150202035430.GA27494@Robin-OptiPlex-780>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--WG9qowv1NtzwMEkm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 02, 2015 at 11:54:31AM +0800, Robin Gong wrote:
> On Fri, Jan 30, 2015 at 12:39:59PM +0100, Heiko Schocher wrote:

> > and I could not see in the commit f62caccd, that DMA gets disabled
> > for imx6dl ... Is this missing? Or should this be done in the board
> > specific DTS?

> Yes, the patch about DTS was dropped as below. Sorry, the next patch not ready
> yet, I'll create it once I have time...
> https://lkml.org/lkml/2014/9/10/91

If this is breaking users then a patch providing the fix needs to be
done fairly urgently, and given that we're supposed to have stable DTs
we probably need a quirk based on SoC type in the driver as well.

--WG9qowv1NtzwMEkm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUz2y7AAoJECTWi3JdVIfQN0sH/1ABrXXiikqNqTjhGgeKaU8+
ohN2eHSRJ6JMRrbZU1L1ELLS0/egXcJdciEGF8vCFzbti9MKAAypTIEc+YFNiW5d
6TF0sqRC7ID/VPyiKfgG675cHUlX+yIDmIv9takSaJF8NNboS6E5qQmPqNCztMf7
BD9sWwII4ebYdroRIlQcemJR0chGBKLKj492eLZgU7kQulvHgyMX5qyu6ok+Lelk
1QvOAI4tig3O3BT2w6ksoqKWeetN1d654bRg6V6ckLgQpeUTCsrzdYKW0MTV/tmk
XWY8nKDGI91W+1oB+uQGGVzfivk0rI+plBud2pktTsCimU/0sfJBvmlV4P1AuQk=
=IqUv
-----END PGP SIGNATURE-----

--WG9qowv1NtzwMEkm--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
