From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 02/15] spi/xilinx: Leave the IRQ always enabled.
Date: Wed, 28 Jan 2015 19:38:20 +0000
Message-ID: <20150128193820.GJ21293@sirena.org.uk>
References: <1422447834-23116-1-git-send-email-ricardo.ribalda@gmail.com>
 <1422447834-23116-3-git-send-email-ricardo.ribalda@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6137348011148092725=="
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Michal Simek <michal.simek@xilinx.com>,
 =?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>,
 linux-spi@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1422447834-23116-3-git-send-email-ricardo.ribalda@gmail.com>
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


--===============6137348011148092725==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GMAK4tsM7WHnyxbM"
Content-Disposition: inline


--GMAK4tsM7WHnyxbM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2015 at 01:23:41PM +0100, Ricardo Ribalda Delgado wrote:
> Instead of enabling the IRQ and disabling it for every transaction.
>=20
> Specially the small transactions (1,2 words) benefit from removing 3 bus
> accesses.

For this particular change I don't think it matters but in general
moving things that do need to be enabled and disabled to
{un,}prepare_transfer_hardware() will avoid quite a bit of overhead
under load.

--GMAK4tsM7WHnyxbM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUyTqrAAoJECTWi3JdVIfQxZUH/jJTTkEYThZvBD050a87k2Tg
CeNoDZAKEaKWT/2BN2WFG6LlPb23eeVnoeqx1cA6UAUI9v8ZkkZR1+dLJBp30oRl
JZ3NS9QkR7f+nYASW0GKJORvmYy58D1x+9kUk5Xyu0wOYawUwvTJNAKACH9EO1Uo
pqn62FJsV1rvYlkcdww6eIIt6XuTPF1tt0W3E7l5jwuj4mgB5Oh3DVk/Q9DNC/0Z
EQrFUCLqk5uz6MT3v6CEecTw4IC6sFaduIBaCAxVui3H32YU+hcgm3tVYhYCn6Tv
jusuIEvMke3wfk898Eafqmle6otcB8YZTWVley9RARVH6IVpDGPya7hDT7V/Vow=
=7G/h
-----END PGP SIGNATURE-----

--GMAK4tsM7WHnyxbM--


--===============6137348011148092725==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6137348011148092725==--
