From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/2]spi: DUAL and QUAD support
Date: Thu, 22 Aug 2013 14:21:22 +0100
Message-ID: <20130822132122.GK26118@sirena.org.uk>
References: <1376216117-5864-1-git-send-email-wangyuhang2014@gmail.com>
 <5216057F.4010900@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6253138168387790420=="
Cc: spi-devel-general@lists.sourceforge.net, tpiepho@gmail.com,
 linux-mtd@lists.infradead.org, wangyuhang <wangyuhang2014@gmail.com>,
 pekon@ti.com
To: Sourav Poddar <sourav.poddar@ti.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <5216057F.4010900@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org


--===============6253138168387790420==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9YpAf2t6OxtMGzg"
Content-Disposition: inline


--M9YpAf2t6OxtMGzg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 22, 2013 at 06:05:11PM +0530, Sourav Poddar wrote:
> On Sunday 11 August 2013 03:45 PM, wangyuhang wrote:

> >+		/* check transfer tx/rx_nbits:
> >+		 * 1. keep the value is not out of single, dual and quad
> >+		 * 2. keep tx/rx_nbits is contained by mode in spi_device
> >+		 * 3. if SPI_3WIRE, tx/rx_nbits should be in single
> >+		 */

> Sorry for pitchin in a bit late on this.
> I was trying to use this for my use case today. I realise this check
> should be under...

Can you send a patch for this please?

--M9YpAf2t6OxtMGzg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSFhBPAAoJELSic+t+oim9bN8QAJgt6UCqMhttRR+GLj2aHBhW
aVYW9LDa5mPMEi3HVCa5Snd8EuUGPwBkCw6xgTK/TU855HOZ8R5mOsQp2k1wLgxs
ppM/w47opU2AaNGbjXO5aqcwMCQw90UqiFsCp+lkS5LPOhzG6CmQVwYaAfjYb6BO
vT7jRUcUFElhefccLMMLJ/6rDuFceVA5p3lP7JJsyyW81m9n7y/TLhc47wHViYmX
ZqfbsTmW0JF55AvdGXidz/aiJyUlZx8fLUQ6fF5xh4NBSWZvNIPcjABXnoswyALm
IYtLs4ii8xMigxIW+jr13UkZ/t5v1BDI78t+2tUtzMATcZY8gFiQQN/BnmM55S5b
41hde07h3npq9xlkJSxQrq5z6wAnGs7IANyqNtp+rintyYzQHtfsLcbQvrzjtPmF
K+zM59t31cYDmK0i28ZDPWAfk/6e/0gNRM3Ee53AcuzGJEdqfxscpIYjQuKqpG+Q
TfI7Zy0gTkImImt+odh7AHglMUvnO5821hZeNzBcDQ5S43uuNNhgzf/B1Ml7ru1G
zMNI0BFv0w5ItJw5tU30AbddwV8AA9G7uK2kecyTS0zseyNJ2Sepi6ams9mg3jK5
IbUklun4Ok+YE2JX/99oiQAD8+mxxa787PBchZtgMCB8feAGwPeEqYUKHIH+aO/C
UEsr0NwNCmmCfb8l1VAr
=v0k7
-----END PGP SIGNATURE-----

--M9YpAf2t6OxtMGzg--


--===============6253138168387790420==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============6253138168387790420==--
