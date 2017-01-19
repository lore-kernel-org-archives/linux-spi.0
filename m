From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v3 2/3] spi: pxa2xx: Prepare for edge-triggered interrupts
Date: Thu, 19 Jan 2017 20:37:40 +0100
Message-ID: <e692c4a9-6320-b9e0-d6e7-f58bbe6ba867@siemens.com>
References: <cover.1484592296.git.jan.kiszka@siemens.com>
 <cover.1484592296.git.jan.kiszka@siemens.com>
 <7b15a0910a3ad861fd32161c72559bafa7b71e29.1484592296.git.jan.kiszka@siemens.com>
 <87ziiqdstr.fsf@belgarion.home>
 <4d97e416-4d32-3b9f-0695-de116a4b26bd@siemens.com>
 <87r340eq28.fsf@belgarion.home>
 <b3e0d393-b841-1556-ddd2-5634f12b6f2c@siemens.com>
 <20170118124645.6ugjwbfeq5vsh2to@sirena.org.uk>
 <7e5fb21d-35bd-6ac3-9e6f-cffed656997f@siemens.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3986329901022099234=="
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-kernel@vger.kernel.org, Haojian Zhuang <haojian.zhuang@gmail.com>,
 linux-spi@vger.kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 Sascha Weisenberger <sascha.weisenberger@siemens.com>,
 Daniel Mack <daniel@zonque.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <7e5fb21d-35bd-6ac3-9e6f-cffed656997f@siemens.com>
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============3986329901022099234==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="MGgmsnHF44KlqhMKGCaEhePwqsahqAVSH"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MGgmsnHF44KlqhMKGCaEhePwqsahqAVSH
Content-Type: multipart/mixed; boundary="moGk529TTXn4CMRnGsuCv5BeaFVxSas4O";
 protected-headers="v1"
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Mark Brown <broonie@kernel.org>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>, linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Daniel Mack <daniel@zonque.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, linux-kernel@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Jarkko Nikula <jarkko.nikula@linux.intel.com>,
 Sascha Weisenberger <sascha.weisenberger@siemens.com>
Message-ID: <e692c4a9-6320-b9e0-d6e7-f58bbe6ba867@siemens.com>
Subject: [PATCH v3 2/3] spi: pxa2xx: Prepare for edge-triggered interrupts
References: <cover.1484592296.git.jan.kiszka@siemens.com>
 <cover.1484592296.git.jan.kiszka@siemens.com>
 <7b15a0910a3ad861fd32161c72559bafa7b71e29.1484592296.git.jan.kiszka@siemens.com>
 <87ziiqdstr.fsf@belgarion.home>
 <4d97e416-4d32-3b9f-0695-de116a4b26bd@siemens.com>
 <87r340eq28.fsf@belgarion.home>
 <b3e0d393-b841-1556-ddd2-5634f12b6f2c@siemens.com>
 <20170118124645.6ugjwbfeq5vsh2to@sirena.org.uk>
 <7e5fb21d-35bd-6ac3-9e6f-cffed656997f@siemens.com>
In-Reply-To: <7e5fb21d-35bd-6ac3-9e6f-cffed656997f@siemens.com>

--moGk529TTXn4CMRnGsuCv5BeaFVxSas4O
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

When using the a device with edge-triggered interrupts, such as MSIs,
the interrupt handler has to ensure that there is a point in time during
its execution where all interrupts sources are silent so that a new
event can trigger a new interrupt again.

This is achieved here by disabling all interrupt sources for a moment
before processing them according to the status register. If a new
interrupt should have arrived after we read the status, it will now
re-trigger the interrupt, even in edge mode.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Successfully tested by now.

Changes to v2:
- avoid inner looping by making the hardware retrigger on "forgotten"
  IRQ sources

 drivers/spi/spi-pxa2xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 0d10090..f9c2329 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -785,6 +785,9 @@ static irqreturn_t ssp_int(int irq, void *dev_id)
 	if (!(status & mask))
 		return IRQ_NONE;
=20
+	pxa2xx_spi_write(drv_data, SSCR1, sccr1_reg & ~drv_data->int_cr1);
+	pxa2xx_spi_write(drv_data, SSCR1, sccr1_reg);
+
 	if (!drv_data->master->cur_msg) {
 		handle_bad_msg(drv_data);
 		/* Never fail */
--=20
2.1.4


--moGk529TTXn4CMRnGsuCv5BeaFVxSas4O--

--MGgmsnHF44KlqhMKGCaEhePwqsahqAVSH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAliBFYUACgkQitSsb3rl5xQ45wCgssrJ83vvNz5I08hR3Qo98TWa
EM8AoO+7gM0G+htHEpHCNmsvlRLKhZZR
=XO/8
-----END PGP SIGNATURE-----

--MGgmsnHF44KlqhMKGCaEhePwqsahqAVSH--


--===============3986329901022099234==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3986329901022099234==--
