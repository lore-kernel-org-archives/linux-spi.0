From: Greg Ungerer <gregungerer-ncau/BB9MAPvnOemgxGiVw@public.gmane.org>
Subject: Re: [RFC] spi: imx: fix use of native chip-selects with devicetree
Date: Tue, 14 Mar 2017 18:32:15 +1000
Message-ID: <52a094ac-18e4-c03a-799d-7f56d4a1f969@westnet.com.au>
References: <1489378139-11707-1-git-send-email-gerg@linux-m68k.org>
 <CAMuHMdVmNYq0Wf60P2GbfVpRLDv+c65A+R=Z=gfgr=_VE6BAQA@mail.gmail.com>
 <1d60ce9b-3320-1395-863c-3e7bbecf4273@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1d60ce9b-3320-1395-863c-3e7bbecf4273-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Geert,

On 13/03/17 22:26, Greg Ungerer wrote:
> On 13/03/17 18:29, Geert Uytterhoeven wrote:
>> On Mon, Mar 13, 2017 at 5:08 AM, Greg Ungerer <gerg-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
>> wrote:
[snip]
>>> ---
>>>  drivers/spi/spi-imx.c | 17 +++++++++++------
>>>  1 file changed, 11 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
>>> index 9a7c62f..c6e13f7 100644
>>> --- a/drivers/spi/spi-imx.c
>>> +++ b/drivers/spi/spi-imx.c
>>> @@ -516,10 +516,12 @@ static int mx31_config(struct spi_device *spi,
>>> struct spi_imx_config *config)
>>>                 reg |= MX31_CSPICTRL_POL;
>>>         if (spi->mode & SPI_CS_HIGH)
>>>                 reg |= MX31_CSPICTRL_SSPOL;
>>> -       if (spi->cs_gpio < 0)
>>> -               reg |= (spi->cs_gpio + 32) <<
>>> -                       (is_imx35_cspi(spi_imx) ?
>>> MX35_CSPICTRL_CS_SHIFT :
>>> -
>>> MX31_CSPICTRL_CS_SHIFT);
>>> +       if (spi->cs_gpio < 0) {
>>
>> if (!gpio_is_valid(spi->cs_gpio)) {
>>
>>> +               int cs = (spi->cs_gpio == -ENOENT) ? spi->chip_select :
>>> +                                                    spi->cs_gpio + 32;
>>
>> I don't think the check for -ENOENT is needed, and thus you can always
>> just use spi->chip-select directly.
 >>
>> Same comments for the mx21 code.
>
> I suspect that is the case. I didn't check back through all the
> platform setups that currently rely on this "+ 32" mapping logic.
> I would expect that they should all end up with spi->chip_select
> being correct (and not needing cs_gpio here at all).

It looks as if some platform setups don't map the appropriate
chipselect to entries in the cs-gpios array. For example in
arch/arm/mach-imx/mach-mx31_3ds.c it sets chipselect=1 but the
cs-gpio equivalent entry is actually for native chipselect 2.

There are a few other examples of this too.

Now, these could be fixed to. Harder to test properly though
without access to the effected boards.

Regards
Greg


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
