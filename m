From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 2/2] fpga: Add support for Lattice iCE40 FPGAs
Date: Mon, 31 Oct 2016 16:22:06 -0500
Message-ID: <CAL_JsqJ68hG11YR6S0GmJaxoivytQPp=1EMaeTAnh-oAQZMEAw@mail.gmail.com>
References: <1477776746-3678-1-git-send-email-joel@airwebreathe.org.uk>
 <1477776746-3678-2-git-send-email-joel@airwebreathe.org.uk>
 <20161031063317.fqoaqemoiqhrrjzg@rob-hp-laptop> <f3c6dac1-bf10-c945-3e8a-9146e07253fd@airwebreathe.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Alan Tull <atull@opensource.altera.com>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
To: Joel Holdsworth <joel@airwebreathe.org.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f3c6dac1-bf10-c945-3e8a-9146e07253fd@airwebreathe.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Oct 31, 2016 at 11:58 AM, Joel Holdsworth
<joel@airwebreathe.org.uk> wrote:
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

Yes, just the documentation.

[...]

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
>
> Again, if you're adamant this is the correct convention it's no problem to
> make the change - just seems weird to me. What do you think?

"reset-gpios" is also somewhat standard if you prefer. You're the one
that called it an enable. :)

Rob
