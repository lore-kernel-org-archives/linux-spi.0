From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/5] spi: rspi: Use DUMMY_DATA macro instead of hardcoded
 value
Date: Mon, 30 Dec 2013 11:54:20 +0000
Message-ID: <20131230115420.GI31886@sirena.org.uk>
References: <1387878574-21445-1-git-send-email-geert+renesas@linux-m68k.org>
 <1387878574-21445-5-git-send-email-geert+renesas@linux-m68k.org>
 <51418828.lCh7RnWjxA@avalon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vFj1JTFBn4Zx1dEI"
Cc: Geert Uytterhoeven <geert+renesas@linux-m68k.org>,
	linux-spi@vger.kernel.org, linux-sh@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <51418828.lCh7RnWjxA@avalon>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--vFj1JTFBn4Zx1dEI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 27, 2013 at 03:36:12PM +0100, Laurent Pinchart wrote:
> On Tuesday 24 December 2013 10:49:33 Geert Uytterhoeven wrote:

> >  		/* dummy write for generate clock */
> > -		rspi_write16(rspi, 0x00, RSPI_SPDR);
> > +		rspi_write16(rspi, DUMMY_DATA, RSPI_SPDR);

> Doesn't the comment make it obvious already ?

To be honest that had been my thought as well but if it makes the people
working on the driver happy...

--vFj1JTFBn4Zx1dEI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSwV7pAAoJELSic+t+oim9PoIQAJim3XPTYKDnDY7Nhp2IAN09
v5VFsY462ouZFes7GNSzBoVgMGLPSIolUemDkqm3ir78vYWsfzWU8qPCFLNVBoyy
LudQghkkQbgqMX/YPH2xuSGNhn0GPYvkyj2Bx15m9mlqwtm8OGKH7VuYgEFRn1iP
cco4ZFv4rV6S1AJOHvJNFG+P1QRsDadCFot1sKTJQZpwCz0KLeSehBqHGQ62I+P8
gyjLis5ZPNn5qZxgJV6Lyt0EcpV3iRchvKJotXQkLMo8wkbSG/Z/8ZTlqA9dmhER
u6d8Sn9uklL1TkMawer8dk60U3mmCO7TMrvmim7hbsBRMsNNX499BBxapdBXUNk5
WkCG2+GDFyTp+1nGgQ1uB1AiCF6nj7OEuDU55ane2oUBaME0BMR/z9WO/rwagz0A
kfaITG1HQ5WeqR4Es+SzNz7q8Tr+AUtYZ6/pVCGfk3Aw7JK7+VNDD+G1ZTXGc6Y0
o82cBiu/9X5wVIuCjq8N8EbDaQxDnmxZz1dLkZF4gRC1aQPALYAOW5H8XeZ8O8wB
N0OaMT5td3JjcTyPZw/ZAth8bzbzHqmjefxvRUpZ4xAfp6aqmaHCnD/5+//qFf/O
XeXZTDkRVVwFKzmR+Mx3yBSi/FBgtyrH0pkW7XtfM0H2VXMlqcpojZkhQv5sRbVj
3beqctbVG4R2AAIravvO
=o13H
-----END PGP SIGNATURE-----

--vFj1JTFBn4Zx1dEI--
