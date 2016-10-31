From: Moritz Fischer <moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 2/2] fpga: Add support for Lattice iCE40 FPGAs
Date: Mon, 31 Oct 2016 10:04:45 -0700
Message-ID: <CAAtXAHfPSFvA0xf_UHfcZCjd1DcxUHs8WE12pRmPQEzEq8CscQ@mail.gmail.com>
References: <1477776746-3678-1-git-send-email-joel@airwebreathe.org.uk>
 <1477776746-3678-2-git-send-email-joel@airwebreathe.org.uk>
 <20161031063317.fqoaqemoiqhrrjzg@rob-hp-laptop> <f3c6dac1-bf10-c945-3e8a-9146e07253fd@airwebreathe.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Alan Tull <atull-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>,
        Devicetree List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joel Holdsworth <joel-IJEoVVyKhCJXvIrf17iDB/XRex20P6io@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <f3c6dac1-bf10-c945-3e8a-9146e07253fd-IJEoVVyKhCJXvIrf17iDB/XRex20P6io@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Oct 31, 2016 at 9:58 AM, Joel Holdsworth
<joel-IJEoVVyKhCJXvIrf17iDB/XRex20P6io@public.gmane.org> wrote:
> Hi Rob,
>
> Thanks for taking the time review the patches.
>
>>>  .../bindings/fpga/lattice-ice40-fpga-mgr.txt       |  23 +++
>>
>>
>> It's preferred that bindings are a separate patch.
>
>
> Can you just clarify a little? I'm happy to split the patch up, but I don't
> understand how it could work without the bindings. For example, in
> ice40_fpga_probe, I have to get the GPIOs with devm_gpiod_get for the driver
> to work.
>
> Maybe I'm missing something. Or do you just mean the documentation?

In general, the bindings go in a separate patch, that goes *before*
the code that uses it.
That way you're guaranteed it's there if you apply the series in order.

So [1/2] would be your bindings (ice40-fpga-mgr.txt) and [2/2] would
be your driver.

>
>
>>
>> -gpios is preferred.
>>
>> Please state direction and polarity.
>
>
> Thanks, I'll fix that up.
>
>>
>>> +- creset_b-gpio:       GPIO connected to CRESET_B pin. Note that
>>> CRESET_B is
>>
>>
>> Don't use '_'. In this case, I'd just do cresetb-gpios.
>
>
> So the pin is called CRESET_B in the datasheet. I think the _B refers to the
> active-low polarity of the line.
>
> So I would think it should be creset-b-gpios or creset-gpios. I'm not so
> convinced cresetb-gpios is ideal, but it's a minor point.
>
>>
>>> +                       treated as an active-low output because the
>>> signal is
>>> +                       treated as an enable signal, rather than a reset.
>>> This
>>
>>
>> Though for enable signals, enable-gpios is fairly standard even if that
>> deviates from the pin name.
>
>
> I would think that would just confuse the user, unless they dig out the
> binding docs. The FPGA doesn't have an enable pin, and it's not at all
> obvious that a "reset" pin means "enable" in this driver.

That's why you have the binding docs ;-)

Cheers,

Moritz
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
