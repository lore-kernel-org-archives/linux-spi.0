From: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2] spi: omap2-mcspi: disable other channels CHCONF_FORCE
 in prepare_message
Date: Fri, 9 Oct 2015 17:29:26 +0200
Message-ID: <5617DD56.1070608@baylibre.com>
References: <5617C57D.9080902@baylibre.com> <20151009152622.GA1114@deathstar>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fionn Cleary <clearyf-/Zw1syy4LHg@public.gmane.org>,
	Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151009152622.GA1114@deathstar>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 10/09/2015 05:26 PM, Michael Welling wrote:
> On Fri, Oct 09, 2015 at 03:47:41PM +0200, Neil Armstrong wrote:
>> Since the "Switch driver to use transfer_one" change, the cs_change
>> behavior has changed and a channel chip select can still be
>> asserted when changing channel from a previous last transfer in a
>> message having the cs_change attribute.
>>
>> Since there is no sense having multiple chip select being asserted at the
>> same time, disable all the remaining forced chip selects in a the
>> prepare_message called right before a spi_transfer_one_message call.
>> It ignores the current channel configuration in order to keep the
>> possibility to leave the chip select asserted between messages.
>>
>> It fixes this bug on a DM8168 SoC ES2.1 Soc and an OMAP4 ES2.1 SoC.
>> It was hanging all the other channels transfers when a CHCONF_FORCE
>> is present on the wrong channel.
>>
>> Fixes: b28cb9414db9 ("spi: omap2-mcspi: Switch driver to use transfer_one")
>> Signed-off-by: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
>> ---
>>  drivers/spi/spi-omap2-mcspi.c | 28 ++++++++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>
>> Test code can be found on :
>> http://pastebin.com/0SrqbGP7
>>
>> Before patch :
>> # ./test_spi
>> cs_change_command() start
>> spidev1.3 ioctl success
>> no_dma_command() start
>> [   59.790069] spidev spi1.1: TXS timed out
>> spidev1.1 ioctl success
>> cs_change_command() start
>> [   60.798736] spidev spi1.3: RXS timed out
>> spidev1.3 ioctl success
>> no_dma_command() start
>> [   61.802032] spidev spi1.1: TXS timed out
>> spidev1.1 ioctl success
>> cs_change_command() start
>> [   62.807525] spidev spi1.3: RXS timed out
>> spidev1.3 ioctl success
>> no_dma_command() start
>> [   63.812042] spidev spi1.1: TXS timed out
>> spidev1.1 ioctl success
>> ...
>>
>> After Patch :
>> # ./test_spi
>> cs_change_command() start
>> spidev1.3 ioctl success
>> no_dma_command() start
>> spidev1.1 ioctl success
>> cs_change_command() start
>> spidev1.3 ioctl success
>> no_dma_command() start
>> spidev1.1 ioctl success
>> cs_change_command() start
>> spidev1.3 ioctl success
>> ...
>>
>> v2: uses msg to leave asserted chip select for the current channel
>>
>> This is a patch RFC following the bug report :
>> 'McSPI hangs with cs_change after "Switch driver to use transfer_one" change'
>> http://permalink.gmane.org/gmane.linux.kernel/2056841
>>
>> diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
>> index 3d09e0b..1f8903d 100644
>> --- a/drivers/spi/spi-omap2-mcspi.c
>> +++ b/drivers/spi/spi-omap2-mcspi.c
>> @@ -1217,6 +1217,33 @@ out:
>>  	return status;
>>  }
>>
>> +static int omap2_mcspi_prepare_message(struct spi_master *master,
>> +				       struct spi_message *msg)
>> +{
>> +	struct omap2_mcspi	*mcspi = spi_master_get_devdata(master);
>> +	struct omap2_mcspi_regs	*ctx = &mcspi->ctx;
>> +	struct omap2_mcspi_cs	*cs;
>> +
> 
> Do we need the pm_runtime_get_sync code here?
> See previous commit.
> 

I checked and prepare_message is only called after pm_rumtime_get_sync in __spi_pump_messages()

Neil
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
