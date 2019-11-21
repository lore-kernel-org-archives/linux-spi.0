From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] spi: pic32: Retire dma_request_slave_channel_compat()
Date: Thu, 21 Nov 2019 10:40:44 +0200
Message-ID: <c14dd693-74e6-7e48-9697-849f44b8e0d9@ti.com>
References: <20191121080954.14915-1-peter.ujfalusi@ti.com>
 <CAMuHMdVWCM_LQ5Fx+3NMhyd21LSpYQWCX2pmtkU2tHvtzDzUzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie@kernel.org>, Vinod <vkoul@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdVWCM_LQ5Fx+3NMhyd21LSpYQWCX2pmtkU2tHvtzDzUzw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Geert,

On 21/11/2019 10.30, Geert Uytterhoeven wrote:
> Hi Peter,
> 
> On Thu, Nov 21, 2019 at 9:11 AM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
>> There is no reason to use the dma_request_slave_channel_compat() as no
>> filter function and parameter is provided.
>>
>> Switch the driver to use dma_request_chan() instead.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> 
>> --- a/drivers/spi/spi-pic32.c
>> +++ b/drivers/spi/spi-pic32.c
>> @@ -609,22 +609,18 @@ static void pic32_spi_cleanup(struct spi_device *spi)
>>  static void pic32_spi_dma_prep(struct pic32_spi *pic32s, struct device *dev)
>>  {
>>         struct spi_master *master = pic32s->master;
>> -       dma_cap_mask_t mask;
>>
>> -       dma_cap_zero(mask);
>> -       dma_cap_set(DMA_SLAVE, mask);
>> -
>> -       master->dma_rx = dma_request_slave_channel_compat(mask, NULL, NULL,
>> -                                                         dev, "spi-rx");
>> -       if (!master->dma_rx) {
>> +       master->dma_rx = dma_request_chan(dev, "spi-rx");
> 
> Why not dma_request_slave_channel()?

The longer term plan is to retire dma_request_slave_channel() as well.
With dma_request_chan() deferred probing against DMA drivers is possible
and it also supports legacy boot with dma_slave_map.

At the end we should be left with only dma_request_chan() for slave
channels in the kernel.

> That way you...
> 
>> +       if (IS_ERR(master->dma_rx)) {
> 
> ... don't have to change the NULL check here, and...
> 
>>                 dev_warn(dev, "RX channel not found.\n");
>> +               master->dma_rx = NULL;
> 
> ...  don't have to override by NULL here.

It is a small sacrifice, true, but if anyone cares the driver can
support deferred probing with dma_request_chan().

> 
> (same for TX below).
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
