From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 7/7] spi: bcm2835: Speed up FIFO access if fill level is
 known
Date: Wed, 28 Nov 2018 15:58:49 +0000
Message-ID: <20181128155849.GK6828@sirena.org.uk>
References: <cover.1541659680.git.lukas@wunner.de>
 <901ff28c305e56d3349d3e044781c095d8e77a3d.1541659680.git.lukas@wunner.de>
 <807EBC97-54BD-49D5-86C8-3768FB4C0105@martin.sperl.org>
 <52205641.172367.1541849134970@email.ionos.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8800693047314042790=="
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mathias Duckeck <m.duckeck-XB/JSsFECOqzQB+pC5nmwQ@public.gmane.org>,
 Noralf Tronnes <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
 Frank Pavlic <f.pavlic-XB/JSsFECOqzQB+pC5nmwQ@public.gmane.org>
To: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <52205641.172367.1541849134970-uEpKuDZ350hmhno068Nerg@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--===============8800693047314042790==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DfnuYBTqzt7sVGu3"
Content-Disposition: inline


--DfnuYBTqzt7sVGu3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 10, 2018 at 12:25:34PM +0100, Stefan Wahren wrote:

> > > +#define BCM2835_SPI_FIFO_SIZE		64
> > > +#define BCM2835_SPI_FIFO_SIZE_3_4	48

> > Not sure if this should not be a DT parameter describing the HW block
> > and not being hardcoded in the driver.

> I see no reason for this. AFAIK all variants of the BCM2835 have the
> same FIFO length, so i'm fine with the defines. I only have doubts
> about the naming FIFO_SIZE_3_4 because it describe a fill level not a
> size.

It's also the sort of thing we should be picking up from the compatible
string since we have a per-SoC compatible rather than parameterizing in
the DT - that way the SoC just needs the right compatible string in the
DT and then new quirks for that SoC don't need DT changes.

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

--DfnuYBTqzt7sVGu3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv+uzgACgkQJNaLcl1U
h9B4tQf+LGgXjzztWuUj2g57WQU7mPmRJcecCQbv9i4uq5CLk/SFuUmO9xfhl8Ov
m5yS5U8bx5pu8MNtbhhfMfe883BGWRtUVzv89zXBj3F9aEAviMxKxPDAA6ln6Qqj
V9gdpgfkeKP31frG1mTqyYzgBKstl/7C5TTOTKlNFlWNz1f9JdB5cgFsILo1LPBH
oYyB3k7VqH+mctto1Z2+Op+OYDx895sU3Eu5S/Y66KIvMWQOF5MyY3WcQlTSAI/H
6ylPU92KsphUtzuBE843/LkLmZfMZT9eqBX7bALzP0NozZLas0EWN4eWnSS35XEQ
qDhPH8sYBfs/IGCZ95zfWs9MRgNQPg==
=83DL
-----END PGP SIGNATURE-----

--DfnuYBTqzt7sVGu3--


--===============8800693047314042790==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-rpi-kernel mailing list
linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel

--===============8800693047314042790==--
