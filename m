From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH] dt-bindings: Add bindings for aliases node
Date: Mon, 8 Oct 2018 18:07:13 -0700
Message-ID: <20181009010711.GA1577@ban.mtv.corp.google.com>
References: <20180925210255.172734-1-mka@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-spi@vger.kernel.org,
        netdev@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Florian Fainelli <f.fainelli@gmail.com>
To: Matthias Kaehlcke <mka@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180925210255.172734-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

+ linux-spi, linux-wireless, netdev
+ others from previous conversations

Hi,

On Tue, Sep 25, 2018 at 02:02:55PM -0700, Matthias Kaehlcke wrote:
> Add a global binding for the 'aliases' node. This includes an initial list
> of standardized alias names for some hardware components that are commonly
> found in 'aliases'.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  Documentation/devicetree/bindings/aliases.txt | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/aliases.txt
> 
> diff --git a/Documentation/devicetree/bindings/aliases.txt b/Documentation/devicetree/bindings/aliases.txt
> new file mode 100644
> index 000000000000..d64ed1c7eb34
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/aliases.txt
> @@ -0,0 +1,47 @@
> +The aliases node
> +----------------

I like the idea in general, and it might be good to note (e.g., commit
message) that this was inspired by this thread:

https://lore.kernel.org/lkml/20180815221601.GB24830@rob-hp-laptop/

where we were interested in firmware-to-device-tree path stability --
and the answer was basically: don't memorize paths, just use aliases
instead. But then, it was clear that aliases were not documented very
formally at all.

So here we are!

> +
> +The aliases node contains properties that represent aliases to device tree
> +nodes. The name of the property is the alias name, the value is the path of
> +a the device tree node that corresponds to the alias. The path may be
> +specified as a string or a phandle.
> +
> +Alias names are often suffixed with a numeric ID, especially when there may
> +be multiple instances of the same type. The ID typically corresponds to the
> +hardware layout, it may also be used by drivers for a stable mapping of
> +device names and hardware entities.
> +
> +Alias names
> +-----------
> +
> +The devicetree specification doesn't require the use of specific alias
> +names to refer to hardware entities of a given type, however the Linux
> +kernel aims for a certain level of consistency.
> +
> +The following standardized alias names shall be used for their
> +corresponding hardware components:
> +
> +  bluetoothN		Bluetooth controller
> +  ethernetN		Ethernet interface
> +  gpioN			GPIO controller
> +  i2cN			i2c bus
> +  mmcN			MMC bus
> +  rtcN			Real time clock
> +  serialN		UART port
> +  spiN			SPI bus
> +  wifiN			Wireless network interface

For the network-device-related names (bluetooth, ethernet, and wifi), I
think there's a clear documented reason for this (supporting MAC address
plumbing from a DT-aware bootloader). I'm not quite as sure about all
the others, and unfortunately, I'm aware of at least one subsystem owner
that explicitly does NOT like the aliases usage that is currently
supported (spi), and shot down a patch where I tried to use it in a DTS
file (despite its regular usage in many other DTS files).

So I guess I'm saying: perhaps we should get buy-in from various
subsystems before we include them? So maybe it's wiser to start
small(er) and only add once we're sure they are useful? Or perhaps Rob
has other thoughts.

> +
> +The above list is not exhaustive and will be extended over time. Please
> +send patches to devicetree@vger.kernel.org if you think a hardware
> +component and its alias name should be on the list.
> +
> +Example
> +-------
> +
> +aliases {
> +	bluetooth0 = "/soc/serial@fdf01000/bluetooth";
> +	rtc0 = &rtc0;
> +	wifi0 = &wlcore;
> +};
> +
> +(based on arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts)

What is the relevance of this line? This doesn't look anything like that
hikey DTS. Maybe the "based on" line should just be removed? The example
seems fine though.

Anyway, perhaps with a trimmed list of supported alias names:

Reviewed-by: Brian Norris <briannorris@chromium.org>
