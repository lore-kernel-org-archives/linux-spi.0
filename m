From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: spidev: That spidev in the DT issue again...
Date: Tue, 6 Feb 2018 09:41:19 +0100
Message-ID: <CAMuHMdVT5hJf73HxQvEixuufKrHSgFYaUvEwcAnTmSoNxNiZDA@mail.gmail.com>
References: <ef61ff15-ec38-42f0-8ef3-9235b50dfda1@smartacoustics.co.uk>
 <1517597933.25398.215.camel@impinj.com> <8622f025-ceee-b9cb-9ea7-8ac77ae020dd@smartacoustics.co.uk>
 <1517863326.25398.233.camel@impinj.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "henry.gomersall-rFU6cQq7QtIud/4VRtRfoNBc4/FLrbF6@public.gmane.org"
        <henry.gomersall-rFU6cQq7QtIud/4VRtRfoNBc4/FLrbF6@public.gmane.org>
To: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1517863326.25398.233.camel-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, Feb 5, 2018 at 9:42 PM, Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org> wrote:
> On Sat, 2018-02-03 at 08:31 +0000, Henry Gomersall wrote:
>> On 02/02/18 18:58, Trent Piepho wrote:
>> > It does not solve the problem of creating and destroying SPI slaves
>> > dynamically at run time.  This can be solved (and it way that isn't
>> > specific to spidev), via:
>> > * Copying the I2C new_device system, which allows this with limitations
>> > and in a SPI (and I2C) specific way.
>> > * Incorporation of the dynamic DT fragment loading system, which solves
>> > this with far less limitation and it manner that is not bus specific.
>>
>> Is this an aspiration, a WIP, or just a thought?
>
> The new_device was presented as a patch recently, but was linked to
> spidev.  I don't remember seeing a v2 that was not linked to spidev,
> which seemed straightforward, but I easily could have missed it.

You can base the implementation on the existing spi_slave_store() for SPI
slave controllers. Changes to be made:
  1. Read both chipselect number and driver name from the string passed,
  2. Change the device_find_child() call to look for an existing child with the
     specified chipselect number.
     XXX Do we want to allow overrides, or return -EBUSY if found?
  3. Fill in the chipselect number before calling spi_add_device().
  4. Tie it to the spi_master class,

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
