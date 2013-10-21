From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH] spi/s3c64xx: Fix doubled clock disable on suspend
Date: Mon, 21 Oct 2013 13:41:59 +0200
Message-ID: <1382355719.8172.0.camel@AMDC1943>
References: <1382348117-6666-1-git-send-email-k.kozlowski@samsung.com>
 <5264F709.2000409@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Ben Dooks <ben-linux@fluff.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kyungmin Park <kyungmin.park@samsung.com>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <5264F709.2000409@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, 2013-10-21 at 11:42 +0200, Sylwester Nawrocki wrote:
> pm_runtime_{get,put}* must not be called from drivers's system suspend/resume
> callbacks. Please use pm_runtime_suspended() to check device runtime PM status
> in s3c64xx_spi_{suspend,resume} callbacks and handle the clocks appropriately.

Thanks for review, I will send fixed patch.

Best regards,
Krzysztof
