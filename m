From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] spi: spidev: Add Rohm DH2228FV DAC compatible string
Date: Thu, 1 Nov 2012 14:56:06 +0000
Message-ID: <20121101145606.GS4413@opensource.wolfsonmicro.com>
References: <1351679410-11026-1-git-send-email-maxime.ripard@free-electrons.com>
 <1351679410-11026-3-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2406148391784084150=="
Cc: Grant Likely <grant.likely@secretlab.ca>,
 spi-devel-general@lists.sourceforge.net, Shawn Guo <shawn.guo@linaro.org>,
 linux-arm-kernel@lists.infradead.org, Brian Lilly <brian@crystalfontz.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1351679410-11026-3-git-send-email-maxime.ripard@free-electrons.com>
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


--===============2406148391784084150==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mvzZjokS1nTZS3h1"
Content-Disposition: inline


--mvzZjokS1nTZS3h1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 31, 2012 at 11:30:09AM +0100, Maxime Ripard wrote:
> Since we don't have a driver for it yet, use spidev instead.

Applied, thanks.

--mvzZjokS1nTZS3h1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQko2AAAoJELSic+t+oim9ZgEQAIPmV8DjOKxC2xZ47EjAVxJR
Xi0SYmwqyN/gcn1gmlhdLu3ksonBotCbNizUrSWXdm0uvasCQUfTZ2Hjo6btsylQ
TEKbB1zWtiBB6tuHq+dFG93qmJvuvI/RQTX3WMO257zefjn5t84AtUZM2duRkjSk
TXD6K+d5AXse5CdJ0hVQIkRNvQmzQ+xnSEeHEjzepr8TB2N2WPRn+CuzxsCSosD+
0oUVb8+HphICrlU7Mk6H2fFvHUePq6uK+d0RsRBh2YSCvw0FMuYcfMZLNQvfhquJ
IydiKis+76q/gXjRD/DeGyWyLCdPcEK7MhWZ/OPO/zywTVVtqwtnlNlTbHERlPqv
8MxZiz4CR+4CB4QEji6RHU7ygF0XQ2DJ3g2lI53/phS7yb3U3gE5o5qcnlqCMUm+
COl57jWGklXuO2UWl0mYyzD4iY3xhxnBb3MXO5kZ3JHNn4Ry6cWUwj9aVvlwrI0S
MZAGsDmxzoROUVGK8LtZm50U7Z3IzveXLIeOpRHzmLypimiXcaqQzJ3UnnIjgLpn
ovJsgG/ynCnMrcjD0WDdt/8T7+zJ/244NYfkV5YNdjUd3KbdoFihyijUjscSh6O9
pDY5imrNTdW2Nd7k8A5x+7uu0ly7HYVqDpafRjhGB3PKkGPy5ewEIncl3oWgq/kz
bNjSS77MEsx3/8VFdfIA
=QoJh
-----END PGP SIGNATURE-----

--mvzZjokS1nTZS3h1--


--===============2406148391784084150==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2406148391784084150==--
