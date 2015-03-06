From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Subject: Re: [PATCH v4] spi: qup: Add DMA capabilities
Date: Fri, 06 Mar 2015 16:38:22 +0200
Message-ID: <1425652702.2440.3.camel@mm-sol.com>
References: <1425463325-25805-1-git-send-email-stanimir.varbanov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Kumar Gala <galak@codeaurora.org>,
	Andy Gross <agross@codeaurora.org>,
	Sagar Dharia <sdharia@codeaurora.org>,
	Daniel Sneddon <dsneddon@codeaurora.org>
To: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1425463325-25805-1-git-send-email-stanimir.varbanov@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


On Wed, 2015-03-04 at 12:02 +0200, Stanimir Varbanov wrote:
> From: Andy Gross <agross@codeaurora.org>
> 
> This patch adds DMA capabilities to the spi-qup driver.  If DMA channels are
> present, the QUP will use DMA instead of block mode for transfers to/from SPI
> peripherals for transactions larger than the length of a block.
> 
> Signed-off-by: Andy Gross <agross@codeaurora.org>
> Signed-off-by: Stanimir Varbanov varbanov@linaro.org>

Reviewed-by: Ivan T. Ivanov <iivanov@mm-sol.com>

Tested on top of Archit's DMA patch[1].

Thanks,
Ivan

[1] https://lkml.org/lkml/2015/1/22/52
