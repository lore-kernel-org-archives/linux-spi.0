From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: qup: skip clk_disable_unprepare if the device is
 already runtime suspended
Date: Thu, 1 Sep 2016 21:29:40 +0100
Message-ID: <20160901202940.GU5967@sirena.org.uk>
References: <1472128408-7231-1-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+k4Drb7WGefOwc9B"
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1472128408-7231-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--+k4Drb7WGefOwc9B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 25, 2016 at 01:33:28PM +0100, Sudeep Holla wrote:
> If the spi device is already runtime suspended, if spi_qup_suspend is
> executed during suspend-to-idle or suspend-to-ram it will result in the
> following splat:
>=20
> WARNING: CPU: 3 PID: 1593 at drivers/clk/clk.c:476 clk_core_unprepare+0x8=
0/0x90
> Modules linked in:
>=20
> CPU: 3 PID: 1593 Comm: bash Tainted: G        W       4.8.0-rc3 #14
> Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
> PC is at clk_core_unprepare+0x80/0x90
> LR is at clk_unprepare+0x28/0x40
> pc : [<ffff0000086eecf0>] lr : [<ffff0000086f0c58>] pstate: 60000145

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative then it's
usually better to pull out the relevant sections.

--+k4Drb7WGefOwc9B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXyI+zAAoJECTWi3JdVIfQVC0H/2EDpbTfV1Pa+9C4kLrUnCpo
hncxEg3HlKOehHm80vsO369v4hU9KQh/RbQHY9bHWm4RZOI0b2M3kehuP3sDyXGL
HWU+rOsv3TXM057cr0E140y/nF2UKuCKixn0eg//HJveCuyj1JBOKfx3AAZ8NmC2
V9MVGryDYbCv+WzrLidSEASEk1nypMImLvGrxT6GGRGpaNjlZmWvq53wIpwBtk/A
W/uHFRkxlVFiujn+KmlDDjpAD/OuYTkeSxnp5IM26Afi/6yos71c62d8vdbi6t+t
s5vuugAOvpsZSYy43eJ1ln7jfbjPPp+AWXgSqrrBcwmabJq3BwpHnegIqwuzNew=
=N6Cn
-----END PGP SIGNATURE-----

--+k4Drb7WGefOwc9B--
