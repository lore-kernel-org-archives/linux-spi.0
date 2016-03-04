From: Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 6/9] spi: imx: remove unnecessary bit clearing in
 mx51_ecspi_config
Date: Fri, 4 Mar 2016 14:06:57 +0200
Message-ID: <56D97A61.2070602@mentor.com>
References: <1456302033-25638-1-git-send-email-s.hauer@pengutronix.de>
 <1456302033-25638-7-git-send-email-s.hauer@pengutronix.de>
 <56D968DF.7000007@mentor.com> <20160304114737.GE21869@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Anton Bondarenko <anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160304114737.GE21869-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 04.03.2016 13:47, Sascha Hauer wrote:
> On Fri, Mar 04, 2016 at 12:52:15PM +0200, Vladimir Zapolskiy wrote:
>> Hi Sascha,
>>
>> On 24.02.2016 10:20, Sascha Hauer wrote:
>>> This reverts patch 1476253cef (spi: imx: fix ecspi mode setup)
>>> The patch tried to fix something by clearing bits in the cfg variable,
>>> but cfg is initialized to zero on function entry. There are no bits to
>>> clear.
>>>
>>> Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
>>
>> I believe here the expected fix should be
>>
>> ----8<----
>>
>> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
>> index 6a4ff27..9c9bae0 100644
>> --- a/drivers/spi/spi-imx.c
>> +++ b/drivers/spi/spi-imx.c
>> @@ -316,9 +316,10 @@ static void __maybe_unused mx51_ecspi_trigger(struct
>> spi_imx_data *spi_imx)
>>  static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
>>  		struct spi_imx_config *config)
>>  {
>> -	u32 ctrl = MX51_ECSPI_CTRL_ENABLE, cfg = 0, dma = 0;
>> +	u32 ctrl = MX51_ECSPI_CTRL_ENABLE, dma = 0;
>>  	u32 tx_wml_cfg, rx_wml_cfg, rxt_wml_cfg;
>>  	u32 clk = config->speed_hz, delay, reg;
>> +	u32 cfg = readl(spi_imx->base + MX51_ECSPI_CONFIG);
>>
> 
> With this change applied we would indeed have to clear and not only set the bits,
> but why would we do this?

Locally we have quite a similar to 1476253cef change (well, correct version
of it) authored by Knut Wohlrab, here is his comment from a discussion:

Please notice that iMX6 ECSPI controller support 4 channels/chip selects at
one SPI bus. The original iMX driver implementation(*) did not care about
the SPI_CPHA, SPI_CPOL and SPI_CS_HIGH configuration of the not selected
channels and set this to "0". Depending on the configuration of this
channels this could cause unwanted edges at the clock line when using this
channels the next time. To prevent this, we introduce the read of the
actual configuration/register content and set only the necessary changes.

(*) here it means the version prior to 1476253cef ("spi: imx: fix ecspi mode
setup)

--
With best wishes,
Vladimir
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
