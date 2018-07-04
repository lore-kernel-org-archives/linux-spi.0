From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC net-next 15/15] net: lora: Add Semtech SX1301
Date: Wed, 4 Jul 2018 15:32:07 +0100
Message-ID: <20180704143207.GD11693@sirena.org.uk>
References: <20180701110804.32415-1-afaerber@suse.de>
 <20180701110804.32415-16-afaerber@suse.de>
 <20180702161258.GA18744@sirena.org.uk>
 <4e06cc72-2092-70f3-c801-bf6e4c3cbec2@suse.de>
 <20180703145022.GA13744@sirena.org.uk>
 <809fc546-6012-37f3-9485-cfd8eaf99488@suse.de>
 <20180703153137.GB13744@sirena.org.uk>
 <3f6289f9-d345-39a7-f0dd-9d5fa7c86e82@suse.de>
 <20180704114355.GB11693@sirena.org.uk>
 <BY1PR02MB1114BC0F12654B1E7C614108E7410@BY1PR02MB1114.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1056411976844077168=="
Cc: Steve deRosier <derosier@gmail.com>, Matthias Brugger <mbrugger@suse.com>,
 Jiri Pirko <jiri@resnulli.us>, Hasnain Virk <Hasnain.Virk@arm.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Marcel Holtmann <marcel@holtmann.org>, Dollar Chen <dollar.chen@wtmec.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Janus Piwek <jpiwek@arroweurope.com>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "LoRa_Community_Support@semtech.com" <LoRa_Community_Support@semtech.com>,
 Jian-Hong Pan <starnight@g.ncu.edu.tw>, Ken Yu <ken.yu@rakwireless.com>,
 Michael =?iso-8859-1?Q?R=F6der?= <michael.roeder@avnet.eu>,
 Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
To: Ben Whitten <Ben.Whitten@lairdtech.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <BY1PR02MB1114BC0F12654B1E7C614108E7410@BY1PR02MB1114.namprd02.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org


--===============1056411976844077168==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZARJHfwaSJQLOEUz"
Content-Disposition: inline


--ZARJHfwaSJQLOEUz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 04, 2018 at 01:41:42PM +0000, Ben Whitten wrote:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> In my SX1257 driver currently the regmap is backed via SPI with
> devm_regmap_init_spi, please correct me if I am wrong but if I
> understand correctly this could be split out to regmap backed by SPI
> in the case of a direct host connection, and a regmap backed by the
> SX1301's regmapped strobing register interface, regmap_bus?

Yes.

> Is there a precedent to this I can examine?

There's lots of devices that provide both SPI and I2C, you'd just be
using a regmap_bus instead of the I2C one.  I can't recall an example of
the specific combination you're looking for though.

--ZARJHfwaSJQLOEUz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAls82mcACgkQJNaLcl1U
h9BTpwf/T2VrVZLcZ8Fk98fHgO3xln63cUiCQVjFwc8A8IHLEpsjgAkaHnNR3RLG
zxKmqIw63sSmHMxIwZ+cfJEAxiRDGpp6JgFtQgwPRRBzdsbizXRTXQJ+BwjixJHS
ntupUSgKDCe1XnMXjo21ZiaFsPvzxctSA6WRYKWYYjXh/uYoAi830siYyDLSqDFV
xqDd0iCQQZfijvrU6RYuTE5Mk7cSEkG6e0KLy6Sd51jisdcGN79P6Ao0zYwFveaG
MBmLiwacvAd2cokiIOCTfNg9+pEWwBsMcCkz1uoutML1wAyVZJg+UGWnAb664n2t
NCZ48qCSgHDInfA7uVmDddihsXD7Kw==
=b1ya
-----END PGP SIGNATURE-----

--ZARJHfwaSJQLOEUz--


--===============1056411976844077168==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1056411976844077168==--
