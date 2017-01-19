From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 2/3] spi: pxa2xx: Prepare for edge-triggered interrupts
Date: Thu, 19 Jan 2017 19:57:01 +0000
Message-ID: <20170119195701.kueutgmahr6bmxhq@sirena.org.uk>
References: <cover.1484592296.git.jan.kiszka@siemens.com>
 <cover.1484592296.git.jan.kiszka@siemens.com>
 <7b15a0910a3ad861fd32161c72559bafa7b71e29.1484592296.git.jan.kiszka@siemens.com>
 <87ziiqdstr.fsf@belgarion.home>
 <4d97e416-4d32-3b9f-0695-de116a4b26bd@siemens.com>
 <87r340eq28.fsf@belgarion.home>
 <b3e0d393-b841-1556-ddd2-5634f12b6f2c@siemens.com>
 <20170118124645.6ugjwbfeq5vsh2to@sirena.org.uk>
 <7e5fb21d-35bd-6ac3-9e6f-cffed656997f@siemens.com>
 <e692c4a9-6320-b9e0-d6e7-f58bbe6ba867@siemens.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7530076569036373371=="
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-kernel@vger.kernel.org, Haojian Zhuang <haojian.zhuang@gmail.com>,
 linux-spi@vger.kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 Sascha Weisenberger <sascha.weisenberger@siemens.com>,
 Daniel Mack <daniel@zonque.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <e692c4a9-6320-b9e0-d6e7-f58bbe6ba867@siemens.com>
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


--===============7530076569036373371==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="r3otzofqybbqjs3e"
Content-Disposition: inline


--r3otzofqybbqjs3e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 19, 2017 at 08:37:40PM +0100, Jan Kiszka wrote:
> When using the a device with edge-triggered interrupts, such as MSIs,
> the interrupt handler has to ensure that there is a point in time during

I'm missing patches 1 and 3, what's going on here?

--r3otzofqybbqjs3e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliBGgwACgkQJNaLcl1U
h9D4RQf/QG6JOG18TvM5Eb8bZhLT8JRUjxZ8ZHtaWl0r16NcEMne3NdIWvgXzqIK
QBZKjw8LjqzxYkrpBZpAsoeC9tkdiCeng1CZ7H3uXGl+D8ltWti+lVTi3mBal1a6
yZnjL+3D6x5wllyX1T9UziE7UgNWUSpun9NW4OMv83oeyJjxpEPE6l2CBtXnNCNM
SxM3X7ri+ph55XdzUB2vUdzF6kXXJU0LGIwkagXUjQVbChQCXZfraFvcaLfkDRaR
jR13RSX94yRbD9LrKalFXkUFURCqNJLdTpyNBzeLzI9RDju6pZ89BeQkPiOrwdZN
Jhrou8jVX1tWEf6ji6Syr7iZnBAlxw==
=WWyJ
-----END PGP SIGNATURE-----

--r3otzofqybbqjs3e--


--===============7530076569036373371==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7530076569036373371==--
