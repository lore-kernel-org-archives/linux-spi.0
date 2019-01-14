From: Jon Hunter <jonathanh@nvidia.com>
Subject: Regression: spi: core: avoid waking pump thread from spi_sync instead
 run teardown delayed
Date: Mon, 14 Jan 2019 15:35:51 +0000
Message-ID: <f86eaebb-0359-13be-f4a2-4f2b8832252e@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
To: <kernel@martin.sperl.org>, Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Martin, Mark,

I have noticed that system suspend has started failing consistently on a
couple Tegra boards over the last few days with the linux-next branch.
The following error is seen on on entering suspend ...

[   58.222033] spi_master spi1: could not stop message queue
[   58.222038] spi_master spi1: queue stop failed
[   58.222048] dpm_run_callback(): platform_pm_suspend+0x0/0x54 returns -16
[   58.222052] PM: Device 7000da00.spi failed to suspend: error -16
[   58.222057] PM: Some devices failed to suspend, or early wake event detected

Bisecting today's -next points to commit 412e60373245 ("spi: core: avoid
waking pump thread from spi_sync instead run teardown delayed") and
reverting this on top of -next fixes the problem. I have not had chance
to dig any further but wanted to report this issue to see if you have
any thoughts.

Cheers
Jon

-- 
nvpublic
