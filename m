From: kbuild test robot <lkp@intel.com>
Subject: Re: [alsa-devel] [PATCH v6 09/10] snd: dmaengine-pcm: add
 snd_dmaengine_pcm_get_caps interface
Date: Thu, 15 Oct 2015 11:07:28 +0800
Message-ID: <201510151102.w2eXs34z%fengguang.wu@intel.com>
References: <1444872998-2548-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="G4iJoqBmSsgzjUCe"
Cc: kbuild-all@01.org, Vinod Koul <vinod.koul@intel.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
	Addy Ke <addy.ke@rock-chips.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	alsa-devel@alsa-project.org, Boojin Kim <boojin.kim@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Doug Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
	Olof Johansson <olof@lixom.net>,
	linux-rockchip@lists.infradead.org, linux-spi@vger.kernel.org,
	Sonny Rao <sonnyrao@chromium.org>,
	linux-arm-kernel@lists.infradead.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1444872998-2548-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Shawn,

[auto build test WARNING on rockchip/for-next -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Shawn-Lin/Fix-broken-DMAFLUSHP-on-Rockchips-platform/20151015-094613
reproduce: make htmldocs

All warnings (new ones prefixed by >>):

>> sound/soc/soc-generic-dmaengine-pcm.c:475: warning: No description found for parameter 'caps'

vim +/caps +475 sound/soc/soc-generic-dmaengine-pcm.c

   459			return;
   460	
   461		pcm = soc_platform_to_pcm(platform);
   462	
   463		snd_soc_remove_platform(platform);
   464		dmaengine_pcm_release_chan(pcm);
   465		kfree(pcm);
   466	}
   467	EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_unregister);
   468	
   469	
   470	/**
   471	 * snd_dmaengine_pcm_get_caps - Get slave dma caps based PCM device
   472	 * @dev: Parent device the PCM was register with
   473	 */
   474	int snd_dmaengine_pcm_get_caps(struct device *dev, struct dma_slave_caps *caps)
 > 475	{
   476		struct snd_soc_platform *platform;
   477		struct dmaengine_pcm *pcm;
   478		int ret = -ENODEV;
   479	
   480		platform = snd_soc_lookup_platform(dev);
   481		if (!platform)
   482			return ret;
   483	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--G4iJoqBmSsgzjUCe
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
cmGrhOAXN9f/kEZVAAA=

--G4iJoqBmSsgzjUCe--
