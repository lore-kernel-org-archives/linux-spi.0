From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/PROTO 0/9] R-Car H3 MSIOF Parent Clock Control Prototype
Date: Mon, 29 Aug 2016 14:38:22 +0200
Message-ID: <CAMuHMdWEUaFOdjzT1pZSX0DmYJSLZHDZtCF6OWPvN5uQEMMa9Q@mail.gmail.com>
References: <1471019925-29083-1-git-send-email-geert+renesas@glider.be> <CANqRtoRQ4tUrVyJqOsN_AE8WwXkG71rkQMFKr+6z36wPoQ+PJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
To: Magnus Damm <magnus.damm@gmail.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CANqRtoRQ4tUrVyJqOsN_AE8WwXkG71rkQMFKr+6z36wPoQ+PJw@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Magnus,

On Thu, Aug 25, 2016 at 7:34 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> On Sat, Aug 13, 2016 at 1:38 AM, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
>> On R-Car H3, the various MSIOF instances (used for SPI) have a common
>> parent clock. This mso clock is a programmable "DIV6" clock (divider
>> 1 - 64). Its rate lies in the range 12.5 to 800 MHz, or 6.25 to 400 MHz
>> (depending on the main crystal).
>> After boot up, the default configuration is the lowest possible rate,
>> which leads to bad performance with devices desiring a higher transfer
>> rate.
>>
>> MSIOF clock tree:
>>
>>     pll1/4 (800 or 400 MHz)
>>       mso clock
>>         msiof0 clock (type MSTP = gate + status)
>>           msiof0 internal divider (divider range 1 - 1024, with holes)
>>         msiof1 clock (type MSTP)
>>           msiof1 internal divider
>>         msiof2 clock (type MSTP)
>>           msiof2 internal divider
>>         msiof3 clock (type MSTP)
>>           msiof3 internal divider
>>
>> To optimize performance, we want to control the mso parent clock.
>>
>>   - Higher parent clock means:
>>       + Better performance for devices wanting high target rates,
>>       + More accurate target rates in MSIOF driver,
>>       - More power consumption (doesn't matter that much with R-Car),
>>       - Cannot support devices needing real low target rates.
>>   - Lower parent clock means:
>>       + Less power consumption (doesn't matter that much with R-Car),
>>       + Can support all devices,
>>       - Worse performance for devices wanting high target rates,
>>       - Less accurate target rates, decreasing performance.
>>
>> Configuring the mso parent clock rate can either be done statically, or
>> dynamically. In both cases, this must be based on individual device
>> requirements. Note that this is not specific to SPI.
>>
>> SPI specific notes:
>>   - The SPI master knows about SPI slave device maximum frequencies only
>>     when spi_master.setup() is called,
>>   - SPI slave device maximum frequencies may change at runtime (through
>>     calling spi_setup(), esp. for spidev),
>>   - Currently the MSIOF driver does not set
>>     spi_master.{min,max}_speed_hz. However, setting it means the SPI
>>     core will never call spi_master.setup() with a rate outside this
>>     range, and thus we will never be informed of such rates.  Hence if
>>     we decide to set this, and we want dynamic configuration, we should
>>     fill in the real minimum and maximum supported by the hardware,
>>     regardless of the current parent clock rate.
>>
>> In this prototype, I'm offering 3 solutions to control the mso parent
>> clock rate.
>>
>>   - Option 1: Static configuration through the "assigned-clocks" and
>>     assigned-clock-rates DT properties.
>>
>>   - Option 2: Dynamic configuration, by changing the mso clock through
>>     the msiofX module clocks from the MSIOF driver.
>>
>>   - Option 2: Dynamic configuration, by changing a dummy clk-divider,
>>     which mimics the capabilities of the MSIOF internal divider.
>
> Thanks for cooking up these solutions. I dislike putting software
> policy into DT, but at least Option 1 is simple. Option 2 and 3 seem a
> bit overly complex to me.
>
> May I ask if you considered solving the common case and special case
> independently?

I think all of this is sufficiently generic to apply to other parent clocks and
devices, too.

> Regarding the common case, I think it is sane to assume that everyone
> wants a high performing solution if possible. So using highest clock
> rate possible must be a good default to as long as we can be sure to
> also be able to handle devices wanting low clock rates. In my mind
> this would mean that a standard unmodified DT should result in highest
> performance possible. This probably involves programming the CPG/MSSR
> hardware during boot-up based on some table with maximum supported
> frequency. The high performing setting may or may not be the default
> from reset (or boot loader) today, but perhaps it makes sense to rely
> less on hardware settings performed during boot? At least this seems
> like a good long term aim to me.

We can easily add default rates to the clock tables in the CPG/MSSR driver,
and program them during clock driver initialization. This can still be
overridden from DT using "assigned-clock-rates".

Whether this is something we want to do now is another question:
MSIOF is unusable for SPI on (early) H3, and the Salvator-X development board
doesn't have any on-board SPI devices connected to MSIOF SPI masters, so we
don't have a use case for which we can define defaults.
Hence changes are high the user who develops his own (expansion) board will
have to configure a different value using "assigned-clock-rates" anyway.

Perhaps it's a better idea to add a comment to the r8a7795.dtsi or
r8a7795-salvator-x.dts file with an example "assigned-clock-rates" property,
serving as documentation for board designers, cfr. the clock-frequency values
to be overridden by the board DTS?

For other parent clocks related to devices which are used on Salvator-X, we can
provide sensible defaults in the CPG/MSSR driver.

> As for short term special case handling, the only issue we are having
> is when more than one MSIOF instance want to use frequencies that are
> incompatible. The first MSIOF parent clock user should be able to

IMHO there are two issues:
  1. Incompatible parent clock frequencies, due to the 1-1024 divider,
  2. Suboptimal clock frequencies, due to granularity of the clock rate.
      E.g. if the parent clock runs at 31 MHz and the device has an upper limit
      of 30 MHz, you can not use it at speeds higher than 15.5 MHz.
      Lowering the parent clock will increase performance here.

Of course the first is worse, as it totally prohibits using the device.

> select whichever rate it wants in theory, but with more than one MSIOF
> instance then if one MSIOF instance wants to use the highest frequency
> possible and the other the lowest possible then the 1024 divider is
> not enough to cover both. From my side I would say it makes sense to
> cover this special case with "Option 1" above. To avoid probe order

I agree "Option 1" is the best solution to make sure the parent clock rate
is usable for all SPI slave devices.

> issues the CPG/MSSR driver handling the parent clock could for
> instance early during boot look for DT frequency properties in the DTB
> and adjust the shared default rate based on that.

That's an alternative run-time way of determining a suitable parent clock rate.
This does mean the CPG/MSSR driver must be made aware of consumer devices,
their divider limitations, and device-specific properties ("spi-max-frequency");
has to scan for those in DT, and find a suitable parent clock rate.
It won't work when using DT overlays, while the system integrator can take
 those into account when specifying the global "assigned-clock-rates" property.

> For more long term special case handling, can't each MSIOF instance
> request the frequency independently and the parent clock CPG/MSSR
> driver can take all the child frequency requests into consideration
> and set something that satisfies everyone? clk_set_rate_range() and/or
> struct clk_rate_request seem to provide some way to pass on this
> information. During probe of the MSIOF driver perhaps the devices need
> to be queued up early on and once all the devices are deemed to be
> loaded then the devices are started in order with the lowest requested
> frequency first. Of course, if we need to load a new slow speed device
> later on then the existing ones may need to be ripped out and the
> whole bunch reinstalled. I believe this is similar to "Option 2"
> above.

Unfortunately spi_master.setup() is called sequentially for all SPI devices,
while we need to coordinate them to find a suitable parent clock frequency.

So again I think "Option 1" is the best solution.

Note that if we let software decide the optimal parent clock rate, the CPG/MSSR
driver should have frequency limits in its tables, to avoid programming
out-of-range frequencies. The DIV6 clock register layout allows for dividing
the 400 or 800 MHz clock by 1..64, while the MSO clock itself is limited to 66
MHz, according to the documentation.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
