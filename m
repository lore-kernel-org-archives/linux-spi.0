From: Steffen Trumtrar <s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH 3/6] ASoC: wm8974: include MCLKDIV in pll_factors
Date: Fri,  9 Nov 2012 15:00:22 +0100
Message-ID: <1352469625-32024-4-git-send-email-s.trumtrar@pengutronix.de>
References: <1352469625-32024-1-git-send-email-s.trumtrar@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org,
	Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Steffen Trumtrar <s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	Liam Girdwood <lrg-l0cyMroinI0@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1352469625-32024-1-git-send-email-s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

To calculate the integer part of the frequency ratio, the whole output
path has to be considered (post and pre are optional):

	    Ndiv = (pre * target * 4 * post) / source

In the current implementation only the fixed- and pre-divider is
considered, but the post-divider is omitted.
To calculate Ndiv, this post divider has to be applied before any
calculation happens. Otherwise Ndiv is considered to be to low in the
later stages. This leads to a wrong value in the PLLN register, which
in turn produces a wrong playback speed of the audio signal.

This patch adds the post divider to the pll calculation.

Signed-off-by: Steffen Trumtrar <s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 sound/soc/codecs/wm8974.c |   39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8974.c b/sound/soc/codecs/wm8974.c
index 9a39511..b012e4d 100644
--- a/sound/soc/codecs/wm8974.c
+++ b/sound/soc/codecs/wm8974.c
@@ -275,16 +275,51 @@ struct pll_ {
  * to allow rounding later */
 #define FIXED_PLL_SIZE ((1 << 24) * 10)
 
-static void pll_factors(struct pll_ *pll_div,
+static void pll_factors(struct pll_ *pll_div, struct snd_soc_codec *codec,
 			unsigned int target, unsigned int source)
 {
 	unsigned long long Kpart;
 	unsigned int K, Ndiv, Nmod;
+	u16 reg;
 
 	/* There is a fixed divide by 4 in the output path */
+
 	target *= 4;
 
+	/* target also depends on MCLKDIV */
+	reg = (snd_soc_read(codec, WM8974_CLOCK) & 0xe0) >> 5;
+
+	switch (reg) {
+	case WM8974_MCLKDIV_1:
+				reg = 1;
+				break;
+	case WM8974_MCLKDIV_1_5:
+	case WM8974_MCLKDIV_2:
+				reg = 2;
+				break;
+	case WM8974_MCLKDIV_3:
+				reg = 3;
+				break;
+	case WM8974_MCLKDIV_4:
+				reg = 4;
+				break;
+	case WM8974_MCLKDIV_6:
+				reg = 6;
+				break;
+	case WM8974_MCLKDIV_8:
+				reg = 8;
+				break;
+	case WM8974_MCLKDIV_12:
+				reg = 12;
+				break;
+	default:
+				reg = 2;
+	}
+
+	target *= reg;
+
 	Ndiv = target / source;
+
 	if (Ndiv < 6) {
 		source /= 2;
 		pll_div->pre_div = 1;
@@ -333,7 +368,7 @@ static int wm8974_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 		return 0;
 	}
 
-	pll_factors(&pll_div, freq_out, freq_in);
+	pll_factors(&pll_div, codec, freq_out, freq_in);
 
 	snd_soc_write(codec, WM8974_PLLN, (pll_div.pre_div << 4) | pll_div.n);
 	snd_soc_write(codec, WM8974_PLLK1, pll_div.k >> 18);
-- 
1.7.10.4


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_nov
