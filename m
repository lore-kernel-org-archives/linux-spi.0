From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 00/15] spi/xilinx: Speed-up
Date: Wed, 28 Jan 2015 19:43:11 +0000
Message-ID: <20150128194311.GL21293@sirena.org.uk>
References: <1422447834-23116-1-git-send-email-ricardo.ribalda@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7510276472656004075=="
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Michal Simek <michal.simek@xilinx.com>,
 =?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>,
 linux-spi@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1422447834-23116-1-git-send-email-ricardo.ribalda@gmail.com>
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


--===============7510276472656004075==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="w4kmnulvTLkiEiiC"
Content-Disposition: inline


--w4kmnulvTLkiEiiC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 28, 2015 at 01:23:39PM +0100, Ricardo Ribalda Delgado wrote:
> This set of patches has been developed after using the core to access a spi
> nor flash. The initial performance was not as desired. The following changes
> have been done.

Applied everything except the MAX_CS change, thanks - that's fine, just
needs the define namespacing.

--w4kmnulvTLkiEiiC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUyTvOAAoJECTWi3JdVIfQAeIH/jY5M7AACxsPPc5/154+/igf
xB1YBGfVxVVq+wT3TTvTZwXKvfSjfWufV6FIdu0V/IDhLjn7u8+sPzJxdKRvs53+
haPmIzd9fh3EMyi9wo8IRkVoaaUAbF3jQ7565vI39e1lJQYMJ/Og9x+kNPqT5qGf
SYjrzHKivM0pi+lulOHkSSgQ0vHxPDFlvJqPZSnFgIyQJtFTqCt01+xbZUBk0+mw
HwxOyLoBkSktZLl8WUrWccm5zyzHvma0js/oTLpC0BtY8uwYBQ6u1D758Bzkcm/a
AXOX4ILu7QRhzOQiKnCROM++72gl+1mbJjjAGk2WyOaV+PJBz3vT7ZClUFf3mbo=
=ZkCl
-----END PGP SIGNATURE-----

--w4kmnulvTLkiEiiC--


--===============7510276472656004075==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7510276472656004075==--
