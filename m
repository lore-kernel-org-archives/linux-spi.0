From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] spi/rockchip: fix bug that case spi can't go as fast
 as slave request
Date: Thu, 16 Oct 2014 11:34:10 +0200
Message-ID: <20141016093410.GB2200@sirena.org.uk>
References: <1413372311-4203-1-git-send-email-addy.ke@rock-chips.com>
 <1413372349-4254-1-git-send-email-addy.ke@rock-chips.com>
 <20141015130452.GD27755@sirena.org.uk>
 <543F8CD2.1010302@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4636623562270950150=="
Cc: heiko@sntech.de, kever.yang@rock-chips.com, linux-kernel@vger.kernel.org,
 xjq@rock-chips.com, zyw@rock-chips.com, linux-rockchip@lists.infradead.org,
 grant.likely@linaro.org, hj@rock-chips.com, huangtao@rock-chips.com,
 devicetree@vger.kernel.org, amstan@google.com, yzq@rock-chips.com,
 zhangqing@rock-chips.com, cf@rock-chips.com, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, hl@rock-chips.com, dianders@chromium.org,
 linux-spi@vger.kernel.org, wei.luo@rock-chips.com, sonnyrao@google.com,
 olof@lixom.net, zhenfu.fang@rock-chips.com
To: addy ke <addy.ke@rock-chips.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <543F8CD2.1010302@rock-chips.com>
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


--===============4636623562270950150==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
Content-Disposition: inline


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 16, 2014 at 05:16:02PM +0800, addy ke wrote:
> On 2014/10/15 21:04, Mark Brown wrote:
> > On Wed, Oct 15, 2014 at 07:25:49PM +0800, Addy Ke wrote:

> >> +	if (WARN_ON(rs->speed > MAX_SCLK_OUT))
> >> +		rs->speed = MAX_SCLK_OUT;

> >> +	/* the minimum divsor is 2 */
> >> +	if (rs->max_freq < 2 * rs->speed) {
> >> +		clk_set_rate(rs->spiclk, 2 * rs->speed);
> >> +		rs->max_freq = clk_get_rate(rs->spiclk);
> >> +	}

> > I'll apply this but you should be checking the return code from
> > clk_set_rate() here, please send a followup patch doing that.  It might

> If clk_set_rate return error, do I only put dev_warn here or return error value to spi core?

It'd be better to return an error if we need to set the rate and can't
do it.

> > also be worth consdering just setting the rate unconditionally here, it
> > seems like it should make things simpler.

> I think we need.
> If we set the rate unconditionally here, clk_set_rate() will be executed in each spi transfer.

Is that really such a high cost?

--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUP5ERAAoJECTWi3JdVIfQxfgH+QGfQFD/KQ+OmRJyUPfMHGXX
6JdP9nSyawWv7+xoUgLK9rDuTnwOxJedbhsToh1wJDcjg3bOgrnoiWkbADNH1L/e
IHsMq+HJTZmv9xq4oaFx/vVHeFFPSsh2AtldEOMgmM50bGlg3M2sTo0Pg5mVdmIg
tEMCXUtXU1Ehs9OsZh0HT0sZK7H+sPD9VfFVwRE03EZRjIy6LtfEwCihCAB9/tMM
bGpomAJq7Az1BP5y5SWLru4X1H4uad4kaywaAUB6jqF35MlR1qXdAkjzFGZoBm91
vMd6ouDuDCfmg2NzKwIJ+mqXOWC7QijzlMmvkmUujef9aDyZAho5fXIwS66PKL8=
=lzOL
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--


--===============4636623562270950150==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4636623562270950150==--
