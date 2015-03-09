From: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Subject: Re: [RFC/PATCHv2 3/3] spi: dw-spi: Pointers select 16b vs. 32b DesignWare
 access
Date: Mon, 9 Mar 2015 14:47:07 -0500
Message-ID: <54FDF8BB.4050202@opensource.altera.com>
References: <1425685594-26595-1-git-send-email-tthayer@opensource.altera.com>	<1425685594-26595-4-git-send-email-tthayer@opensource.altera.com>	<CAHp75VcceG2O+YCw4twBzC_2v9+XQRpfBxMqGXERi3amnj3rdA@mail.gmail.com>	<54FDDFE6.8010109@opensource.altera.com> <CAHp75Vf6dgobzZyJxu8eiqGgC7FRrwLCmyMf5Agk6S3jHDj4bw@mail.gmail.com>
Reply-To: <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	<ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, <dinguyen-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>,
	Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<tthayer.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>,
	<baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>,
	Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAHp75Vf6dgobzZyJxu8eiqGgC7FRrwLCmyMf5Agk6S3jHDj4bw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>



On 03/09/2015 01:54 PM, Andy Shevchenko wrote:
> On Mon, Mar 9, 2015 at 8:01 PM, Thor Thayer
> <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org> wrote:
>>
>>
>> On 03/07/2015 01:52 PM, Andy Shevchenko wrote:
>>>
>>> On Sat, Mar 7, 2015 at 1:46 AM,  <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org> wr=
ote:
>>>>
>>>> From: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
>>>>
>>>> Altera's Arria10 SoC interconnect requires a 32 bit write for APB
>>>> peripherals. The current spi-dw driver uses 16bit accesses in
>>>> some locations. Use function pointers to support 32 bit accesses
>>>> but retain legacy 16 bit access.
>
>>>> --- a/drivers/spi/spi-dw-mmio.c
>>>> +++ b/drivers/spi/spi-dw-mmio.c
>>>> @@ -76,8 +76,13 @@ static int dw_spi_mmio_probe(struct platform_de=
vice
>>>> *pdev)
>>>>
>>>>           num_cs =3D 4;
>>>>
>>>> -       if (pdev->dev.of_node)
>>>> +       if (pdev->dev.of_node) {
>>>>                   of_property_read_u32(pdev->dev.of_node, "num-cs"=
,
>>>> &num_cs);
>>>> +               if (of_property_read_bool(pdev->dev.of_node,
>>>> "32bit_access")) {
>
> "32bit-access"
>

Thanks. I will make the change.

>>>> +                       dws->read_w =3D dw_readw32;
>>>> +                       dws->write_w =3D dw_writew32;
>>>
>>>
>>> Can we use just  readw/writew (w/o underscores) as names for the
>>> accessors?
>>>
>>
>> I tried this initially and got a namespace conflict with the readw &=
 write2
>> macros.
>> macro writew passed 3 arguments, but takes just 2
>> macro readw passed 2 arguments, but takes just 1
>
> Might be I wasn't clear enough. I meant
>
> dws->readw =3D =E2=80=A6
> dws->writew =3D =E2=80=A6
>

Yes, we agree. These are exactly what I was using when I saw the error.

>>>> --- a/drivers/spi/spi-dw.h
>>>> +++ b/drivers/spi/spi-dw.h
>>>> @@ -141,6 +141,8 @@ struct dw_spi {
>>>>    #ifdef CONFIG_DEBUG_FS
>>>>           struct dentry *debugfs;
>>>>    #endif
>>>> +       u16 (*read_w)(struct dw_spi *dws, u32 offset);
>>>> +       void (*write_w)(struct dw_spi *dws, u32 offset, u16 val);
>
> readw
> writew
>
> As I can see there are no such field names in struct dw_spi.
>

Yes. This seems safe but I still see the macro conflict which is strang=
e=20
to me. Like you, I initially used the dws->readw and dws->writew becaus=
e=20
I didn't see any conflicting field names.

Are readw & writew reserved variable names?

>>>>    };
>>>>
>>>>    static inline u32 dw_readl(struct dw_spi *dws, u32 offset)
>>>> @@ -163,6 +165,16 @@ static inline void dw_writew(struct dw_spi *d=
ws, u32
>>>> offset, u16 val)
>>>>           __raw_writew(val, dws->regs + offset);
>>>>    }
>>>>
>>>> +static inline u16 dw_readw32(struct dw_spi *dws, u32 offset)
>>>> +{
>>>> +       return (u16)__raw_readl(dws->regs + offset)
>
> Maybe return dw_readl(dws, offset);
>
>>>> +}
>>>> +
>>>> +static inline void dw_writew32(struct dw_spi *dws, u32 offset, u1=
6 val)
>>>> +{
>>>> +       __raw_writel((u32)val, dws->regs + offset);
>
> dw_writel(dws, offset, val);
>

Yes, I'll make these two changes - at least the write change. Based on=20
feedback from your suggestion below, the dw_readw32 may be removed.

>>>> +}
>>>> +
>>>
>>> So, does simple
>>> dws->readw =3D dw_readl;
>>> dws->writew =3D dw_writel;
>>>
>>> work for you?
>>>
>>
>> Yes, but I get the macro conflict shown above and "assignment from
>> incompatible pointer type" warnings. If I use the dws->read_w and
>> dws->write_w names, I get the incompatible pointer type warnings but=
 it
>> works.
>>
>> Thanks for reviewing.
>
> Okay, I guess there are two variants:
> a) replace u16 by u32 in existing functions;
> b) introduce new ones like you did.
>
> If no other opinions I think we better go b), but see above comments.
>
> And one more thing. If dw_readw() works for maybe we leave them as is=
 for now?
>

Yes, I just need the 32 bit write. I was trying to remain consistent bu=
t=20
I agree that only changing only writes would minimize the changes.

Thanks!
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
