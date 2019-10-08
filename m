From: Mark Brown <broonie@kernel.org>
Subject: Re: Applied "spi: Add a PTP system timestamp to the transfer
 structure" to the spi tree
Date: Tue, 8 Oct 2019 17:42:59 +0100
Message-ID: <20191008164259.GQ4382@sirena.co.uk>
References: <20190905010114.26718-3-olteanv@gmail.com>
 <20191008105254.99A6D274299F@ypsilon.sirena.org.uk>
 <CA+h21hoid_bQ37qC30fDt62ces40PwSQ2v=KHTGkadV_ycrd5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JQ29orswtRjjfiJM"
Cc: "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hubert Feurstein <h.feurstein@gmail.com>,
        linux-spi@vger.kernel.org, Miroslav Lichvar <mlichvar@redhat.com>,
        netdev <netdev@vger.kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
To: Vladimir Oltean <olteanv@gmail.com>
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+h21hoid_bQ37qC30fDt62ces40PwSQ2v=KHTGkadV_ycrd5A@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--JQ29orswtRjjfiJM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 08, 2019 at 03:58:51PM +0300, Vladimir Oltean wrote:

> Dave, do you think you can somehow integrate this patch into net-next
> as well, so that I can send some further patches that depend on the
> newly introduced ptp_sts member of struct spi_transfer without waiting
> for another kernel release?

Ugh, it'd have been good to have been more aware of this before applying
things since I put them on the one development branch (I used to make
more topic branches but Linus doesn't like them).  I've pulled things
out into a branch with a signed tag for merging into other trees:

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-ptp-api

for you to fetch changes up to 79591b7db21d255db158afaa48c557dcab631a1c:

  spi: Add a PTP system timestamp to the transfer structure (2019-10-08 17:38:15 +0100)

----------------------------------------------------------------
spi: Add a PTP API

For detailed timestamping of operations.

----------------------------------------------------------------
Vladimir Oltean (1):
      spi: Add a PTP system timestamp to the transfer structure

 drivers/spi/spi.c       | 127 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/spi/spi.h |  61 +++++++++++++++++++++++
 2 files changed, 188 insertions(+)

--JQ29orswtRjjfiJM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2cvJMACgkQJNaLcl1U
h9BREQgAhlEYJBvquriG33/Zhq7AJZBUCIONBDd5IYNjmWwGR6N0rVfvhRbalzVK
P6iWn9l0Sj5u6itn7nRuEyH+aaYW4RKiREzQ580FwLKkK2WYevodCd28jcygNzOO
YvGCqL09LR9BkhU3b1Vc2YFm97UCZf+NJdphJqrM7KwOvOy+T4Tj7ohtyfTqpAM6
IyZ67I4mhD61yg1m6nw9+n+Jm1SbVoGsW/6fTNAdrWS1PWtZ+QbvOg6qou/WUyn/
qH1yQ670c601ggGhsw6fh1pZEQKYrdsMuc4hJArej8ZQuZt4iDqOET7IqspocOrs
6coC45TYxTCK3K2z9qR750pnm1NMzw==
=ZNU3
-----END PGP SIGNATURE-----

--JQ29orswtRjjfiJM--
