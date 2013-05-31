From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: convert drivers to use bits_per_word_mask
Date: Fri, 31 May 2013 10:10:47 -0600
Message-ID: <51A8CB87.80201@wwwdotorg.org>
References: <1369190195-14598-1-git-send-email-swarren@wwwdotorg.org>
	<1369190195-14598-2-git-send-email-swarren@wwwdotorg.org>
	<1528437.8btZmmDHhd@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, device-drivers-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org,
	Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1528437.8btZmmDHhd@wuerfel>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 05/31/2013 02:45 AM, Arnd Bergmann wrote:
> Can you check this part again:
> 
> On Tuesday 21 May 2013 20:36:35 Stephen Warren wrote:
>> diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
...
>> @@ -1190,11 +1172,13 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
>>         drv_data->ioaddr = ssp->mmio_base;
>>         drv_data->ssdr_physical = ssp->phys_base + SSDR;
>>         if (pxa25x_ssp_comp(drv_data)) {
>> +               master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 16);
>>                 drv_data->int_cr1 = SSCR1_TIE | SSCR1_RIE;
>>                 drv_data->dma_cr1 = 0;
>>                 drv_data->clear_sr = SSSR_ROR;
>>                 drv_data->mask_sr = SSSR_RFS | SSSR_TFS | SSSR_ROR;
>>         } else {
>> +               master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
>>                 drv_data->int_cr1 = SSCR1_TIE | SSCR1_RIE | SSCR1_TINTE;
>>                 drv_data->dma_cr1 = DEFAULT_DMA_CR1;
>>                 drv_data->clear_sr = SSSR_ROR | SSSR_TINT;
> 
> I get a new build warning
> 
> drivers/spi/spi-pxa2xx.c: In function 'pxa2xx_spi_probe':
> drivers/spi/spi-pxa2xx.c:1152:3: warning: left shift count >= width of type [enabled by default]
>    master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
>    ^

That should be fixed by the patches I sent yesterday.

------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite
It's a free troubleshooting tool designed for production
Get down to code-level detail for bottlenecks, with <2% overhead.
Download for free and get started troubleshooting in minutes.
http://p.sf.net/sfu/appdyn_d2d_ap2
