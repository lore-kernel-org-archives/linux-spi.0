From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 02/11] spi: spi-sh-msiof: round up div to fix freq
 calculation
Date: Mon, 2 Dec 2013 12:48:43 +0000
Message-ID: <20131202124843.GC27568@sirena.org.uk>
References: <20131202031557.162e78d407d82effdee627ac@ops.dti.ne.jp>
 <1385921962-19843-1-git-send-email-takasi-y@ops.dti.ne.jp>
 <1385921962-19843-2-git-send-email-takasi-y@ops.dti.ne.jp>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XGa5gNSGTk93P04E"
Cc: linux-sh@vger.kernel.org, Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-spi@vger.kernel.org
To: takasi-y@ops.dti.ne.jp
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1385921962-19843-2-git-send-email-takasi-y@ops.dti.ne.jp>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--XGa5gNSGTk93P04E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 02, 2013 at 03:19:13AM +0900, takasi-y@ops.dti.ne.jp wrote:
> From: Takashi Yoshii <takasi-y@ops.dti.ne.jp>
>=20
> Truncation on integer division in sh_msiof_spi_set_clk_regs()
> results in insufficient transfer frequency (> max_speed_freq).

Applied, thanks.

--XGa5gNSGTk93P04E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnIGnAAoJELSic+t+oim9JKUP/RR+dgGkloQEDCl01/bP8Sch
FtJEvjGhNuVxVWHHri2zJqPqrobe959PQOqKhG8OPVE/JvmprFW35CK1+CgnZcX9
ZoGsJClOraQjVA3LFnwHwNciMJxP4YOscvDzGzrN0Sl3GEsdN3tOpbFtIzRzIJTE
RyjAwSX7hUE8sDSt+eJTlAX5e4LX1AAgWbvg/mrHXTM5Rq+rvweWKdUtxp4x+HY0
gAYv0/ZG9pc/Ba7u8NdfkpYYP/nei9rayQLoeJ/3336126j0tZS00tMcOF8hoPzq
l2zs/hYhFEoJMz/il2Y7zq+gKtV0l/y6TI4FUCHQaIsEtB5GsHWBnxccHou18/Yt
jmBM+HMRTNz4ckLQ0FAzzk+zXAH5bYLZYVZkmrpviGOTmu73ihoxUjXtqLv841EN
gFknV6XTnhvCEUfiuAkEFdjmiudqwAJBucCRIZ0VHCqX8xiLB6+f/sbN+8XOKhzz
ZBI/7yp3fT5AsPMa65dqfb4ndYxm25Qb9aOGtP2zyX/rBjERWMeqJFyzb+MFfmBG
/y7acphW3CvimzwtquE9GWtynfscSvY6zNHVPBHh1xHLhn0EeiehtnD0tnLRqD1n
XHPB0W2MX3Ml1YCCY9ILSCVcRcGyOwYVq+HGFBbNy5FoPTRI2ZradEo3cq3e6kRn
MYIAWQWd3/uwUiQFXTZ0
=Yr0F
-----END PGP SIGNATURE-----

--XGa5gNSGTk93P04E--
