From: Mark Brown <broonie@kernel.org>
Subject: Re: [RESEND] spi: davinci: Allow device tree devices to use DMA
Date: Fri, 13 Jan 2017 12:04:08 +0000
Message-ID: <20170113120408.3jtslvgifdpxchvp@sirena.org.uk>
References: <1483673177-31516-1-git-send-email-david@lechnology.com>
 <m24m146jzh.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1402603875176264447=="
Cc: linux-kernel@vger.kernel.org, nsekhar@ti.com,
 David Lechner <david@lechnology.com>, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <m24m146jzh.fsf@baylibre.com>
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


--===============1402603875176264447==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="atb5t5jcis6a65ku"
Content-Disposition: inline


--atb5t5jcis6a65ku
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 12, 2017 at 01:34:10PM -0800, Kevin Hilman wrote:

> I thinks this driver needs an update to use spi_map_buf() to be able to
> handle vmalloc'd buffers before always enabling DMA.

Right.  As I said elsewhere in the thread the driver looks like it needs
some very serious TLC based on a quick scan through.

--atb5t5jcis6a65ku
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlh4wjMACgkQJNaLcl1U
h9CaQgf/SC38suTWLXipwit5LvAwHerMkSzKX7bq3rQMiQpiqxv6CdmEl09SoAUX
wf5Frbd82cb8WGTlALczkiI+oojeY6rS/TANcFSgmiUJ+XBbiH4y4FLTh35HtY7K
ZdZ/T/WA+RfgnkH9avZtmBPapGOUgEIS5yL6dhvELA25DmC7Gq7vHTiaELb6DU1K
/i6z6Nuf9VXDcm7QzH7/oZewn5s4GqqCH2ejU4OF/FKTYl7izWdCvYMgFT9HBN+a
PNUUq9raIVl0yvdzTNXeHe5eRnF1aWpCtZHFOIvWScj63kKa12DYCsi6V2fgOZ9X
488Z3J4RBQ9WEcHR7Q9eefOwNpO4dw==
=/+jI
-----END PGP SIGNATURE-----

--atb5t5jcis6a65ku--


--===============1402603875176264447==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1402603875176264447==--
