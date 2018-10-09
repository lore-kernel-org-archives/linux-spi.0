From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH] dt-bindings: Add bindings for aliases node
Date: Tue, 9 Oct 2018 11:31:42 -0700
Message-ID: <20181009183141.GA126050@ban.mtv.corp.google.com>
References: <20180925210255.172734-1-mka@chromium.org>
 <20181009010711.GA1577@ban.mtv.corp.google.com>
 <CAMuHMdWe5JYp5eC2PvuG4xEud908Crhm+BhrtxPJ4Uo1-LCc4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, swboyd@chromium.org,
        Florian Fainelli <f.fainelli@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdWe5JYp5eC2PvuG4xEud908Crhm+BhrtxPJ4Uo1-LCc4g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Oct 09, 2018 at 09:22:07AM +0200, Geert Uytterhoeven wrote:
> Please note these aliases become cumbersome once you start considering
> (dynamic) DT overlays.  That's why I made them optional in the sh-sci
> serial driver, cfr. commit 7678f4c20fa7670f ("serial: sh-sci: Add support
> for dynamic instances").

Note that as I understand it, the entire point of documenting this sort
of thing is to help solidify the interface between a DT aware boot
program (e.g., bootloader) and a device tree which is provided
separately, to avoid memorizing node/path hierarchy. It doesn't need to
(and doesn't, as I read it) enforce an OS's device naming policy.

> Relevant parts of the commit description are:
> 
>     On DT platforms, the sh-sci driver requires the presence of "serialN"
>     aliases in DT, from which instance IDs are derived.  If a DT alias is
>     missing, the drivers fails to probe the corresponding serial port.
> 
>     This becomes cumbersome when considering DT overlays, as currently
>     there is no upstream support for dynamically updating the /aliases node
>     in DT.

That part is not a DT spec problem :)

>     Furthermore, even in the presence of such support, hardcoded
>     instance IDs in independent overlays are prone to conflicts.
> 
>     Hence add support for dynamic instance IDs, to be used in the absence of
>     a DT alias.  This makes serial ports behave similar to I2C and SPI
>     buses, which already support dynamic instances.

This seems to be a much different sort of problem. People always love
having predictable IDs given by the OS (myself included), but that's
just plain hard to do and impossible in some cases. I don't think that's
what this document is about though.

IOW, this document seems pretty consistent with the above: it doesn't
require the usage of aliases (and it seems silly to have a driver
*require* an alias) -- it just documents how one should name such an
alias if you expect multiple independent software components to
understand it.

> To clarify my point: R-Car M2-W has 4 different types of serial ports, for a
> total of 18 ports, and the two ports on a board labeled 0 and 1 may not
> correspond to the physical first two ports (what's "first" in a collection of
> 4 different types?).
> 
> Aliases may be fine for referring to the main serial console (labeled
> port 0 on the device, too), and the primary Ethernet interface (so U-Boot
> knows where to add the "local-mac-address" property), but beyond that,
> I think they should be avoided.

That's fair enough. Just because the solution isn't an all-purpose tool
doesn't mean it shouldn't be documented. The general concept is already
in ePAPR, but it's just not very specific about property names.

> Just my two^H^H^Hfive €c.

Thanks,
Brian

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
