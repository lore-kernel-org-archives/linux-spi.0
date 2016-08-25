From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH/PROTO 0/9] R-Car H3 MSIOF Parent Clock Control Prototype
Date: Thu, 25 Aug 2016 14:34:53 +0900
Message-ID: <CANqRtoRQ4tUrVyJqOsN_AE8WwXkG71rkQMFKr+6z36wPoQ+PJw@mail.gmail.com>
References: <1471019925-29083-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1471019925-29083-1-git-send-email-geert+renesas@glider.be>
Sender: linux-clk-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Geert,

On Sat, Aug 13, 2016 at 1:38 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>         Hi all,
>
> On R-Car H3, the various MSIOF instances (used for SPI) have a common
> parent clock. This mso clock is a programmable "DIV6" clock (divider
> 1 - 64). Its rate lies in the range 12.5 to 800 MHz, or 6.25 to 400 MHz
> (depending on the main crystal).
> After boot up, the default configuration is the lowest possible rate,
> which leads to bad performance with devices desiring a higher transfer
> rate.
>
> MSIOF clock tree:
>
>     pll1/4 (800 or 400 MHz)
>       mso clock
>         msiof0 clock (type MSTP = gate + status)
>           msiof0 internal divider (divider range 1 - 1024, with holes)
>         msiof1 clock (type MSTP)
>           msiof1 internal divider
>         msiof2 clock (type MSTP)
>           msiof2 internal divider
>         msiof3 clock (type MSTP)
>           msiof3 internal divider
>
> To optimize performance, we want to control the mso parent clock.
>
>   - Higher parent clock means:
>       + Better performance for devices wanting high target rates,
>       + More accurate target rates in MSIOF driver,
>       - More power consumption (doesn't matter that much with R-Car),
>       - Cannot support devices needing real low target rates.
>   - Lower parent clock means:
>       + Less power consumption (doesn't matter that much with R-Car),
>       + Can support all devices,
>       - Worse performance for devices wanting high target rates,
>       - Less accurate target rates, decreasing performance.
>
> Configuring the mso parent clock rate can either be done statically, or
> dynamically. In both cases, this must be based on individual device
> requirements. Note that this is not specific to SPI.
>
> SPI specific notes:
>   - The SPI master knows about SPI slave device maximum frequencies only
>     when spi_master.setup() is called,
>   - SPI slave device maximum frequencies may change at runtime (through
>     calling spi_setup(), esp. for spidev),
>   - Currently the MSIOF driver does not set
>     spi_master.{min,max}_speed_hz. However, setting it means the SPI
>     core will never call spi_master.setup() with a rate outside this
>     range, and thus we will never be informed of such rates.  Hence if
>     we decide to set this, and we want dynamic configuration, we should
>     fill in the real minimum and maximum supported by the hardware,
>     regardless of the current parent clock rate.
>
> In this prototype, I'm offering 3 solutions to control the mso parent
> clock rate.
>
>   - Option 1: Static configuration through the "assigned-clocks" and
>     assigned-clock-rates DT properties.
>
>   - Option 2: Dynamic configuration, by changing the mso clock through
>     the msiofX module clocks from the MSIOF driver.
>
>   - Option 2: Dynamic configuration, by changing a dummy clk-divider,
>     which mimics the capabilities of the MSIOF internal divider.

Thanks for cooking up these solutions. I dislike putting software
policy into DT, but at least Option 1 is simple. Option 2 and 3 seem a
bit overly complex to me.

May I ask if you considered solving the common case and special case
independently?

Regarding the common case, I think it is sane to assume that everyone
wants a high performing solution if possible. So using highest clock
rate possible must be a good default to as long as we can be sure to
also be able to handle devices wanting low clock rates. In my mind
this would mean that a standard unmodified DT should result in highest
performance possible. This probably involves programming the CPG/MSSR
hardware during boot-up based on some table with maximum supported
frequency. The high performing setting may or may not be the default
from reset (or boot loader) today, but perhaps it makes sense to rely
less on hardware settings performed during boot? At least this seems
like a good long term aim to me.

As for short term special case handling, the only issue we are having
is when more than one MSIOF instance want to use frequencies that are
incompatible. The first MSIOF parent clock user should be able to
select whichever rate it wants in theory, but with more than one MSIOF
instance then if one MSIOF instance wants to use the highest frequency
possible and the other the lowest possible then the 1024 divider is
not enough to cover both. From my side I would say it makes sense to
cover this special case with "Option 1" above. To avoid probe order
issues the CPG/MSSR driver handling the parent clock could for
instance early during boot look for DT frequency properties in the DTB
and adjust the shared default rate based on that.

For more long term special case handling, can't each MSIOF instance
request the frequency independently and the parent clock CPG/MSSR
driver can take all the child frequency requests into consideration
and set something that satisfies everyone? clk_set_rate_range() and/or
struct clk_rate_request seem to provide some way to pass on this
information. During probe of the MSIOF driver perhaps the devices need
to be queued up early on and once all the devices are deemed to be
loaded then the devices are started in order with the lowest requested
frequency first. Of course, if we need to load a new slow speed device
later on then the existing ones may need to be ripped out and the
whole bunch reinstalled. I believe this is similar to "Option 2"
above.

Thanks,

/ magnus
