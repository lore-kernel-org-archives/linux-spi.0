From: "Giuseppe Lippolis" <giu.lippolis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: RT5350 spi half duplex?
Date: Wed, 18 Jan 2017 21:39:06 +0100
Message-ID: <008601d271ca$ea3e7560$bebb6020$@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: de
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,
I=92m experimenting the spi interface on a RT5350 target.
Its spi driver set the interface as half duplex

=A0=A0=A0=A0=A0=A0=A0 master->dev.of_node =3D pdev->dev.of_node;
=A0=A0=A0=A0=A0=A0=A0 master->mode_bits =3D RT2880_SPI_MODE_BITS;
=A0=A0=A0=A0=A0=A0=A0 master->bits_per_word_mask =3D SPI_BPW_MASK(8);
=A0=A0=A0=A0=A0=A0=A0 master->min_speed_hz =3D clk_get_rate(clk) / 128;
=A0=A0=A0=A0=A0=A0=A0 master->max_speed_hz =3D clk_get_rate(clk) / 2;
=A0=A0=A0=A0=A0=A0=A0 master->flags =3D SPI_MASTER_HALF_DUPLEX;
=A0=A0=A0=A0=A0=A0=A0 master->setup =3D rt2880_spi_setup;
=A0=A0=A0=A0=A0=A0=A0 master->prepare_message =3D =
rt2880_spi_prepare_message;
=A0=A0=A0=A0=A0=A0=A0 master->set_cs =3D rt2880_spi_set_cs;
=A0=A0=A0=A0=A0=A0=A0 master->transfer_one =3D rt2880_spi_transfer_one,

but from the datasheet it seems that the device is full duplex capable.
Is there any reason to set the driver in this way?

By the way my debug was not easy because the=20

      static int __spi_validate(struct spi_device *spi, struct =
spi_message
*message)
     =20
in spi.c doesn=92t report any error message when an error condition is =
found.
Is there any reason to do in this way?
Can I send a patch with some error message?

Thanks, bye.=20


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
