From: Micka <mickamusset-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: am335x: spi driver and two chip select
Date: Tue, 12 Apr 2016 15:42:12 +0200
Message-ID: <CAF+MRt=ZJP2fssLHRUoR9T9EPfWEPN1LC0CLxZ0CgJQy01S3Rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,

I've two MAX3107 connected to the spi 1 line. ( chip select 0 and 1 )

The problem is that when the spi driver start the probe function of
the driver, the chip select of the second max3107 is set to low .....

During the first call of the probe function, the driver try to read a
register on the first device, but because of the second chip select
set to low, the two device answer at the same time .... I don't really
understand why ?

I've correctly configured the CS1 and CS0 to be set as an output with
a pull up ....


&spi1{
#address-cells = <1>;
#size-cells = <0>;
pinctrl-names = "default";
pinctrl-0 = <&bb_spi1_pins>;
status = "okay";
ti,pindir-d0-out-d1-in;

max3107a: max3107a@0 {
 compatible = "maxim,max3107";
 reg = <0>;
 clock-frequency = <1843200>;
 interrupt-parent = <&gpio1>;
 interrupts =<7 IRQ_TYPE_EDGE_FALLING>;
 gpio-controller;
 spi-max-frequency = <4000000>;
 status = "okay";
};

max3107b: max3107b@1 {
compatible = "maxim,max3107";
reg = <1>;
clock-frequency = <1843200>;
interrupt-parent = <&gpio2>;
interrupts=<5 IRQ_TYPE_EDGE_FALLING>;
spi-max-frequency = <4000000>;
status = "okay";
};

};
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
