From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 23/31] spi: tegra: convert to standard DMA DT bindings
Date: Mon, 18 Nov 2013 18:41:17 +0000
Message-ID: <20131118184117.GT2674@sirena.org.uk>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-24-git-send-email-swarren@wwwdotorg.org>
 <20131116101422.GK15393@sirena.org.uk>
 <528A4EBB.2090800@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3533776855153633544=="
Cc: linux-tegra@vger.kernel.org, treding@nvidia.com,
 Stephen Warren <swarren@nvidia.com>, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <528A4EBB.2090800@wwwdotorg.org>
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


--===============3533776855153633544==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/7+LvQqw8N5lf/3J"
Content-Disposition: inline


--/7+LvQqw8N5lf/3J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 18, 2013 at 10:30:35AM -0700, Stephen Warren wrote:

> However, I suspect that the Tegra driver changes may need to be merged
> into any subsystem that's doing much other work on the Tegra drivers,
> especially any significant refactoring, so the subsystem would probably
> have to pick up the whole series anyway. Still, I'll make sure I
> re-order the branch to put the core changes first so we have as much
> flexibility as possible.

At least in the ASoC case my main consideration is other drivers wanting
to use the core changes rather than changes being made to the Tegra
drivers.  Let's try to just share the core code and merge the rest over
later if needed?

--/7+LvQqw8N5lf/3J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSil9KAAoJELSic+t+oim9WTgQAIJ6Eqdldg5yro5qlNh4x4Q2
XPXxhdpPMHNhXsCLLID8wjsiJ99p1Egg+V5yH1irDnXoTheLpzFKO05085BJhHeu
tMAkJgRH7rcqkuWbBmclkC4sUYsGPNhTu8+YSaseVn+1qTh1BA1LDHa3BNJiYVv/
wuYu3nrvevVKmp+yHANDsDtkMmANilBIBS9kjMehevNWIJ/Y4bmGFbaTgm2gI76C
O4bKXSl7Aoxf0y4aTtR1VhzeRXzdqyzA0M0DyIdDXfPbLBPVe3zpRtG+eHypSejB
D6+t0rY0XKgtzpw1u2qplYEXCNA0dUt6zrZiydtMJje2rgam6To70hWEhE+tFIX5
48whygErekuGGVrBdDpZqOQR90PBye7kl35lkQIdjdKAOduNNNUv5JnlnX+Qr89A
xR7HTTJLEsoVKveP3uwsak7kfWZhDuVKqM10Ia4FqDPCSAD/vm1KlQ3m9PK9Pp8G
9rV21oT/G2tohqKaqpt+N8wJV86iOfz0nAqe+hZG2LBprYbRlf9rzlg0No1ga6Gf
QUpsz0zjZENWo9jDxpsH0EQ7GbaZo6uL0piGAVw9S0HZ+Ek/Z+Xm9ImDFA2p9Ok1
a6mQzYMXThWZHgKCzO1HRaGvVEGcF1l3OMiYWfYXR33wvxLTwZf7dLMpBWjeCWte
t9vZIlDS+KVwDjRSiDA8
=K1yl
-----END PGP SIGNATURE-----

--/7+LvQqw8N5lf/3J--


--===============3533776855153633544==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3533776855153633544==--
