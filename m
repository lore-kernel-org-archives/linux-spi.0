From: Radu Nicolae Pirea <radu.pirea@microchip.com>
Subject: Re: [RFC PATCH 2/2] spi: atmel: Fix DMA transfers data corruption
Date: Thu, 16 Nov 2017 12:26:39 +0200
Message-ID: <f60fc5b0-990a-9439-01e9-96a6547007e9@microchip.com>
References: <1510763732-10151-1-git-send-email-radu.pirea@microchip.com>
 <1510763732-10151-3-git-send-email-radu.pirea@microchip.com>
 <1510772471.15881.17.camel@impinj.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
To: Trent Piepho <tpiepho@impinj.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1510772471.15881.17.camel@impinj.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 15.11.2017 21:01, Trent Piepho wrote:
> On Wed, 2017-11-15 at 18:35 +0200, Radu Pirea wrote:
>> If the cache model is VIVT, DMA data transfers may not be valid and to
>> ensure the validity of the data cache must be flushed and invalidated.
>>
>> Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
>>   
>> +#ifdef CONFIG_SOC_SAM_V4_V5
>> +	/*
>> +	 * On Atmel SoCs based on ARM9 cores, the data cache follows the VIVT
>> +	 * model, hence the cache aliases issue can occur when buffers are
>> +	 * allocated from DMA-unsafe areas, by vmalloc() for instance, where
>> +	 * cache coherency is not taken into account or at least not handled
>> +	 * completely (cache lines of aliases are not flushed and invalidated).
>> +	 * This is not a theorical issue: it was reproduced when trying to mount
>> +	 * a UBI file-system on a at91sam9g35ek board.
>> +	 */
>> +	flush_kernel_vmap_range((void *)xfer->rx_buf, xfer->len);
>> +#endif
> 
> Does this call need to be inside an ifdef for a specific SOC?  I
> believe that flush_kernel_vmap_range should expand to a no-op if the
> cache is not VIVT or aliasing VIPT.  So it should be safe to always
> call it.
> 
> It also doesn't seem right that the SPI driver needs to know which SoCs
> have what kind of cache.  If there are more socs with more cache
> details, does the spi driver need to expand the list?  If another
> driver does DMA, does it need the list too?

Understood. I will find another way to call the function.

> 
> 
>>   	/* Send both scatterlists */
>>   	rxdesc = dmaengine_prep_slave_sg(rxchan,
>>   					 xfer->rx_sg.sgl, xfer->rx_sg.nents,
> 
> Does this problem also possibly affect all other users of dmaengine on
> these SoCs?  I2C, serial, crpto, etc. I couldn't find any other driver
> that need to make flush_kernel_vmap_range().  Which seems odd, since
> there are many drivers that use DMA and run on ARM9 cores.  E.g., I
> believe spi-mxs runs on ARM9 based iMX.23 and iMX.28 which also have
> VIVT caches.  It doesn't make flush_kernel_vmap_range calls.  Does it
> have this same bug?��칻�&�~�&���+-��ݶ��w��˛���m�b��l�(����ܨ}���Ơz�&j:+v�������zZ+��+zf���h���~����i���z��w���?����&�)ߢf
> 

Other users of dmaengine are not affected by this problem. I know nothing about 
spi-mxs, but i know spi-davinci have the same bug.
