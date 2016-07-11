From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH v2 6/7] spi: s3c64xx: restore removed comments
Date: Mon, 11 Jul 2016 12:33:42 +0200
Message-ID: <57837606.8050906@samsung.com>
References: <1467989201-14661-1-git-send-email-andi.shyti@samsung.com>
 <1467989201-14661-7-git-send-email-andi.shyti@samsung.com>
 <146799464881.73491.7507792367941552864@resonance>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Kukjin Kim <kgene@kernel.org>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Mark Brown <broonie@kernel.org>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Stephen Boyd <sboyd@codeaurora.org>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org,
	Andi Shyti <andi@etezian.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Andi Shyti <andi.shyti@samsung.com>
Return-path: <linux-clk-owner@vger.kernel.org>
In-reply-to: <146799464881.73491.7507792367941552864@resonance>
Sender: linux-clk-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 07/08/2016 06:17 PM, Michael Turquette wrote:
> Quoting Andi Shyti (2016-07-08 07:46:40)

>> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
>> index 6da663f..32b66f0 100644
>> --- a/drivers/spi/spi-s3c64xx.c
>> +++ b/drivers/spi/spi-s3c64xx.c
>> @@ -639,6 +639,7 @@ static void s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
>>         writel(val, regs + S3C64XX_SPI_MODE_CFG);
>>  
>>         if (sdd->port_conf->clk_from_cmu) {
>> +               /* There is half-multiplier before the SPI */
>>                 clk_set_rate(sdd->src_clk, sdd->cur_speed * 2);
> 
> Just a small comment, but if the fixed-factor divide-by-two clock was
> modeled in Linux, then this driver could call clk_set_rate on that clock
> with the "correct" rate.
> 
> I guess that this driver would be the provider of that clock?

Good point, however I'm not sure if it is worth to model this divider
with a clk object.  It is an internal divider and the clock it provides
is only used internally within the SPI controller.  Thus the spi-s3c64xx
driver would be provider on the only consumer of this clock.

Additionally, the "There is half-multiplier before the SPI" comment
seems to be obfuscating how the hardware really looks like to me.
It talks about multiplier (which reminds me of PLLs with a divider
in the feedback loop) while there is a simple divider which should
be considered as an integral part of the controller IP block.

While we are at it, I'd propose to change this comment to something
like:

/* The SCLK_SPI clock is divided internally by 2 */
