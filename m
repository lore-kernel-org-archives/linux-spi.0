From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] spi: spidev: Add device tree bindings
Date: Thu, 1 Nov 2012 14:55:27 +0000
Message-ID: <20121101145527.GR4413@opensource.wolfsonmicro.com>
References: <1351679410-11026-1-git-send-email-maxime.ripard@free-electrons.com>
 <1351679410-11026-2-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6895757118380046096=="
Cc: Grant Likely <grant.likely@secretlab.ca>,
 spi-devel-general@lists.sourceforge.net, Shawn Guo <shawn.guo@linaro.org>,
 linux-arm-kernel@lists.infradead.org, Brian Lilly <brian@crystalfontz.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1351679410-11026-2-git-send-email-maxime.ripard@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org


--===============6895757118380046096==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+bDoS+V4AJZnUgoC"
Content-Disposition: inline


--+bDoS+V4AJZnUgoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 31, 2012 at 11:30:08AM +0100, Maxime Ripard wrote:
> This will allow to probe spidev from device tree by adding the
> compatible string of each device to this array.

Applied, thanks.

--+bDoS+V4AJZnUgoC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQko1AAAoJELSic+t+oim94WoP/2ujBImJ5GjvP2QAygdvlgCu
8iezHVkEk7khRVimfaPEvN0eJsCvCHLwnRSA6DIU1SbagpNyP2NF1q7yql9LWgge
0hvB0fRrrcBk7/2yv+4ofonilqL6vV5YX0WKJwnSSG2AzkzpWseL8BtDLISgNoOx
yTdN7k+lH0Dh80bfCxpVboce/6ARn4656DfZDNMsGp2pjTqtDGCe6+o0qgru00oz
1eArTVF8PzmdDDUGT3YcMeeNeghOWDbfSt7IMh+m7AWIu8ONQnHHZivWNga5Svf6
6+Ob9esypv+eX8oVvm3UUnZklCy6r4dqwmppsKxMFptT+puwxTN4hF3tn1/M5a6n
HwxgsFQogDazdQpW+itsLlLee2LNwHXNbbIP+QVisfHnelA+5mlCxr+i/x/BTSX5
FAuw/m0BiuIMQY5rme3QmhyVolNAvGihiuiatBfYXJZmqGRFLYmUOEOS2kSuX7Nj
jfAun6Bv9FHUfQQ6/a7su2EabDWGvTfD9z9SzY2AFHEWNX7wkRgO6h/CDx62MiB+
olWWmaYzacqmSyXelIMOzmYvty2mQkdzXl6+UXUI0gnlUGwuS0hYYzpF8MtZxCs1
HNyIO7UtMGFjz30IGRzF4KQOBmsR/nOOUotpLAepKEaV9FwShGjypDuz/KYMDp/2
qUR4iEUfLK0X5aRGbHTR
=Dmuz
-----END PGP SIGNATURE-----

--+bDoS+V4AJZnUgoC--


--===============6895757118380046096==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6895757118380046096==--
