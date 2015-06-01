From: Baptiste Clenet <bapclenet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: At86rf212B(driver at86rf230), Ralink MT7628, cs1 always high
Date: Mon, 1 Jun 2015 09:52:52 +0200
Message-ID: <CAPpUg6Pje9VEtsObsHkoEkzQ5LN+AEA8-6XBRKu00Q3AHWx7DQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,

I'm working on the board Ralink MT7628 with an Atmel AT86RF212B by SPI.
I've configured the transceiver to be on cs1. I plugged cs from the
transceiver to pin 6 of MT7628. Here is my .dts:
palmbus@10000000 {
  spi@b00 {
      status = "okay";

      m25p80@0 {
        #address-cells = <1>;
        #size-cells = <1>;
        compatible = "en25q64";
        reg = <0 0>;
        ...
      };

      at86rf212@0 {
          compatible = "atmel,at86rf212";
          reg = <1>;
          interrupts = <15 4>;
          interrupt-parent = <&intc>;
          reset-gpio = <&gpio0 16 1>;
          sleep-gpio = <&gpio0 17 1>;
          spi-max-frequency = <1000000>;
      };
  };
};

Unfortunately, the spi driver for this board doesn't support two
slaves (spi-mt7621.c)
So I've edited spi-mt7621.c to allow two slaves on SPI master as follow:

static void mt7621_spi_set_cs(struct spi_device *spi, int enable)
{
  struct mt7621_spi *rs = spidev_to_mt7621_spi(spi);
  u32 polar = mt7621_spi_read(rs, MT7621_SPI_POLAR);

  if (enable) {
    if (spi->chip_select) {
      polar |= 0x02;
    } else {
      polar |= 0x01;
    }
  } else {
    if (spi->chip_select) {
      polar &= ~0x02;
    } else {
      polar &= ~0x01;
    }
  }
  mt7621_spi_write(rs, MT7621_SPI_POLAR, polar);
}
And updated the num-chipselect:
master->num_chipselect = 2;


Here is my dmesg | grep spi:
[    0.440000] rt2880-pinmux pinctrl: found group selector 8 for spi
[    0.440000] rt2880-pinmux pinctrl: request pin 7 (io7) for 10000b00.spi
[    0.440000] rt2880-pinmux pinctrl: request pin 8 (io8) for 10000b00.spi
[    0.440000] rt2880-pinmux pinctrl: request pin 9 (io9) for 10000b00.spi
[    0.440000] rt2880-pinmux pinctrl: request pin 10 (io10) for 10000b00.spi
[    0.440000] m25p80 spi32766.0: found w25q128, expected en25q64
[    0.460000] m25p80 spi32766.0: w25q128 (16384 Kbytes)
[    0.470000] m25p80 spi32766.0: using chunked io
[    0.470000] 4 ofpart partitions found on MTD device spi32766.0
[    0.490000] Creating 4 MTD partitions on "spi32766.0":
[   11.830000] at86rf230 spi32766.1: Non-Atmel dev found (MAN_ID 00 00)
[   11.840000] at86rf230: probe of spi32766.1 failed with error -22

While looking at pin 6, it seems that it stays at high state instead
of going up and down when we go through mt7621_spi_set_cs().

Here we can see that pin 6 is not part of spi pins group. Well it is
defined in spi_cs1 group.
>From the datasheet:
5:4    SPI_CS1_MODE   SPI CS1 GPIO mode
                                     2: REFCLK
                                     1: GPIO
                                     0: SPI CS1
and SPI
12     SPI_MODE           SPI GPIO mode
                                     1: GPIO
                                     0: SPI
(from REG 10000060 GPIO1 MODE)
I'm wondering if pinmux is well set?

How may I be sure that this register is well configured? and gpio is
correctly configured for that purpose? And how and where may
I configure them?

Feel free to ask questions if it doesn't make sense.

Cheers,
Baptiste
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
