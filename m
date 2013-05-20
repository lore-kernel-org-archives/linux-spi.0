From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RESEND] spi: sirf: fix the issue while transferring more
 than 256 words
Date: Mon, 20 May 2013 11:09:30 -0500
Message-ID: <20130520160930.GX1627@sirena.org.uk>
References: <1368877566-27812-1-git-send-email-Baohua.Song@csr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8726660592685642137=="
Cc: Qipan Li <Qipan.Li@csr.com>, Workgroup.Linux@csr.com,
 Zhiwu Song <Zhiwu.Song@csr.com>, Barry Song <Baohua.Song@csr.com>,
 grant.likely@linaro.org, spi-devel-general@lists.sourceforge.net,
 linux-arm-kernel@lists.infradead.org
To: Barry Song <21cnbao@gmail.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1368877566-27812-1-git-send-email-Baohua.Song@csr.com>
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


--===============8726660592685642137==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kjzasy1UhXmRStS5"
Content-Disposition: inline


--kjzasy1UhXmRStS5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 18, 2013 at 07:46:06PM +0800, Barry Song wrote:
> From: Qipan Li <Qipan.Li@csr.com>
>=20
> currently, spi irq handler only does rx processing and fetching data from=
 rx
> fifo when "FRM_END" irq happens. FRM_END indicates one transfer completes=
=2E if
> rx size is less than 256, it works well.

Applied, thanks.

--kjzasy1UhXmRStS5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRmkq3AAoJELSic+t+oim9MSAP/iCP+oXCtklq6szMwhZxxE4u
Oo5bbiQdoT9ZWrzXYkOfKHt7mk/2eqQbBqqOWpKptNVQm3yaN2r959lCqlC/hNhP
wHIkSGbBi4FQ9G8nWnKkM6NbqlCXxfb22gLwaIJcM39YZ9sjKLZsHKuGHSo4seDh
dAu2XrjHYd9He7MBckuFvGUdPSMT4i5MRtnaC9mI+IwmhnN45GM3w8LyJ4AtGCcd
WVkYJxq8ROd99W0xovaDCGdGX+jxZYbgs88q6s+CAS1swyN+dgaQWhnfq56UEEtD
z6VeivKjw/pBORpSgiClS3MwCwC/4KrVtW/Bkb2xPR5sj65pvz6zEOSiNEnjCW1w
QdNLuiK1f0O7s+Zrp+jxGBPlTuhofLD1rXshIj33di46ZiHTvaPWT7XtvrTLtqNA
m/+3nl6ydWf72C4WKiKla4wRjhV6mF/a9PWEZ6EDF6RQWWrEuTPb0cR7y02QpnC+
6rqPHQTlCO3Ni5blZTIy4Zog4h8tkskQAXbM7HUKF6a/4/Ca5kB2DGSnJsnNIg7O
HT1DYSXVitb5FGc0Ra/pVKN4ck55WXIJ9cPYXZyzCA9UIqlEM5T3hV3sUEQ5Qegy
xgyhnr5Hr1a9wJg6zvXpNf0hgwbRH9O9LKquee479f8ov93+7NwEs/2yolXuf2p+
IBMxVOh9qCRHwjKWs7Tb
=Iyvp
-----END PGP SIGNATURE-----

--kjzasy1UhXmRStS5--


--===============8726660592685642137==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8726660592685642137==--
