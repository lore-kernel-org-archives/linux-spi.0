From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH -next 25/36] spi: s3c24xx: use
 devm_platform_ioremap_resource() to simplify code
Date: Wed, 4 Sep 2019 17:13:48 +0100
Message-ID: <20190904161348.GE4348@sirena.co.uk>
References: <20190904135918.25352-1-yuehaibing@huawei.com>
 <20190904135918.25352-26-yuehaibing@huawei.com>
 <CAJKOXPdq4as1Oe3U+9znkvP0RA=sxUoiWVBCSbzf_wq_um2t=w@mail.gmail.com>
 <20190904143928.GB4348@sirena.co.uk>
 <CAJKOXPeRtbAvmR-=8Qa8ukGXt-cCj3ud_7y1Z4LgRpX3YCeumg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3310340839892836204=="
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
In-Reply-To: <CAJKOXPeRtbAvmR-=8Qa8ukGXt-cCj3ud_7y1Z4LgRpX3YCeumg@mail.gmail.com>
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


--===============3310340839892836204==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="N1GIdlSm9i+YlY4t"
Content-Disposition: inline


--N1GIdlSm9i+YlY4t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 04, 2019 at 05:09:45PM +0200, Krzysztof Kozlowski wrote:
> On Wed, 4 Sep 2019 at 16:39, Mark Brown <broonie@kernel.org> wrote:

> > I think it's reasonable, it's giving credit to the automated system
> > they've got running coccinelle (which they do mention in their commit
> > logs).  It doesn't really hurt anyone and lets people see their system
> > is finding stuff.

> Running internally coccinelle is already credited with commit author.
> The credits are coming with "From:" field.

I guess if other people look at the same CI and send patches as well
then there's some use tying them all together.

> Otherwise for commits I send I could use:
>   From: krzk
>   ...
>   Reported-by: www.krzk.eu
>   Signed-off-by: krzk
> To me it is ridiculous.

Sure, on the other hand it doesn't really cost anyone anything if you do
that.

> Different thing is that Reported-by is for fixing bugs or issues.
> There is no bug here. There is no problem solved except making the
> code smaller. That's not what is Reported-by for.

That is true, this one isn't fixing any bug but then the line does get a
bit fuzzy all round with things like warnings and coccinelle output -
even just having the warning pop up is noise for people looking at the
output even if there's no concrete problem.  Again I don't see it as
something that's worth getting worked up over.

--N1GIdlSm9i+YlY4t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1v4rsACgkQJNaLcl1U
h9ADfQf/V7pUFkik9p4ok45W4iQXJ+1Wee9ghMi2ut+nuRzX8NRSwWYnFgK3w119
nf1YXfJsWCcs9af+DjcSoEyJWq/wegSyF/egvEd36QdqtaJJbMs/J5Kl+TEcglDA
uRJW6F/zevMcwamDE2I6UqdQjTIa2R8QG2S9yaw36Hd2b0k38lLq2Z1knHnQNbX7
6mFEqyt+sTaFjsBtlkgeUiTkMp36WsnTY7oRzGr/RKAd9ByHDmQKtPTuJl4eQTx6
zzkUK0PzNpBPqNyILAt7MYr01EyZfO3gjxnRNIH8yKl+80mkhiV2Td6DJehCuNqE
F30QD0NUhsOuqyDT26hqXFcIWtym6A==
=GPj9
-----END PGP SIGNATURE-----

--N1GIdlSm9i+YlY4t--


--===============3310340839892836204==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3310340839892836204==--
