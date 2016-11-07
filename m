From: Moritz Fischer <moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v8 3/3] fpga: Add support for Lattice iCE40 FPGAs
Date: Mon, 7 Nov 2016 13:41:28 -0800
Message-ID: <CAAtXAHeO+qF=X-7L8uOCuFjCcVnUhEFkucYd3xfsFgVUp8JdcQ@mail.gmail.com>
References: <1478486962-26794-1-git-send-email-joel@airwebreathe.org.uk>
 <1478486962-26794-3-git-send-email-joel@airwebreathe.org.uk>
 <CAAtXAHcr_tG5QPkN4WP9Otav+AsLJaWAutwcu7cxvegU2-+QfQ@mail.gmail.com> <da65c3e6-c0cf-df38-7f1b-c05d674f002c@airwebreathe.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Alan Tull <atull-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>,
        Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
        Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Devicetree List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex-ynQEQJNshbs@public.gmane.org>,
        clifford-cPpHkPqGOEfk7+2FdBfRIA@public.gmane.org
To: Joel Holdsworth <joel-IJEoVVyKhCJXvIrf17iDB/XRex20P6io@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <da65c3e6-c0cf-df38-7f1b-c05d674f002c-IJEoVVyKhCJXvIrf17iDB/XRex20P6io@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Joel,

On Mon, Nov 7, 2016 at 11:02 AM, Joel Holdsworth
<joel-IJEoVVyKhCJXvIrf17iDB/XRex20P6io@public.gmane.org> wrote:
> Hi Moritz - thanks for your comments.
>
>
>>> An example of such a device is the icoBoard; a RaspberryPI HAT which
>>> features an iCE40HX8K with a 1 or 8 MBit SRAM and ports for
>>> Digilent-compatible PMOD modules. A PMOD module may contain a device
>>> with which the kernel communicates, via the FPGA.
>>
>>
>> Personally I find this a bit verbose, but that's just me.
>
>
> I could cut it down a bit if you want. I was just trying to make the case
> for why this *has* to be in the kernel rather than just being done from
> user-space.
>
>
>>> +       struct spi_transfer assert_cs_then_reset_delay = {.cs_change = 1,
>>> +               .delay_usecs = ICE40_SPI_FPGAMGR_RESET_DELAY};
>>
>>
>> Formatting looks odd, can you move the .cs_change to the next line?
>
>
> Marek made the same comment. I'll make the change.
>
>
>>> +static int ice40_fpga_ops_write_complete(struct fpga_manager *mgr, u32
>>> flags)
>>> +{
>>> +       struct ice40_fpga_priv *priv = mgr->priv;
>>> +       struct spi_device *dev = priv->dev;
>>> +       const u8 padding[ICE40_SPI_FPGAMGR_NUM_ACTIVATION_BYTES] = {0,};
>>> +
>>> +       /* Check CDONE is asserted */
>>> +       if (!gpiod_get_value(priv->cdone)) {
>>> +               dev_err(&dev->dev,
>>> +                       "CDONE was not asserted after firmware
>>> transfer\n");
>>> +               return -EIO;
>>> +       }
>>> +
>>> +       /* Send of zero-padding to activate the firmware */
>>> +       return spi_write(dev, padding, sizeof(padding));
>>
>>
>> I'd move all of these into the write() callback.
>
>
> Is that correct? I was under the impression that write might be called
> multiple times to load firmware in multiple chunks.

Nah, you're right. Don't listen to me :)
>
>
>>> +       /* Enter reset */
>>> +       gpiod_set_value(priv->reset, 1);
>>
>>
>> I know Marek had suggested this, none of the other drivers behave like
>> that.
>> I'm not sure this is expected behavior for most people.
>
>
> For me it's not a big deal either way, but I think it's quite good for the
> driver to reset the device.
>
> When you remove most other drivers, you expect the driver to shut the device
> down, so isn't this just the same?
>
> ...but then the FPGA manager is a unique best with its own conventions, so
> perhaps it should behave differently.
>
> How can we get a consensus about this?

Fair enough. I don't mind either way all that much, just thought I'd
bring it up.

Thanks,

Moritz
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
