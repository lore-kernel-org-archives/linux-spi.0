From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/6] spi: imx: specify spi base for device
	tree probe
Date: Fri, 9 Nov 2012 16:38:30 +0000
Message-ID: <20121109163830.GP23807@opensource.wolfsonmicro.com>
References: <1352469625-32024-1-git-send-email-s.trumtrar@pengutronix.de>
 <1352469625-32024-2-git-send-email-s.trumtrar@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8329117520095674208=="
Cc: alsa-devel@alsa-project.org, Sascha Hauer <kernel@pengutronix.de>,
 devicetree-discuss@lists.ozlabs.org, patches@opensource.wolfsonmicro.com,
 Grant Likely <grant.likely@secretlab.ca>, Rob Herring <robherring2@gmail.com>,
 Rob Landley <rob@landley.net>, spi-devel-general@lists.sourceforge.net,
 Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1352469625-32024-2-git-send-email-s.trumtrar@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
List-Id: linux-spi.vger.kernel.org


--===============8329117520095674208==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h9WqFG8zn/Mwlkpe"
Content-Disposition: inline


--h9WqFG8zn/Mwlkpe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 09, 2012 at 03:00:20PM +0100, Steffen Trumtrar wrote:

> * This breaks compatibility with user space applications between non-DT and DT.

> * On platforms that are in between DT and non-DT, it breaks registration of
>   devices via spi_board_info.

> Use the same method as 7e6086d9e54a159a6257c02bb7fc5805c614aad2 does for gpios:
> Use alias to identify the spi port, and then specify the base via the port id.
> If alias is not defined in DT, allocate the base dynamically.

This sounds like a fix userspace and/or complete your DT conversion
problem...

--h9WqFG8zn/Mwlkpe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQnTGAAAoJELSic+t+oim9hl4P/11g0Vg66oKTEMRSMxQ0O80Y
a34oXWqks6huwmiRiu4vLU6CzDHiwSaJoj7uPS+RVOPlMtDpb9nzXDXvTkfCfIHo
bBsQQlLuVNMJLXDt0l3HTdngEUkTdMoM9K7LsItQZnuJrm2O61m8bH2pt/80JAZZ
Sv/2uQdF+Ww8sY9D7yyPhAe2QF4cR877W2oI48aep4pVxl+eSYNOEf6VOMXv4DBk
BkDXNXsOxy5CQ4dZuk6MsOsyGPw5YQR++SQBdJdk+PsOWcytq2bOW6kWC8gSbql3
Oauco9h2o3EdTIvTNm5h86gfdql+byMQpRxy4dvzFTZ/qHDY6NICq/nt1fZDVmWT
XheNyPW3gM5ddDQLYFG8KI5tq0G1DuHOqXo99dLsiQ/1UzlJUnOw0om3Eb6DEiln
6fph4UyPdprELK7bvGMwQlgfvsTOx2Ka2zeXiJ6RQGI9XdKmAMUhul3kM4WxYDz+
xGYdASQhXImTVLBpn1TqQS9bQg0J8S2DPIXrSOQ9c0uhSL10rSZnw4fzHoa2Mz3H
Ghwn9QHBZ2gMN4/ZmVgMZ+xrTCOCoR4AA3ckN4dB7122XnkNCjPpvqZF+M9NN9bi
hrIoSfsBOEvEcnXHSqIwQUOSRro3wNtD54M5OAX8uZYfHD9Pdp3cZEwXnWqpJeyL
NEmab4NkbvTDbjD2jX6M
=5+vC
-----END PGP SIGNATURE-----

--h9WqFG8zn/Mwlkpe--

--===============8329117520095674208==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8329117520095674208==--
