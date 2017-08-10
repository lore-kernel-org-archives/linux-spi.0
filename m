From: Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCHv3 1/2] spi: imx: fix use of native chip-selects with
 devicetree
Date: Thu, 10 Aug 2017 12:35:36 +0300
Message-ID: <b3e80e47-d1e5-41f9-a744-dc01e51d779e@mentor.com>
References: <1499746932-14850-1-git-send-email-gerg@linux-m68k.org>
 <1499746932-14850-2-git-send-email-gerg@linux-m68k.org>
 <CAOMZO5Dq8mAULR+L6HJUMc6f=-d9QPZmn92+jzwKLuGYDA_AaA@mail.gmail.com>
 <20170720063449.qvi3s7faapcncoqm@pengutronix.de>
 <2892f819-f1a2-b68d-be01-e8ac7f4b4222@linux-m68k.org>
 <20170724062147.o7tccwskxfuls3ej@pengutronix.de>
 <239ae959-ce96-711b-dbfb-4e892b7eab3b@linux-m68k.org>
 <8ccba0c6-cd35-db2e-6a3f-32b79609271d@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Oleksij Rempel <ore-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        Greg Ungerer <gerg-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <8ccba0c6-cd35-db2e-6a3f-32b79609271d-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Oleksij,

On 08/10/2017 09:09 AM, Oleksij Rempel wrote:
> Hi Greg,
> 
> On 09.08.2017 15:00, Greg Ungerer wrote:
>> Hi Qleksij,
>>
>> On 24/07/17 16:21, Oleksij Rempel wrote:
>>> On Thu, Jul 20, 2017 at 11:00:49PM +1000, Greg Ungerer wrote:
>>>> Hi Oleksij,
>>>>
>>>> On 20/07/17 16:34, Oleksij Rempel wrote:
>>>>> Hi Greg,
>>>>>
>>>>> On Tue, Jul 18, 2017 at 09:53:58PM -0300, Fabio Estevam wrote:
>>>>>> Adding Pengutronix folks on Cc.
>>>>>>
>>>>>> On Tue, Jul 11, 2017 at 1:22 AM, Greg Ungerer <gerg-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
>>>>>> wrote:
>>>>>>> The commonly used mechanism of specifying the hardware or native
>>>>>>> chip-select on an SPI device in devicetree (that is "cs-gpios = <0>")
>>>>>>> does not result in the native chip-select being configured for use.
>>>>>>> So external SPI devices that require use of the native chip-select
>>>>>>> will not work.
>>>>>>>
>>>>>>> You can successfully specify native chip-selects if using a platform
>>>>>>> setup by specifying the cs-gpio as negative offset by 32. And that
>>>>>>> works correctly. You cannot use the same method in devicetree.
>>>>>>>
>>>>>>> The logic in the spi-imx.c driver during probe uses core spi function
>>>>>>> of_spi_register_master() in spi.c to parse the "cs-gpios"
>>>>>>> devicetree tag.
>>>>>>> For valid GPIO values that will be recorded for use, all other
>>>>>>> entries in
>>>>>>> the cs_gpios list will be set to -ENOENT. So entries like "<0>"
>>>>>>> will be
>>>>>>> set to -ENOENT in the cs_gpios list.
>>>>>>>
>>>>>>> When the SPI device registers are setup the code will use the GPIO
>>>>>>> listed in the cs_gpios list for the desired chip-select. If the
>>>>>>> cs_gpio
>>>>>>> is less then 0 then it is intended to be for a native chip-select,
>>>>>>> and
>>>>>>> its cs_gpio value is added to 32 to get the chipselect number to use.
>>>>>>> Problem is that with devicetree this can only ever be -ENOENT (which
>>>>>>> is -2), and that alone results in an invalid chip-select number.
>>>>>>> But also
>>>>>>> doesn't allow selection of the native chip-select at all.
>>>>>>>
>>>>>>> To fix, if the cs_gpio specified for this spi device is not a
>>>>>>> valid GPIO then use the "chip_select" (that is the native chip-select
>>>>>>> number) for hardware setup.
>>>>>>>
>>>>>>> Signed-off-by: Greg Ungerer <gerg-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
>>>>>>> ---
>>>>>>>    drivers/spi/spi-imx.c | 8 ++++----
>>>>>>>    1 file changed, 4 insertions(+), 4 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
>>>>>>> index b402530..f4fe66c 100644
>>>>>>> --- a/drivers/spi/spi-imx.c
>>>>>>> +++ b/drivers/spi/spi-imx.c
>>>>>>> @@ -524,8 +524,8 @@ static int mx31_config(struct spi_device *spi,
>>>>>>> struct spi_imx_config *config)
>>>>>>>                   reg |= MX31_CSPICTRL_POL;
>>>>>>>           if (spi->mode & SPI_CS_HIGH)
>>>>>>>                   reg |= MX31_CSPICTRL_SSPOL;
>>>>>>> -       if (spi->cs_gpio < 0)
>>>>>>> -               reg |= (spi->cs_gpio + 32) <<
>>>>>>> +       if (!gpio_is_valid(spi->cs_gpio))
>>>>>>> +               reg |= (spi->chip_select) <<
>>>>>>>                           (is_imx35_cspi(spi_imx) ?
>>>>>>> MX35_CSPICTRL_CS_SHIFT :
>>>>>>>
>>>>>>> MX31_CSPICTRL_CS_SHIFT);
>>>>>>>
>>>>>>> @@ -616,8 +616,8 @@ static int mx21_config(struct spi_device *spi,
>>>>>>> struct spi_imx_config *config)
>>>>>>>                   reg |= MX21_CSPICTRL_POL;
>>>>>>>           if (spi->mode & SPI_CS_HIGH)
>>>>>>>                   reg |= MX21_CSPICTRL_SSPOL;
>>>>>>> -       if (spi->cs_gpio < 0)
>>>>>>> -               reg |= (spi->cs_gpio + 32) << MX21_CSPICTRL_CS_SHIFT;
>>>>>>> +       if (!gpio_is_valid(spi->cs_gpio))
>>>>>>> +               reg |= spi->chip_select << MX21_CSPICTRL_CS_SHIFT;
>>>>>>>
>>>>>>>           writel(reg, spi_imx->base + MXC_CSPICTRL);
>>>>>>>
>>>>>
>>>>> hm... do I see this correctly, all native chip_selects should
>>>>> be registered before gpio based CS?
>>>>
>>>> I don't follow. The "<0>" must be in the position in the list where
>>>> you want to use the native chip select. You can't arbitrarily change
>>>> the order.
>>>>
>>>>
>>>>> For example like this?
>>>>> cs-gpios = <0>, <&gpio1 1 0>, <&gpio1 2 0>;
>>>>>
>>>>> Looks like we don't have any sanity checks for this kind of
>>>>> configuration:
>>>>> cs-gpios = <&gpio1 1 0>, <&gpio1 2 0>, <0>;
>>>>
>>>> The chip_select is sanity checked in spi_add_device().
>>>>
>>>>
>>>>> We may shift some wired numbers here:
>>>>> reg |= spi->chip_select << MX21_CSPICTRL_CS_SHIFT;
>>>>
>>>> I am not sure I see how that can be the case?
>>>
>>> old and new version of iMX have different amount of native CS.
>>> I can't find the code which is actually checking if we use right native
>>> CS-index.
>>> May be i'm blind :)
>>
>> I don't think I entirely understand what you are saying. The code at the
>> top of spi_add_device() [drivers/spi/spi.c] looks like this:
>>
>>         /* Chipselects are numbered 0..max; validate. */
>>         if (spi->chip_select >= ctlr->num_chipselect) {
>>                 dev_err(dev, "cs%d >= max %d\n", spi->chip_select,
>>                         ctlr->num_chipselect);
>>                 return -EINVAL;
>>         }
>>
>> So it will range check the spi device (spi->chip_select) to be within
>> the range valid for this SPI controller. That is the very same
>> spi->chip_select that is used in spi-imx.c to set the register bits
>> when using a native chip select.
> 
> Correct. This is how ctlr->num_chipselect initialized:
> 
>          nb = of_gpio_named_count(np, "cs-gpios");
>          ctlr->num_chipselect = max_t(int, nb, ctlr->num_chipselect);
> 
> it will take the count of cs-gpios.
> 
> The i.MX233 has 3 native CSs (SSn) and i.MX6D/Q has 4 CSs - controlled 
> by 2 bits. Lets assume in both cases we wish to use 5CSs, some of them 
> are GPIOs.
> 
> We will use same line for devicetree on i.MX233 and i.MX6D/Q:
> cs-gpios = <&gpio1 0 0>, <&gpio1 1 0>, <&gpio1 2 0>, <0>, <&gpio1 4 0>;
> 
> If i see it correctly, spi.c and imx-spi.c will just take it. But in 
> case of i.MX6 it should work and on i.MX233 it should silently fail.

Errors in DTB (or platform data) may confuse a driver and lead to runtime
misbehaviour. You describe an error in a board DTB, which is definitely
better to handle in the SPI driver, but I don't think it is strictly
mandatory to do it, because DTB errors are supposed to be fixed in DTB.

May be one day a formal check of DTBs against Documentation/devicetree
descriptions will be added and such DTB errors could be captured on DTB
compilation stage.

> And in this case:
> cs-gpios = <&gpio1 0 0>, <&gpio1 1 0>, <&gpio1 2 0>, <&gpio1 3 0>, <0>;
> 
> we should produce a 3 bit value b100 which will be shifted left and 
> "or"-ed with other ctrl bits.

Same is here.

--
With best wishes,
Vladimir
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
