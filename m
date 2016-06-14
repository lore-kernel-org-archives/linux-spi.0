From: Julian Calaby <julian.calaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 10/13] spi: sunxi: merge sun4i and sun6i
 SPI driver
Date: Tue, 14 Jun 2016 21:20:12 +1000
Message-ID: <CAGRGNgVuxy7cF4ZSHKxMWKUQQ_TWEMMsw8xLVT6DMmqtDE_rrw@mail.gmail.com>
References: <cover.1465490774.git.hramrach@gmail.com> <ad0ec30ef6b01f58e1b3b92da06e6cbd5c947354.1465490774.git.hramrach@gmail.com>
 <CAGRGNgVONS+i=57D52VeW8J6SvfmX=iG+3VpxNS8=kJOV+WSLw@mail.gmail.com>
 <CAOMqctQD=o6YBk-QRiqbE9Cj+ZAH1nAM33rW6ZHefV8dU3aucQ@mail.gmail.com>
 <CAGRGNgWPBh03zQrM=OMF24ezJvC-K0TMw2oqPhuNLj-nZ=mZQA@mail.gmail.com>
 <CAOMqctTjGTeaFC3MJe4MoMipdSf2ppOpikBSa8A-ht2v4j86bg@mail.gmail.com>
 <CAGRGNgUYhwr5gCcp1bkN8R3Mx3LByFXH7j9i=ZXmvX5m7OBb4A@mail.gmail.com> <CAOMqctTff3S9dBa0JVnPwRyY6j2kVbB8SCTKham-MH8CX6JwJw@mail.gmail.com>
Reply-To: julian.calaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>,
	Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>,
	Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>,
	Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Sjoerd Simons <sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>,
	Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Alison Wang <b18965-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Timo Sigurdsson <public_timo.s-fWgRPtSzPNU3WX+qO2AYSQ@public.gmane.org>, Jonathan Liu <net147-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Gerhard Bertelsmann <info-La43T0Mi4bH5xCKuJOYmCvaTkwRoYoCU@public.gmane.org>, Priit Laes <plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org>,
	devicet
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-sunxi+bncBDQIP76OUQLBBAOR765AKGQEVGAYIVI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <CAOMqctTff3S9dBa0JVnPwRyY6j2kVbB8SCTKham-MH8CX6JwJw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

Hi Michal,

On Tue, Jun 14, 2016 at 4:35 PM, Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hello,
>
> On 14 June 2016 at 07:45, Julian Calaby <julian.calaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> Hi Michal,
>>
>> On Tue, Jun 14, 2016 at 3:28 PM, Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>> On 14 June 2016 at 06:47, Julian Calaby <julian.calaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>>> Hi Michal,
>>>>
>>>> On Tue, Jun 14, 2016 at 2:34 PM, Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>>>> Hello,
>>>>>
>>>>> On 14 June 2016 at 01:43, Julian Calaby <julian.calaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>>>>> Hi Michal,
>>>>>>
>>>>>> On Tue, Jun 14, 2016 at 3:46 AM, Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>>>>>> The drivers are very similar and share multiple flaws which needed
>>>>>>> separate fixes for both drivers.
>>>>>>>
>>>>>>> Signed-off-by: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>>>>>> ---
>>>>>>>  drivers/spi/Kconfig     |   8 +-
>>>>>>>  drivers/spi/Makefile    |   1 -
>>>>>>>  drivers/spi/spi-sun4i.c | 156 +++++++++++--
>>>>>>>  drivers/spi/spi-sun6i.c | 598 ------------------------------------------------
>>>>>>>  4 files changed, 143 insertions(+), 620 deletions(-)
>>>>>>>  delete mode 100644 drivers/spi/spi-sun6i.c
>>>>>>>
>>>>>>> diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
>>>>>>> index 0b8e6c6..c76f8e4 100644
>>>>>>> --- a/drivers/spi/spi-sun4i.c
>>>>>>> +++ b/drivers/spi/spi-sun4i.c
>>>>>>> @@ -279,9 +321,14 @@ static int sunxi_spi_transfer_one(struct spi_master *master,
>>>>>>>         reg = sunxi_spi_read(sspi, SUNXI_TFR_CTL_REG);
>>>>>>>
>>>>>>>         /* Reset FIFOs */
>>>>>>> -       sunxi_spi_write(sspi, SUNXI_TFR_CTL_REG,
>>>>>>> -                       reg | sspi_bits(sspi, SUNXI_CTL_RF_RST) |
>>>>>>> -                       sspi_bits(sspi, SUNXI_CTL_TF_RST));
>>>>>>> +       if (sspi->type == SPI_SUN4I)
>>>>>>> +               sunxi_spi_write(sspi, SUNXI_TFR_CTL_REG,
>>>>>>> +                               reg | sspi_bits(sspi, SUNXI_CTL_RF_RST) |
>>>>>>> +                               sspi_bits(sspi, SUNXI_CTL_TF_RST));
>>>>>>> +       else
>>>>>>> +               sunxi_spi_write(sspi, SUNXI_FIFO_CTL_REG,
>>>>>>> +                               sspi_bits(sspi, SUNXI_CTL_RF_RST) |
>>>>>>> +                               sspi_bits(sspi, SUNXI_CTL_TF_RST));
>>>>>>
>>>>>> If we're already doing different stuff for each generation of the IP,
>>>>>> why not just use the register offsets and bit definitions directly?
>>>>>
>>>>> Because having (*sspi->regmap)[SUNXI_FIFO_CTL_REG] all over the place
>>>>> makes my eyes bleed and you cannot use the check that you are
>>>>> accessing a register that actually exists.
>>>>
>>>> I mean removing SUNXI_CTL_RF_RST and SUNXI_CTL_TF_RST from all of the
>>>> indirection you added and using them directly, i.e.
>>>>
>>>> #define SUN4I_TFR_CTL_RF_RST BIT(x)
>>>> #define SUN4I_TFR_CTL_TF_RST BIT(x)
>>>> #define SUN6I_FIFO_CTL_RF_RST BIT(x)
>>>> #define SUN6I_FIFO_CTL_TF_RST BIT(x)
>>>>
>>>> then
>>>>
>>>> if (sspi->type == SPI_SUN4I)
>>>>     sunxi_spi_write(sspi, SUNXI_TFR_CTL_REG, reg |
>>>> SUN4I_TFR_CTL_RF_RST | SUN4I_TFR_CTL_TF_RST);
>>>> else
>>>>     sunxi_spi_write(sspi, SUNXI_FIFO_CTL_REG, reg |
>>>> SUN6I_FIFO_CTL_RF_RST | SUN6I_FIFO_CTL_TF_RST);
>>>>
>>>> I.e. the bits that need setting are in different registers, so you
>>>> have to have an if statement and separate calls. Therefore there's no
>>>> real benefit from the indirection you've introduced here, unless
>>>> you're expecting the SUN8I variant to use different bits in one of
>>>> those two registers.
>>>>
>>>
>>> That looks nice for this particular case.
>>
>> There was another case I pointed out in this driver that could
>> potentially benefit from this.
>>
>>> Still you will have to remember that these bits are specified directly
>>> while other bits on the register are mapped which is not so nice.
>>
>> True. I'm not sure which path is best in this case. To my eye, your
>> indirection scheme seems like the "heavy" solution, however I have no
>> idea what form a "lighter" solution would take.
>>
>> Other drivers I've seen which have tackled similar problems have used
>> a large struct to hold all the variant-specific stuff, whether that's
>> function pointers, register offsets, constants, etc. (so this code
>> could theoretically be re-written as sunxi_spi_write(sspi,
>> sspi->fifo_reg, reg | sspi->fifo_reset_arg)
>
> This won't do. There is fifo_reg and tfr_reg on both IPs but some bits
> from one migrated to the other.
>
>> or sspi->reset_fifo())
>
> This would work but would require more thorough rewrite and heavier
> adaptation layer.
>
> As it is where different register is used in different IP revision it
> is specified explicitly in the code while register names to numbers
> are mapped in read() and write(). Value bits are mapped by explicitly
> calling a function on the name.
>
> This gives nice 1:1 mapping to the old code and allows checking that
> both the register and the bit value in question exist on the IP.

And your method is almost beautiful from that perspective, however I
still feel that it's too "heavy". That said, neither of my suggestions
are much better. I provided them in the hope that they might be
illuminating.

> Matching the value to register relies on the driver code, however.

Of course.

I'm not sure what the state-of-the-art for dealing with variants of
devices where the manufacturer keeps scrambling the registers is,
however I feel we can do better, though I'm not sure how.

Thanks,

-- 
Julian Calaby

Email: julian.calaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Profile: http://www.google.com/profiles/julian.calaby/
