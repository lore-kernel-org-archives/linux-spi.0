From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: fsl-espi: fix behaviour for full-duplex xfers
Date: Wed, 22 Apr 2015 20:57:46 +0100
Message-ID: <20150422195746.GM22845@sirena.org.uk>
References: <1429111398-21444-1-git-send-email-jonatas.rech@datacom.ind.br>
 <20150418125556.GR26185@sirena.org.uk>
 <363371145.339730.1429715343024.JavaMail.zimbra@datacom.ind.br>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="S4au6D4xuhGIk15i"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: "DATACOM - Jonatas.Rech" <jonatas.rech@datacom.ind.br>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <363371145.339730.1429715343024.JavaMail.zimbra@datacom.ind.br>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--S4au6D4xuhGIk15i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 22, 2015 at 12:09:03PM -0300, DATACOM - Jonatas.Rech wrote:

Don't top post (context is important for people to know what you are
talking about) and please fix your mailer to word wrap within
paragraphs so your mail can be read and replied to more readily.

> The m25p80 driver can send down a message that's bigger than the
> amount the spi-fsl-espi driver can handle in a single espi_transfer
> (64KiB), when the application wants to read the whole memory content,
> for instance. In this case, the Freescale driver splits the message in
> 64KiB chunks, adding a "Read the next 64KiB" command in the TX buffer
> so the flash memory can output data from the expected offset. In the
> end, the m25p80 driver sees all the data as one big rx_buf, as it
> expected in the first place.

This is completely broken.

> Unfortunately, I don't know how many protocol drivers currently rely
> on this, or even how other controller drivers deal with this expected
> behavior.

This is not expected behaviour for anything and should be fixed
urgently.

--S4au6D4xuhGIk15i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVN/06AAoJECTWi3JdVIfQE5kH/i4hIyw4PkGuPj8V3tIZGwW8
J/W1oAqKvVAnQ/jo8Misj1asgi7Zrp2Hq1xbAzPsdPAoLgOTF8MCB7NS+ReY4/wo
U+svp4sh0eEt4FuZQFBUMTOz5z1DUBIXjzn5G6J9UAZuiVXH88pf0/ofKrsgYYO+
WPzODwr9P0RvJNc/6+cuJYYRzmppKQEEF00t7wLxSGaL3Oc4Pe6f1VrH5f092KVZ
z4xw7TU5SLCB5zinQ0JXG8AG6CTmeRqv0CrQhmEAdZAMSbwBN7OWCAEXloPF7K7q
fulPV5Gt1YOs9fpXpdrKf5dmidWgBGTrKd8Dnup0m+O1cYs9kUqb/etBHwXSs8c=
=S+Tc
-----END PGP SIGNATURE-----

--S4au6D4xuhGIk15i--
