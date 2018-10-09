From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] dt-bindings: Add bindings for aliases node
Date: Tue, 9 Oct 2018 09:22:07 +0200
Message-ID: <CAMuHMdWe5JYp5eC2PvuG4xEud908Crhm+BhrtxPJ4Uo1-LCc4g@mail.gmail.com>
References: <20180925210255.172734-1-mka@chromium.org> <20181009010711.GA1577@ban.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
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
To: Brian Norris <briannorris@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181009010711.GA1577@ban.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Brian,

On Tue, Oct 9, 2018 at 3:07 AM Brian Norris <briannorris@chromium.org> wrote:
> On Tue, Sep 25, 2018 at 02:02:55PM -0700, Matthias Kaehlcke wrote:
> > Add a global binding for the 'aliases' node. This includes an initial list
> > of standardized alias names for some hardware components that are commonly
> > found in 'aliases'.
> >
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/aliases.txt
> > @@ -0,0 +1,47 @@
> > +The aliases node
> > +----------------
>
> I like the idea in general, and it might be good to note (e.g., commit
> message) that this was inspired by this thread:
>
> https://lore.kernel.org/lkml/20180815221601.GB24830@rob-hp-laptop/
>
> where we were interested in firmware-to-device-tree path stability --
> and the answer was basically: don't memorize paths, just use aliases
> instead. But then, it was clear that aliases were not documented very
> formally at all.
>
> So here we are!
>
> > +
> > +The aliases node contains properties that represent aliases to device tree
> > +nodes. The name of the property is the alias name, the value is the path of
> > +a the device tree node that corresponds to the alias. The path may be
> > +specified as a string or a phandle.
> > +
> > +Alias names are often suffixed with a numeric ID, especially when there may
> > +be multiple instances of the same type. The ID typically corresponds to the
> > +hardware layout, it may also be used by drivers for a stable mapping of
> > +device names and hardware entities.
> > +
> > +Alias names
> > +-----------
> > +
> > +The devicetree specification doesn't require the use of specific alias
> > +names to refer to hardware entities of a given type, however the Linux
> > +kernel aims for a certain level of consistency.
> > +
> > +The following standardized alias names shall be used for their

s/shall/may/

> > +corresponding hardware components:
> > +
> > +  bluetoothN         Bluetooth controller
> > +  ethernetN          Ethernet interface
> > +  gpioN                      GPIO controller
> > +  i2cN                       i2c bus
> > +  mmcN                       MMC bus
> > +  rtcN                       Real time clock
> > +  serialN            UART port
> > +  spiN                       SPI bus
> > +  wifiN                      Wireless network interface
>
> For the network-device-related names (bluetooth, ethernet, and wifi), I
> think there's a clear documented reason for this (supporting MAC address
> plumbing from a DT-aware bootloader). I'm not quite as sure about all
> the others, and unfortunately, I'm aware of at least one subsystem owner
> that explicitly does NOT like the aliases usage that is currently
> supported (spi), and shot down a patch where I tried to use it in a DTS
> file (despite its regular usage in many other DTS files).
>
> So I guess I'm saying: perhaps we should get buy-in from various
> subsystems before we include them? So maybe it's wiser to start
> small(er) and only add once we're sure they are useful? Or perhaps Rob
> has other thoughts.

Please note these aliases become cumbersome once you start considering
(dynamic) DT overlays.  That's why I made them optional in the sh-sci
serial driver, cfr. commit 7678f4c20fa7670f ("serial: sh-sci: Add support
for dynamic instances").
Relevant parts of the commit description are:

    On DT platforms, the sh-sci driver requires the presence of "serialN"
    aliases in DT, from which instance IDs are derived.  If a DT alias is
    missing, the drivers fails to probe the corresponding serial port.

    This becomes cumbersome when considering DT overlays, as currently
    there is no upstream support for dynamically updating the /aliases node
    in DT.  Furthermore, even in the presence of such support, hardcoded
    instance IDs in independent overlays are prone to conflicts.

    Hence add support for dynamic instance IDs, to be used in the absence of
    a DT alias.  This makes serial ports behave similar to I2C and SPI
    buses, which already support dynamic instances.

To clarify my point: R-Car M2-W has 4 different types of serial ports, for a
total of 18 ports, and the two ports on a board labeled 0 and 1 may not
correspond to the physical first two ports (what's "first" in a collection of
4 different types?).

Aliases may be fine for referring to the main serial console (labeled
port 0 on the device, too), and the primary Ethernet interface (so U-Boot
knows where to add the "local-mac-address" property), but beyond that,
I think they should be avoided.

Just my two^H^H^Hfive €c.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
