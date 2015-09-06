From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v4 09/10] snd: dmaengine-pcm: add snd_dmaengine_pcm_get_quirks interface
Date: Sun,  6 Sep 2015 09:13:16 +0800
Message-ID: <1441501996-14075-1-git-send-email-shawn.lin@rock-chips.com>
References: <1441501881-13700-1-git-send-email-shawn.lin@rock-chips.com>
Cc: Doug Anderson <dianders@chromium.org>,
	Olof Johansson <olofj@google.com>,
	Sonny Rao <sonnyrao@chromium.org>,
	Addy Ke <addy.ke@rock-chips.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org,
	linux-spi@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
To: Vinod Koul <vinod.koul@intel.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441501881-13700-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add snd_dmaengine_pcm_get_quirks for I2S devices to query
dma controller's quirks if they need it to make special workaround
due to broken dma controller design

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None
Changes in v1: None

 sound/soc/soc-generic-dmaengine-pcm.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 6fd1906..42136005 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -466,4 +466,28 @@ void snd_dmaengine_pcm_unregister(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_unregister);
 
+
+/**
+ * snd_dmaengine_pcm_get_quirks - Get dmaengine quirks based PCM device
+ * @dev: Parent device the PCM was register with
+ */
+int snd_dmaengine_pcm_get_quirks(struct device *dev)
+{
+	struct snd_soc_platform *platform;
+	struct dmaengine_pcm *pcm;
+	int ret = -ENODEV;
+
+	platform = snd_soc_lookup_platform(dev);
+	if (!platform)
+		return ret;
+
+	pcm = soc_platform_to_pcm(platform);
+
+	if (pcm->chan)
+		ret = dmaengine_get_quirks(pcm->chan[0]);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_get_quirks);
+
 MODULE_LICENSE("GPL");
-- 
2.3.7
