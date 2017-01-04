From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/1] spi: dw: Make debugfs name unique between instances
Date: Wed, 4 Jan 2017 11:06:25 +0200
Message-ID: <CAHp75VfRcsiZ3MmDSjy0H3zUhgr1SH1C5q9vaArr0c=Z8E3tCw@mail.gmail.com>
References: <1483419249-88956-1-git-send-email-preid@electromag.com.au>
 <CAHp75Vc=h1eepd3DYEiSxP_vG1CS+FyKijmEYtw8Td7dj_VZOw@mail.gmail.com>
 <CAHp75VfeX+9b2bEt9VdNrOX9+jbqfvXx8rk=K2FJsoghRoxQJA@mail.gmail.com> <ea4998f7-e55c-884e-cb4d-5533c7104dd7@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, kernel-NoMTM8u0nx3R7s880joybQ@public.gmane.org,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <ea4998f7-e55c-884e-cb4d-5533c7104dd7-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Jan 4, 2017 at 4:21 AM, Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org> wrote:
> G'day Andy,
>
> On 4/01/2017 07:05, Andy Shevchenko wrote:
>>
>> On Wed, Jan 4, 2017 at 1:02 AM, Andy Shevchenko
>> <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>>
>>> On Tue, Jan 3, 2017 at 6:54 AM, Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
>>> wrote:
>>>>
>>>> Some system have multiple dw devices. Currently the driver uses a
>>>> fixed name for the debugfs dir. Append bus_num to the debugfs dir
>>>> name to make it unique.
>>>>
>>>
>>> Reviewed-by: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>
>>
>> Ah, hold on.
>> dws->name is exactly what you are trying to re-invent here. Just use
>> it directly.
>>
> I did try that initially.
> However when I used that they where all named dw_spi65535.
>
> This seems to be because bus_num is set to -1 ion the call to
> dw_spi_add_host.
> Which results in dynamic bus_num assignment in the call to
> devm_spi_register_master.
>
> Moving 'snprintf(dws->name, sizeof(dws->name), "dw_spi%d", dws->bus_num);'
> to after
> devm_spi_register_master results in a warning being emitting when
> request_irq is called
> about an emit string at :
> WARNING: CPU: 0 PID: 1 at fs/proc/generic.c:369 __proc_create+0x1e8/0x1f0
>
> cat /proc/interrupts currently also shows dw_spi65535
>
> Rewrite dws->name after devm_spi_register_master is called fixes
> /proc/interrupts
> And it could then be used in debugfs.
> But does not fix the filename in /proc/irq/<num>/dw_spi65535
>
> I couldn't see a safe workaround with dws->name
> Unless we can move the request_irq to after devm_spi_register_master
>
> Thoughts?

I briefly checked couple of SPI drivers, they are doing
request_irq(..., dev_name(...), ...);

So, I propose to use that pattern for now, and move snprintf() call to
debugfs related code.

-- 
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
