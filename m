From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] spi/rockchip: fix bug that cause spi transfer timed
 out in DMA duplex mode
Date: Thu, 16 Oct 2014 11:34:40 +0200
Message-ID: <20141016093440.GC2200@sirena.org.uk>
References: <1413372311-4203-1-git-send-email-addy.ke@rock-chips.com>
 <1413372378-4309-1-git-send-email-addy.ke@rock-chips.com>
 <20141015130547.GE27755@sirena.org.uk>
 <543F8F2A.9040904@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8319858234307316899=="
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
In-Reply-To: <543F8F2A.9040904@rock-chips.com>
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


--===============8319858234307316899==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pAwQNkOnpTn9IO2O"
Content-Disposition: inline


--pAwQNkOnpTn9IO2O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 16, 2014 at 05:26:02PM +0800, addy ke wrote:

> The following changes is nessarry:(if tx complete, spi must be disabled too)
> diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
> index 153269b..87bc16f 100644

Please send this using the normal submission process.

--pAwQNkOnpTn9IO2O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUP5EvAAoJECTWi3JdVIfQCXQH/RU6JwnyaxOhvqyazCG1SBn/
mAWJ2EyFc+hhm1ao/caDwG0TKP1HXS35JbflhETePYeTaiVvmG7RDRvsRXDHe/qi
G6vWXcxdalH3tcCES+CUAbFcW1RAgbUjlWKjIOGB1Z04F4x7OusdRoqQZhKCMr9D
OhEFP0z3iH3s8ET4hPUw1vv4HzNFVBrndSZfGKi7KCUPpNAseplII49ZigaFC8KX
4o86FWM0qJt9wy7y2VHQxYXaapjoYeHiAyEmT6dfAYsQE0yNmaXoNo2OWvYiv7HX
wT+Zpo4goW4ZVG40AwLIyqmhBMWxn48X4MfFU/ieLGJa+mpqWoJ6eokYYuv7dL0=
=mqAw
-----END PGP SIGNATURE-----

--pAwQNkOnpTn9IO2O--


--===============8319858234307316899==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8319858234307316899==--
