From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH for-4.20] spi: bcm2835: Unbreak the build of esoteric
 configs
Date: Thu, 29 Nov 2018 15:31:05 +0000
Message-ID: <20181129153105.GF10570@sirena.org.uk>
References: <4a53a5c59b9e454476a2313735d6353428e982cb.1543500560.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5834582760590313441=="
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Noralf Tronnes <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>,
 linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Frank Pavlic <f.pavlic-XB/JSsFECOqzQB+pC5nmwQ@public.gmane.org>
To: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <4a53a5c59b9e454476a2313735d6353428e982cb.1543500560.git.lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--===============5834582760590313441==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+ts6NCQ4mrNQIV8p"
Content-Disposition: inline


--+ts6NCQ4mrNQIV8p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 29, 2018 at 03:14:49PM +0100, Lukas Wunner wrote:

> Unfortunately the commit was applied despite prior warning that it needs
> to be respun:
> https://marc.info/?l=linux-spi&m=154186019626675&w=2

Sorry about that, I started scanning the changelog when it hit
discussion about doing a more involved fix for -next - it's good to draw
attention to reasons not to merge the patch a bit more prominently as it
helps avoid things like that.

--+ts6NCQ4mrNQIV8p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwABikACgkQJNaLcl1U
h9BXqAf/TvYJAy2z4fzX7+i6q/yqmvYzj3LTz5V6/Y8dxdstM9weM3QBpl2fM5Jo
sUM/jkZsTH0eDPAhVTna1zuZAS3OY2sR+sreVxAaDde+9TtlXEkao9lT/3WjDfnu
HWB8FoSBaslShnn5jqhlR+mgERelQd+ZrdAalBwjpH6b1tFtXAjgi4ZMCDjjdYhj
ejNfOWjmrU5Nh44zgACYMomcztFaYgOhRIgIgHGybRLbIUCUW8+uRBZFYLEIryhN
QLjWpAw8pZn3YreiVIpLQ0f55M7Rlc/op/URZt7vTT3XUa9o5wfCC3Qavgf/jgZX
cOnmDlfdFeGiaIA3ZQth0fZDqROigA==
=0FmN
-----END PGP SIGNATURE-----

--+ts6NCQ4mrNQIV8p--


--===============5834582760590313441==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-rpi-kernel mailing list
linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel

--===============5834582760590313441==--
