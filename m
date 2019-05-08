From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2 5/6] spi: bcm2835: make the lower limit for dma mode
 configurable
Date: Wed, 8 May 2019 17:42:05 +0900
Message-ID: <20190508084205.GD14916@sirena.org.uk>
References: <20190423201513.8073-1-kernel@martin.sperl.org>
 <20190423201513.8073-6-kernel@martin.sperl.org>
 <20190424070712.hh6ozvhkvkxhwak3@wunner.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5606100541965372624=="
Cc: Stefan Wahren <stefan.wahren@i2se.com>, linux-spi@vger.kernel.org,
 Eric Anholt <eric@anholt.net>, linux-rpi-kernel@lists.infradead.org,
 kernel@martin.sperl.org, linux-arm-kernel@lists.infradead.org
To: Lukas Wunner <lukas@wunner.de>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190424070712.hh6ozvhkvkxhwak3@wunner.de>
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


--===============5606100541965372624==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mO8cNyIiGwRJ/NO+"
Content-Disposition: inline


--mO8cNyIiGwRJ/NO+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 24, 2019 at 09:07:12AM +0200, Lukas Wunner wrote:

> Indeed I'd prefer if another bit is added to "mode" in struct device
> to represent the need for another clock cycle in-between bytes.
> The SPI core could then reduce the clock speed based on this flag
> and the problem would be solved for everyone.

> Influencing this behavior with a module parameter feels a bit like a
> kludge and I fear may stay indefinitely even if a better solution
> is implemented later.

This does feel like we know enough to have a more advanced function in
the driver given a bit of information about the client device
requireemnts.  Though it's going to be complex to express them,
especially with the ATMega case where we want fast individual clocks but
lots of dead space in between bytes (is the controller capable of adding
that dead space itself in DMA mode BTW?).

--mO8cNyIiGwRJ/NO+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzSll0ACgkQJNaLcl1U
h9BtCQf+Kt1H2BIy8rCRowJoHOYziXd77HiP3zga+61FigqwiVNAsnc9sgHceaX8
PC+sIWmiH3sdLwIO+ZCkNwTxPmPwrLLnv7xQa8NWnS7jCxIMnVLRnmlQ9cVuLQ0k
sHIA+aPAqT/wUZLDrwg4PhAq2laX/KDZb9rOpPbi4kb/zVhVtkXuYVFEgiR5Pl77
enqEIE+oEUG7Ebns1fzljdzv/h0zu1g+KpzTJ4hVTVCShHUAo8AZmBsgMfP/gT/Y
q0U8SBCda+HZH5Av6k9lBWMgGgOfF1E1JlQaNYQGTfEVOlt1imMXH4yQVy+bilZ2
8rHCL74K7lQ5reujgEtw/36TmfZ8qg==
=atSx
-----END PGP SIGNATURE-----

--mO8cNyIiGwRJ/NO+--


--===============5606100541965372624==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5606100541965372624==--
