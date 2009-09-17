From: Dragos Carp <dragos.carp-+ybMorV4k0dBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] mpc52xx_psc_spi: enlarge clock range
Date: Thu, 17 Sep 2009 16:04:42 +0200
Message-ID: <4AB241FA.9090604@toptica.com>
References: <4AB0C706.5020601@toptica.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20090916204853.GA21627-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
References: <20090916204853.GA21627-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Disposition: inline
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

I wasn't aware that MPC5200 differ from MPC5200B in this regard. I also
couldn't find any MPC5200 user manual on Freescale's webpage.
Is there a #define that I can use to distinguish between the two
processor variants? Querying the PVR register is not a nice solution
because the chip-select activate function is called in some scenarios
quite often.

Regards,
Dragos


On 09/16/2009 10:48 PM, Wolfram Sang wrote:
> Hi,
>
> adding powerpc-list and Grant to cc.
>
> On Wed, Sep 16, 2009 at 01:07:50PM +0200, Dragos Carp wrote:
>   
>> allow spi clock values bellow 78kbps down to ca. 300bps
>>     
> Looks like your patch converts the driver from mpc5200 to mpc5200b? If this is
> really all which is needed, it should support both versions, I think.
>
> Regards,
>
>    Wolfram
>
>   
>> Signed-off-by: Dragos Carp <dragos.carp-+ybMorV4k0dBDgjK7y7TUQ@public.gmane.org>
>> ---
>>  mpc52xx_psc_spi.c |   26 +++++++++++++-------------
>>  1 file changed, 13 insertions(+), 13 deletions(-)
>>
>>     
>   
>> diff --git a/drivers/spi/mpc52xx_psc_spi.c b/drivers/spi/mpc52xx_psc_spi.c
>> index 1b74d5c..b15882a 100644
>> --- a/drivers/spi/mpc52xx_psc_spi.c
>> +++ b/drivers/spi/mpc52xx_psc_spi.c
>> @@ -78,7 +78,8 @@ static void mpc52xx_psc_spi_activate_cs(struct spi_device *spi)
>>  	struct mpc52xx_psc_spi *mps = spi_master_get_devdata(spi->master);
>>  	struct mpc52xx_psc __iomem *psc = mps->psc;
>>  	u32 sicr;
>> -	u16 ccr;
>> +	u32 ccr;
>> +	u32 bitclkdiv;
>>  
>>  	sicr = in_be32(&psc->sicr);
>>  
>> @@ -98,17 +99,16 @@ static void mpc52xx_psc_spi_activate_cs(struct spi_device *spi)
>>  		sicr &= ~0x10000000;
>>  	out_be32(&psc->sicr, sicr);
>>  
>> -	/* Set clock frequency and bits per word
>> -	 * Because psc->ccr is defined as 16bit register instead of 32bit
>> -	 * just set the lower byte of BitClkDiv
>> -	 */
>> -	ccr = in_be16((u16 __iomem *)&psc->ccr);
>> -	ccr &= 0xFF00;
>> -	if (cs->speed_hz)
>> -		ccr |= (MCLK / cs->speed_hz - 1) & 0xFF;
>> -	else /* by default SPI Clk 1MHz */
>> -		ccr |= (MCLK / 1000000 - 1) & 0xFF;
>> -	out_be16((u16 __iomem *)&psc->ccr, ccr);
>> +	/* Set clock frequency */
>> +	bitclkdiv = MCLK / (cs->speed_hz ? cs->speed_hz : 1000000) - 1;
>> +	bitclkdiv &= 0xFFFF;
>> +	bitclkdiv |= (bitclkdiv & 0xFF) << 16;	/* byte swapped */
>> +	bitclkdiv &= 0x00FFFF00;
>> +	ccr = in_be32(&psc->ccr);
>> +	ccr &= 0xFF0000FF;
>> +	ccr |= bitclkdiv;
>> +	out_be32(&psc->ccr, ccr);
>> +	
>>  	mps->bits_per_word = cs->bits_per_word;
>>  
>>  	if (mps->cs_control)
>> @@ -333,7 +333,7 @@ static int mpc52xx_psc_spi_port_config(int psc_id, struct mpc52xx_psc_spi *mps)
>>  	/* Configure 8bit codec mode as a SPI master and use EOF flags */
>>  	/* SICR_SIM_CODEC8|SICR_GENCLK|SICR_SPI|SICR_MSTR|SICR_USEEOF */
>>  	out_be32(&psc->sicr, 0x0180C800);
>> -	out_be16((u16 __iomem *)&psc->ccr, 0x070F); /* default SPI Clk 1MHz */
>> +	out_be32(&psc->ccr, 0x07130000); /* default SPI Clk 1MHz */
>>  
>>  	/* Set 2ms DTL delay */
>>  	out_8(&psc->ctur, 0x00);
>>     
>   



------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
