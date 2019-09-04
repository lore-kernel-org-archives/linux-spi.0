From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH -next 25/36] spi: s3c24xx: use
 devm_platform_ioremap_resource() to simplify code
Date: Wed, 4 Sep 2019 15:39:28 +0100
Message-ID: <20190904143928.GB4348@sirena.co.uk>
References: <20190904135918.25352-1-yuehaibing@huawei.com>
 <20190904135918.25352-26-yuehaibing@huawei.com>
 <CAJKOXPdq4as1Oe3U+9znkvP0RA=sxUoiWVBCSbzf_wq_um2t=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7906620464499928946=="
Cc: tmaimon77@gmail.com, palmer@sifive.com, tali.perry1@gmail.com,
 eric@anholt.net, ldewangan@nvidia.com, linux-riscv@lists.infradead.org,
 festevam@gmail.com, f.fainelli@gmail.com, benjaminfair@google.com,
 shc_work@mail.ru, khilman@baylibre.com, openbmc@lists.ozlabs.org,
 YueHaibing <yuehaibing@huawei.com>, michal.simek@xilinx.com,
 jonathanh@nvidia.com, yuenn@google.com, wens@csie.org, agross@kernel.org,
 bcm-kernel-feedback-list@broadcom.com, linux-imx@nxp.com,
 linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
 Andi Shyti <andi@etezian.org>, rjui@broadcom.com, s.hauer@pengutronix.de,
 mripard@kernel.org,
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 linux-mediatek@lists.infradead.org, linux-rpi-kernel@lists.infradead.org,
 paul.walmsley@sifive.com, matthias.bgg@gmail.com,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAJKOXPdq4as1Oe3U+9znkvP0RA=sxUoiWVBCSbzf_wq_um2t=w@mail.gmail.com>
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


--===============7906620464499928946==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GID0FwUMdk1T2AWN"
Content-Disposition: inline


--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 04, 2019 at 04:28:29PM +0200, Krzysztof Kozlowski wrote:
> On Wed, 4 Sep 2019 at 16:00, YueHaibing <yuehaibing@huawei.com> wrote:

> > Reported-by: Hulk Robot <hulkci@huawei.com>

> This tag does not look real... First of all where is the report?
> Second, it was reported by coccinelle.
> Reported-by should be use to give real credits.

I think it's reasonable, it's giving credit to the automated system
they've got running coccinelle (which they do mention in their commit
logs).  It doesn't really hurt anyone and lets people see their system
is finding stuff.

--GID0FwUMdk1T2AWN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1vzJ8ACgkQJNaLcl1U
h9C55Qf9ElRCnBTb/SuDEmM1YeY2Tw9dAMV0y2jsYTl6UYAcJqOg3iMhAjCNbAVd
K59JgRS+lKB/HrEidQ3L3QfwZfOPhtyOEY5BmhZekABU6SI9ggg6VPIg8jqkOFQw
8poyZkiuaDhdrDn5rfdOSLpAQ7wls/djlfQ+zeoD0EdoiF5dtadKphhA1dT5NuvV
szO9xfucbd5yuUBQuUPW3M5tTkXlfyN86C8I1NkgZ26Ozrz5IYHrr+Tmp8++LBUs
GheNNGndIR/W/3pgCevW340G3aEqQ0G34v9pk1/HOWYuwVS2S1jhaSl77YTk1wZ5
jDsHN8NDORkPvAnmKmyFVlA1Z3W17A==
=5oz7
-----END PGP SIGNATURE-----

--GID0FwUMdk1T2AWN--


--===============7906620464499928946==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7906620464499928946==--
