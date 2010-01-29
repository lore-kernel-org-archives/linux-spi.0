From: "Pietrek, Markus" <Markus.Pietrek-BU0Y/NROKIiELgA04lAiVw@public.gmane.org>
Subject: [PATCH] Fixed data sampling on the correct edge
Date: Fri, 29 Jan 2010 14:37:13 +0100
Message-ID: <95F51F4B902CAC40AF459205F6322F0171E8D4987E@BMK019S01.emtrion.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Language: de-DE
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi,

it seems to me that the spi_sh_msiof.c driver configures REDG and TEDG wrongly. TEDG==0 outputs data at the **rising edge** of the clock and REDG==0 samples data at the **falling edge** of the clock. Therefore for SPI, TEDG must be equal to REDG, otherwise the last byte received is not sampled in the SPI mode 3

The SH7723 HW Reference Manual explains the setting in Figure 20.20 and Figure 20.21 ("SPI Clock and data timing")


Signed-off-by: Markus Pietrek <markus.pietrek-BU0Y/NROKIiELgA04lAiVw@public.gmane.org>
Acked-by: Magnus Damm <damm-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>

---
 drivers/spi/spi_sh_msiof.c |   14 ++++++--------
 1 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi_sh_msiof.c b/drivers/spi/spi_sh_msiof.c
index 51e5e1d..af15e97 100644
--- a/drivers/spi/spi_sh_msiof.c
+++ b/drivers/spi/spi_sh_msiof.c
@@ -173,13 +173,11 @@ static void sh_msiof_spi_set_pin_regs(struct sh_msiof_spi_priv *p,
        int edge;

        /*
-        * CPOL CPHA     TSCKIZ RSCKIZ TEDG REDG(!)
-        *    0    0         10     10    1    0
-        *    0    1         10     10    0    1
-        *    1    0         11     11    0    1
-        *    1    1         11     11    1    0
-        *
-        * (!) Note: REDG is inverted recommended data sheet setting
+        * CPOL CPHA     TSCKIZ RSCKIZ TEDG REDG
+        *    0    0         10     10    1    1
+        *    0    1         10     10    0    0
+        *    1    0         11     11    0    0
+        *    1    1         11     11    1    1
         */

        sh_msiof_write(p, FCTR, 0);
@@ -193,7 +191,7 @@ static void sh_msiof_spi_set_pin_regs(struct sh_msiof_spi_priv *p,
        edge = cpol ? cpha : !cpha;

        tmp |= edge << 27; /* TEDG */
-       tmp |= !edge << 26; /* REDG */
+       tmp |= edge << 26; /* REDG */
        tmp |= (tx_hi_z ? 2 : 0) << 22; /* TXDIZ */
        sh_msiof_write(p, CTR, tmp);
 }

_____________________________________

Amtsgericht Mannheim
HRB 110 300
Gesch?ftsf?hrer: Dieter Baur, Ramona Maurer
_____________________________________

Important Note:
- This e-mail may contain trade secrets or privileged, undisclosed or otherwise confidential information.
- If you have received this e-mail in error, you are hereby notified that any review, copying or distribution of it is strictly prohibited.
- Please inform us immediately and destroy the original transmittal.

Thank you for your cooperation.

------------------------------------------------------------------------------
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the business
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
