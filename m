From: Brian Hutchinson <b.hutchman-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Not really following Mark Brown's spidev patch
Date: Tue, 25 Aug 2015 17:53:54 -0400
Message-ID: <CAFZh4h8D=rGwjG7eRGPyC3QP6Cj-4kHe3N7MhMELQNWgv76VhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

I know I'm slow, but I'm not quite understanding the gist of this patch:
http://www.spinics.net/lists/linux-spi/msg03301.html

I'm on a DM816x which has 4 McSPI channels.  In a TI 2.6.37 kernel,
our board file configured spidev as in:

struct spi_board_info __initdata ti816x_spi_slave_info[] = {
//    {
//        .modalias    = "m25p80",
//        .platform_data    = &ti816x_spi_flash,
//        .irq        = -1,
//        .max_speed_hz    = 75000000,
//        .bus_num    = 1,
//        .chip_select    = 0,
//    },
    {
        .modalias    = "spidev",
        .platform_data    = NULL,
        .irq            = -1,
        .max_speed_hz    = 100000,
        .bus_num        = 1,
        .chip_select    = 0,
    },
    {
        .modalias    = "spidev",
        .platform_data    = NULL,
        .irq            = -1,
        .max_speed_hz    = 100000,
        .bus_num        = 1,
        .chip_select    = 1,
    },
    {
        .modalias    = "spidev",
        .platform_data    = NULL,
        .irq            = -1,
        .max_speed_hz    = 100000,
    .bus_num        = 1,
    .chip_select    = 2,
},
    {
        .modalias    = "spidev",
        .platform_data    = NULL,
        .irq        = -1,
        .max_speed_hz    = 100000,
        .bus_num    = 1,
        .chip_select    = 3,
    },
};

The above resulted in us having the following devices:

root@beaglebone:/dev# ls -al spi*
crw------- 1 root root 153, 0 Jan  1  1970 spidev1.0
crw------- 1 root root 153, 1 Jan  1  1970 spidev1.1
crw------- 1 root root 153, 2 Jan  1  1970 spidev1.2
crw------- 1 root root 153, 3 Jan  1  1970 spidev1.3
root@beaglebone:/dev#

Now we have a 4.2 kernel with device tree support and I'm trying to
get the same spidev devices to show up that our application uses and I
can't figure out what the right thing to do is.

I see beagleboard code and other examples that looked like they worked
and existed before this patch and led me to believe that I needed
something like this in my .dts in addition to enabling spidev in my
.config:

&mcspi1 {
    pinctrl-names = "default";
    pinctrl-0 = <&mcspi1_pins>;

    spidev@0
        compatible = "spidev";
        spi-max-frequency = <100000>;
        reg = <0>;
        #address-cells = <1>;
        #size-cells = <1>;
    };

    spidev@1
        compatible = "spidev";
        spi-max-frequency = <100000>;
        reg = <1>;
        #address-cells = <1>;
        #size-cells = <1>;
    };

    spidev@2
        compatible = "spidev";
        spi-max-frequency = <100000>;
        reg = <2>;
        #address-cells = <1>;
        #size-cells = <1>;
    };

    spidev@3
        compatible = "spidev";
        spi-max-frequency = <100000>;
        reg = <3>;
        #address-cells = <1>;
        #size-cells = <1>;
    };

};

... but no matter what I try I get hit with the nasty warning from
this patch.  I've read the discussion and see the id table but I'm not
sure what I need to put in it.

I'm a simple guy and don't understand all the ins & outs of this .dts
stuff yet ... I just want my 4 spidev devices to show up again and
work.  As it is now, they show up with tons of dmesg warnings but only
the first spidev device actually works, the others don't work and I'm
not sure if it is related to my .dts or not.

Regards,

Brian
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
