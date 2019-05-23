From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 2/3] spi: Allow SPI devices to request the pumping
 thread be realtime
Date: Thu, 23 May 2019 14:46:25 +0100
Message-ID: <20190523134625.GG17245@sirena.org.uk>
References: <20190515164814.258898-1-dianders@chromium.org>
 <20190515164814.258898-3-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3101645039599833252=="
Cc: drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
 linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
 Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>,
 Guenter Roeck <groeck-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Benson Leung <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
To: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190515164814.258898-3-dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--===============3101645039599833252==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bO4vSxwwZtUjUWHo"
Content-Disposition: inline


--bO4vSxwwZtUjUWHo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 15, 2019 at 09:48:12AM -0700, Douglas Anderson wrote:
> Right now the only way to get the SPI pumping thread bumped up to
> realtime priority is for the controller to request it.  However it may
> be that the controller works fine with the normal priority but
> communication to a particular SPI device on the bus needs realtime
> priority.

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-rt-pump

for you to fetch changes up to 924b5867e7bd6a6a98014f0517b747465b108011:

  spi: Allow SPI devices to request the pumping thread be realtime (2019-05-23 14:44:02 +0100)

----------------------------------------------------------------
spi: Allow setting pump to RT priority

----------------------------------------------------------------
Douglas Anderson (1):
      spi: Allow SPI devices to request the pumping thread be realtime

 drivers/spi/spi.c       | 36 ++++++++++++++++++++++++++++++------
 include/linux/spi/spi.h |  2 ++
 2 files changed, 32 insertions(+), 6 deletions(-)

--bO4vSxwwZtUjUWHo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzmpDEACgkQJNaLcl1U
h9AT8wf9HCQwiI9ChQBim3VkHh1VA8vwPgC20zoPo4PUGPcvvaWX5I3lrUoeCp1Q
vpMaUDp9J8OQ57wbmNFjqYYwLAK66XMUPQmqyH6q+1m1JSp5FP41aVGkJD32UOnk
wqsDdznTOvdDrgnVtJWtqjSWiK18M4OQJhIJGwe0wBRIfk+bpQDa+s+R34wgHCt8
xGJZcdJagggMsco0HvSgLuIRcIVuLbsCiu9Vxh1GR3ko3x7xLUVhkoKzxJ81qVu1
99KmShuE/rXn2IKU0lfC6WjItvey3r1RWyKFsSd7xKI6Izz45lNFrUlgrSOyLW4R
NqMXjQUeC/nEluG0IIC4X0mbopIIsw==
=Xgy/
-----END PGP SIGNATURE-----

--bO4vSxwwZtUjUWHo--


--===============3101645039599833252==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-rockchip mailing list
Linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-rockchip

--===============3101645039599833252==--
