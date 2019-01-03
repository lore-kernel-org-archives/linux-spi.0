From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 lora-next 5/5] net: lora: sx125x sx1301: allow radio
 to register as a clk provider
Date: Thu, 3 Jan 2019 12:37:20 +0000
Message-ID: <20190103123720.GR1846@sirena.org.uk>
References: <1539361567-3602-1-git-send-email-ben.whitten@lairdtech.com>
 <1539361567-3602-6-git-send-email-ben.whitten@lairdtech.com>
 <a89c7974-672f-e5d0-8022-d2c2f9ffeac0@suse.de>
 <d22f1f18-0c93-a537-a439-07363174a03b@suse.de>
 <491d1a46-c112-1106-9f25-14149f0dcbd0@suse.de>
 <20181231175034.GI1846@sirena.org.uk>
 <ae7dd20c-777e-e043-127c-819fa0ae4792@suse.de>
 <1904336c-3349-b22b-18ac-e82e4afebc51@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6046854612886661279=="
Cc: Ben Whitten <ben.whitten@gmail.com>,
 devicetree <devicetree@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Maxime Ripard <maxime.ripard@bootlin.com>, netdev@vger.kernel.org,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@codeaurora.org>,
 "linux-lpwan@lists.infradead.org" <linux-lpwan@lists.infradead.org>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Russell King <linux@armlinux.org.uk>, starnight@g.ncu.edu.tw,
 linux-clk <linux-clk@vger.kernel.org>, linux-kernel@vger.kernel.org
To: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1904336c-3349-b22b-18ac-e82e4afebc51@suse.de>
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


--===============6046854612886661279==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l2C7pJE7HE4aLL3l"
Content-Disposition: inline


--l2C7pJE7HE4aLL3l
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 02, 2019 at 01:44:40AM +0100, Andreas F=E4rber wrote:

> So, the third invocation of sun6i_transfer_one() calling clk_get_rate()
> hangs at the prepare_lock instead of reference-counting, because it runs
> from a separate kthread, unlike the two previous calls?

If there's any contestation for the bus we push all the I/O through a
separate thread to maintain ordering and improve performance.

> I did not find any *regmap_init_spi() based example in drivers/clk/, and
> all other "spi" mentions in drivers/clk/ appeared to be clock names.
> The closest was devm_regmap_init_i2c() based clk-cdce706.c, which uses
> the prepare/unprepare ops, as suggested by Mark, and does
> regmap_update_bits() from there.

You'll find a bunch of the MFDs have SPI options as well.

--l2C7pJE7HE4aLL3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwuAf8ACgkQJNaLcl1U
h9B0fgf+L5M5NYjkOb8YWAmiLMYKo32qz8zumAKB3jHRMDLhmVZ11snwrNem9O1u
a9uD3TkuRJqmhjiGU41W0F+7+72K6RVlQHqQXBTCbvBp2NtnwPUlwRsJyDMjfuoE
m+Tc1NWzViVdxoSBK1GwGc49gZcZtqLT0gfInSOCSyhDQpD815qpSaBH72jh3oNa
txSLnhegZan3tHsatH0Vi0Ly8JweQ+RMG3GV9vWe4DgPAA8kM1/p2Pg7pCVUPb6O
jwFZEtXHVKW4ZRQ093OPH+1ReH31GoxKnXkw0S8cq4vnLqbnxcTpRrs8X8DypCbF
ofLLAAWzlMrfyfXw0tF5wjGAI0x/fg==
=fEFJ
-----END PGP SIGNATURE-----

--l2C7pJE7HE4aLL3l--


--===============6046854612886661279==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6046854612886661279==--
