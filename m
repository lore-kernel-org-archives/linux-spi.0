From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH 2/3] spidev: Add DT binding example.
Date: Mon, 27 Apr 2015 16:14:31 +0200
Message-ID: <553E4447.6080202@martin.sperl.org>
References: <20150426103257.GJ22845@sirena.org.uk> <CAOMqctR235uF+7kNGsLEGfrrAOQAYmw0pWgk6t8fZHNT7XsRuw@mail.gmail.com> <20150426110144.GK22845@sirena.org.uk> <553CCABA.3090504@redhat.com> <12F80B18-7418-430E-94F7-5A20C133BA9A@martin.sperl.org> <CAOMqctR8MZ_r6HHEBWhgxpUsTaV=M7DfmnJ_VxTqjWu4KMBSwA@mail.gmail.com> <20150426125113.GF5627@lukather> <CAOMqctRbYoNG2c-5atBP3QvMKbEhOrAgxzK1QskA5k2TgHraFQ@mail.gmail.com> <20150427093618.GL22845@sirena.org.uk> <553E099C.4070208@redhat.com> <20150427112539.GR22845@sirena.org.uk>
Reply-To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
 Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
 linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>,
 linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
 linux-doc <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
 Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-sunxi+bncBDYPB344UMGBBTUI7GUQKGQE6AAAWZI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20150427112539.GR22845-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

On 2015-04-27 13:25, Mark Brown wrote:
> On Mon, Apr 27, 2015 at 12:04:12PM +0200, Hans de Goede wrote:
>
>> Have you seen my mail about the raspberry pi use-case? Using dt-overlays
>> simply is not an acceptable answer there. There are legitimate use-cases
>> for a "generic spi bus" concept with the bus only being accessible via
>> spidev.
>
>> Blocking this use-case because you do not believe it is a valid use-case
>> is not going to help, this will just lead to the custom distros these
>> boards are shipping doing some ugly hack, which is not what we want
>> IMHO.
>
> I don't think you've fully considered your use case here.  As I said in
> my reply to your earlier e-mail I think what you're looking for here is
> something like better UI around overlays.  Registering a SPI bus without
> knowing what's connected to it doesn't allow generic maker style usage
> of the board, it's just as likely to hinder a user as help them.  For
> example, if someone wants to use the SPI pins for another function such
> as GPIO they'll have to handle that (and may have problems with pin
> conflicts causing electrical issues if they do load up the DT with
> spidev in it).  If someone has a SPI device they want to bind an in
> kernel driver to they'll have to handle that, if they want to use a GPIO
> to provide an additional chip select they'll have to handle that too.
>
> Note that the discussion here isn't about userspace drivers, it's about
> how the hardware is described.

Mark, maybe you are missing something of how this can get done on the
raspberry pi with devicetree (and overlays).

So here how the raspberry-foundation describes the devices in their 
device-tree for spi:

dtsi:
                 spi0: spi@7e204000 {
                         compatible = "brcm,bcm2708-spi";
                         reg = <0x7e204000 0x1000>;
                         interrupts = <2 22>;
                         clocks = <&clk_spi>;
                         #address-cells = <1>;
                         #size-cells = <0>;
                         status = "disabled";
                 };

dts:
&spi0 {
         pinctrl-names = "default";
         pinctrl-0 = <&spi0_pins>;

         spidev@0{
                 compatible = "spidev";
                 reg = <0>;      /* CE0 */
                 #address-cells = <1>;
                 #size-cells = <0>;
                 spi-max-frequency = <500000>;
         };

         spidev@1{
                 compatible = "spidev";
                 reg = <1>;      /* CE1 */
                 #address-cells = <1>;
                 #size-cells = <0>;
                 spi-max-frequency = <500000>;
         };
};
/ {
         __overrides__ {
                 spi = <&spi0>,"status";
	};
}

So you see that spi is disabled by default - the pins are
free to use for anything.

The firmware then integrates the overrrides into the device-tree
before loading the kernel.

So to enable spi in general you add the following to /boot/config.txt:
dtparam=spi=on

That gives you spi plus two "generic" spidev devices.

If you want to include a mcp2515 you add also the following:
dtoverlay=mcp2515-can0-overlay
and that loads also the overlay for the mcp2515 can module.

The corresponding mcp2515 overlay looks like this:
/ {
     /* the spi config of the can-controller itself */
     fragment@1 {
         target = <&spi0>;
         __overlay__ {
             /* needed to avoid dtc warning */
             #address-cells = <1>;
             #size-cells = <0>;
             can0: mcp2515@0 {
                 reg = <0>;
                 compatible = "microchip,mcp2515";
                 pinctrl-names = "default";
                 pinctrl-0 = <&can0_pins>;
                 spi-max-frequency = <10000000>;
                 interrupt-parent = <&gpio>;
                 interrupts = <25 0x2>;
                 clocks = <&can0_osc>;
             };
         };
     };
};

(left out the unimportant stuff like clocks,
interrupt GPIOs,...)

All this implements:
* easy means to enable spi if requested by user
* by default includes spidev as the default device
* but this can get just as easily get overridden by another
   devicetree to get specific devices onboarded using the
   in kernel drivers - there are now something like 25+
   overlays provided by the foundation that follow this
   pattern...

This is really about describing the hardware in the best possible
ways and keeping the interface with the users simple by having
him only to edit /boot/config.txt.

Adding your own overlays is just as simple and also quite well
defined.

So coming from this perspective I believe that there is some
concern in the raspberry pi community, because the description
they provide is now specific to the HW and their intent and so
the loud "croaking" of spidev will irritate people even when
they have done everything the best they can.

OK, I admit, the spi-devices could be separate overlays if
one really wants to have them, but they can get disabled just
as easily (by a specific overlay) if only a single device is
needed.

The only thing that could possibly be better would be that
the user would define the "real" name of the device in the
device tree and spidev would bind to it if there is no driver
available (but that would require this "fallback" binding by
spidev in case of no driver).

Martin

P.s: note that by default the foundation still relies on the
very old spi driver, but there is an overlay to load
spi-bcm2835 instead - just add:
dtoverlay=spi-bcm2835-overlay

Which basically contains:
/ {
	compatible = "brcm,bcm2835", "brcm,bcm2836", "brcm,bcm2708", 
"brcm,bcm2709";
	/* setting up compatiblity to allow loading the spi-bcm2835 driver */
	fragment@0 {
		target = <&spi0>;
		__overlay__ {
			status = "okay";
			compatible = "brcm,bcm2835-spi";
		};
	};
};
