From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Dynamically adding SPI buses (was: Re: [PATCH v8 0/8] Device Tree
 Overlays - 8th time's the charm)
Date: Fri, 27 Nov 2015 14:06:41 +0100
Message-ID: <CAMuHMdUPa6YMa98v+qXMnxeMZ41AKFY1ni12rJewSEnqSB7TRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Michael Fiore <mfjord02-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mike,

(replaying to an old mail, as I'm seeing the exact same behavior with current
 overlay code)

On Thu, Nov 13, 2014 at 9:10 PM, Michael Fiore <mfjord02-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> I have been doing some testing with the overlay patches and, while it
> is working in general, I have noticed a couple of issues.
>
> I am using the following patchsets in conjunction with an updated DTC compiler:
>
> * Device Tree Overlays (v8)
>
> * of: Resolver and dynamic updates
>
> * configfs: Implement binary attributes (v3)
>
> I have applied all 3 of the patchsets against rev
> f7e87a44ef60ad379e39b45437604141453bf0ec of the linux source tree.
> This is the rev that was specified in the submission of the v8 Device
> Tree Overlay patchset.
>
> My base dtb has a SPI bus set up, including chip selects, but
> disabled.  My overlay dtb enables that bus and adds 3 spi devices. My
> overlay is installed in /lib/firmware/port1_gpio.dtbo. The relevant
> portion of my base dtb follows:
>
>  91             /* runs to Accessory Port 1 */
>  92             spi0: spi@f0000000 {
>  93                 status = "disabled";
>  94                 cs-gpios = <&pioA 4 0>, <&pioA 2 0>, <&pioA 5 0>, <0>;
>  95             };
>
> Overlay contents are as follows:
>
> /dts-v1/;
> /plugin/;
>
> /* enable spi0 for mts-io */
>
> / {
>     fragment@0 {
>         target-path = "/ahb/apb/spi@f0000000";
>         __overlay__ {
>             status = "okay";
>
>             ap1-cs0@0 {
>                 compatible = "mts-io-ap1-adc";
>                 spi-max-frequency = <20000000>;
>                 reg = <0>;
>             };
>             ap1-cs1@1 {
>                 compatible = "mts-io-ap1-dout";
>                 spi-max-frequency = <1000000>;
>                 reg = <1>;
>             };
>             ap1-cs2@2 {
>                 compatible = "mts-io-ap1-din";
>                 spi-max-frequency = <1000000>;
>                 reg = <2>;
>             };
>         };
>     };
> };
>
> I have added the following patch in order to more easily demonstrate
> what I've observed. This change affects the function spi_add_device()
>
> Index: git/drivers/spi/spi.c
> ===================================================================
> --- git.orig/drivers/spi/spi.c 2014-11-13 07:41:14.424270598 -0600
> +++ git/drivers/spi/spi.c 2014-11-13 08:34:24.700331795 -0600
> @@ -424,6 +424,8 @@
>   /* Set the bus ID string */
>   spi_dev_set_name(spi);
>
> + dev_info(dev, "adding spi device - chip select [%d]", spi->chip_select);
> +
>   /* We need to make sure there's no other device with this
>   * chipselect **BEFORE** we call setup(), else we'll trash
>   * its configuration.  Lock against concurrent add() calls.
>
> Applying the overlay from above gives the following output:
>
> root@mtr2d2:~# mount -t configfs none /config/
> root@mtr2d2:~# cd /config/device-tree/overlays/
> root@mtr2d2:/config/device-tree/overlays# mkdir port1
> root@mtr2d2:/config/device-tree/overlays# echo port1_gpio.dtbo > port1/path
> atmel_spi f0000000.spi: version: 0x212
> atmel_spi f0000000.spi: Using dma0chan2 (tx) and dma0chan3 (rx) for
> DMA transfers
> atmel_spi f0000000.spi: Atmel SPI Controller at 0xf0000000 (irq 142)
> atmel_spi f0000000.spi: adding spi device - chip select [2]
> atmel_spi f0000000.spi: adding spi device - chip select [1]
> atmel_spi f0000000.spi: adding spi device - chip select [0]
> atmel_spi f0000000.spi: adding spi device - chip select [0]
> atmel_spi f0000000.spi: chipselect 0 already in use
> spi_master spi32766: spi_device register error /ahb/apb/spi@f0000000/ap1-cs0@0
> of_spi_notify: failed to create for '/ahb/apb/spi@f0000000/ap1-cs0@0'
> __of_changeset_entry_notify: notifier error @/ahb/apb/spi@f0000000/ap1-cs0@0
> atmel_spi f0000000.spi: adding spi device - chip select [1]
> atmel_spi f0000000.spi: chipselect 1 already in use
> spi_master spi32766: spi_device register error /ahb/apb/spi@f0000000/ap1-cs1@1
> of_spi_notify: failed to create for '/ahb/apb/spi@f0000000/ap1-cs1@1'
> __of_changeset_entry_notify: notifier error @/ahb/apb/spi@f0000000/ap1-cs1@1
> atmel_spi f0000000.spi: adding spi device - chip select [2]
> atmel_spi f0000000.spi: chipselect 2 already in use
> spi_master spi32766: spi_device register error /ahb/apb/spi@f0000000/ap1-cs2@2
> of_spi_notify: failed to create for '/ahb/apb/spi@f0000000/ap1-cs2@2'
> __of_changeset_entry_notify: notifier error @/ahb/apb/spi@f0000000/ap1-cs2@2
>
> It appears that the spi devices are getting added twice.  Despite the
> warnings and errors from the overlay driver and the spi subsystem, my
> spi devices are working properly.
>
> Attempts to apply additional overlays succeed, but generate an additional error:
>
> root@mtr2d2:/config/device-tree/overlays# mkdir port2
> root@mtr2d2:/config/device-tree/overlays# echo port2_gpio.dtbo > port2/path
> atmel_spi f0004000.spi: version: 0x212
> atmel_spi f0004000.spi: Using dma1chan0 (tx) and dma1chan1 (rx) for
> DMA transfers
> atmel_spi f0004000.spi: Atmel SPI Controller at 0xf0004000 (irq 143)
> atmel_spi f0004000.spi: adding spi device - chip select [2]
> atmel_spi f0004000.spi: adding spi device - chip select [1]
> atmel_spi f0004000.spi: adding spi device - chip select [0]
> atmel_spi f0004000.spi: adding spi device - chip select [0]
> atmel_spi f0004000.spi: chipselect 0 already in use
> spi_master spi32765: spi_device register error /ahb/apb/spi@f0004000/ap1-cs0@0
> of_spi_notify: failed to create for '/ahb/apb/spi@f0004000/ap1-cs0@0'
> __of_changeset_entry_notify: notifier error @/ahb/apb/spi@f0004000/ap1-cs0@0
> atmel_spi f0004000.spi: adding spi device - chip select [1]
> atmel_spi f0004000.spi: chipselect 1 already in use
> spi_master spi32765: spi_device register error /ahb/apb/spi@f0004000/ap1-cs1@1
> of_spi_notify: failed to create for '/ahb/apb/spi@f0004000/ap1-cs1@1'
> __of_changeset_entry_notify: notifier error @/ahb/apb/spi@f0004000/ap1-cs1@1
> atmel_spi f0004000.spi: adding spi device - chip select [2]
> atmel_spi f0004000.spi: chipselect 2 already in use
> spi_master spi32765: spi_device register error /ahb/apb/spi@f0004000/ap1-cs2@2
> of_spi_notify: failed to create for '/ahb/apb/spi@f0004000/ap1-cs2@2'
> __of_changeset_entry_notify: notifier error @/ahb/apb/spi@f0004000/ap1-cs2@2

When adding an SPI master device node to DT, or changing its status to "okay",
of_register_spi_devices() will scan for SPI slaves, and will add all of them.
Later, the notifier kicks:

    static int of_spi_notify(struct notifier_block *nb, unsigned long action,
                             void *arg)
    {
            ...

            case OF_RECONFIG_CHANGE_ADD:
                    master = of_find_spi_master_by_node(rd->dn->parent);
                    if (master == NULL)
                            return NOTIFY_OK;       /* not for us */

                    spi = of_register_spi_device(master, rd->dn);

Woops, this fails, as the device has been added before!
Should the code just check for the existence of the SPI slave first, or would
that cause problems when just modifying an existing SPI slave node in DT?

> (NULL device *): Direct firmware load for ort2_gpio.dtbo failed with error -2
> -sh: echo: write error: No such file or directory
>
> The first character of the dtbo file name got chomped. Again, despite
> the warnings and errors, the devices are successfully created and
> functional:
>
> root@mtr2d2:/config/device-tree/overlays# ls /sys/bus/spi/devices/
> spi32765.0  spi32765.1  spi32765.2  spi32766.0  spi32766.1  spi32766.2

FWIW, I fixed that one a while ago:

http://permalink.gmane.org/gmane.linux.drivers.devicetree/120744

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
