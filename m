From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH v4 2/2] fpga: Add support for Lattice iCE40 FPGAs
Date: Sun, 30 Oct 2016 20:25:27 +0100
Message-ID: <CAMuHMdWJYrUp2Bqh6PW7KCEv16HYpvKXG9dAQBjfw+pMxDQd_A@mail.gmail.com>
References: <1477776746-3678-1-git-send-email-joel@airwebreathe.org.uk> <1477776746-3678-2-git-send-email-joel@airwebreathe.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: atull-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org, moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org,
        "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Joel Holdsworth <joel-IJEoVVyKhCJXvIrf17iDB/XRex20P6io@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1477776746-3678-2-git-send-email-joel-IJEoVVyKhCJXvIrf17iDB/XRex20P6io@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Sat, Oct 29, 2016 at 11:32 PM, Joel Holdsworth
<joel-IJEoVVyKhCJXvIrf17iDB/XRex20P6io@public.gmane.org> wrote:
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/lattice-ice40-fpga-mgr.txt
> @@ -0,0 +1,23 @@

> +- cdone-gpio:          GPIO connected to CDONE pin
> +- creset_b-gpio:       GPIO connected to CRESET_B pin. Note that CRESET_B is
> +                       treated as an active-low output because the signal is
> +                       treated as an enable signal, rather than a reset. This
> +                       is necessary because the FPGA will enter Master SPI
> +                       mode and drive SCK with a clock signal, potentially
> +                       jamming other devices on the bus, unless CRESET_B is
> +                       held high until the firmware is loaded.

Plural, please, like in the previous version, cfr.
Documentation/devicetree/bindings/gpio/gpio.txt:
"GPIO properties should be named "[<name>-]gpios", with <name> being the purpose
 of this GPIO for the device. While a non-existent <name> is considered valid
 for compatibility reasons (resolving to the "gpios" property), it is
not allowed
 for new bindings. Also, GPIO properties named "[<name>-]gpio" are valid and old
 bindings use it, but are only supported for compatibility reasons and
should not
 be used for newer bindings since it has been deprecated."

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
