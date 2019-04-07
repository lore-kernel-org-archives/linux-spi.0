From: Vicente Bergas <vicencb@gmail.com>
Subject: Re: [BUG] Rockchip SPI: long burst writes produce unexpected result
Date: Sun, 07 Apr 2019 02:38:08 +0200
Message-ID: <746e632e-63e2-49af-8e8f-e37270beea73@gmail.com>
References: <21d83ed2-a8db-49cf-ba8c-c7844157d7b0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Cc: <linux-rockchip@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
To: Emil Renner Berthing <kernel@esmil.dk>,
        Heiko Stuebner <heiko@sntech.de>,
        Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <21d83ed2-a8db-49cf-ba8c-c7844157d7b0@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,
please, forget my previous mail about
  eff0275e5253604429aedc42b008c5fcaa6cc597
  spi: rockchip: simplify use_dma logic
i messed up with commit IDs, sorry.

The first offending commit is one later than that:
commit 420b82f842941a32adf309ca1b193adfc77616b0
Date:   Wed Oct 31 11:57:07 2018 +0100

    spi: rockchip: set min/max speed
   =20
    The driver previously checked each transfer if the
    requested speed was higher than possible with the
    current spi clock rate and raised the clock rate
    accordingly.
   =20
    However, there is no check to see if the spi clock
    was actually set that high and no way to dynamically
    lower the spi clock rate again.
   =20
    So it seems any potiential users of this functionality
    are better off just setting the spi clock rate at init
    using the assigned-clock-rates devicetree property.
   =20
    Removing this dynamic spi clock rate raising allows
    us let the spi framework handle min/max speeds
    for us.

Regards,
  Vicen=C3=A7.

On Saturday, April 6, 2019 7:34:32 PM CEST, Vicente Bergas wrote:
> Hi,
> i have been experiencing issues writing to NOR-Flash SPI Memories
> from two RK3399-based platforms: gru-kevin and sapphire board.
> For kevin, this resulted in a bricked device because that memory
> is the only boot device.
> Fortunately an external programmer is available.
>
> In order to isolate where the issue can be, several tests have been
> done, after which it makes me think the issue is related to the
> Rockchip SPI driver.
>
> 4KB burst reads work fine.
> The issue is only observed on the write burst length.
>
> Test user     user/kernel kernel    RK3399  Num  space   =20
> interface   space       SoC   Status Notes=20
> --------------------------------------------------------
> 1    flashrom linux_mtd   MTD/RKspi RKspi   Fail
> 2    flashrom linux_spi   RKspi     RKspi   Fail
> 3    flashrom linux_spi   spi_gpio  GPIO    OK
> 4    custom   linux_spi   spi_gpio  GPIO    OK   260-byte burst writes
> 5    custom   linux_spi   RKspi     RKspi   Fail 260-byte burst writes
> 6    custom   linux_spi   RKspi     RKspi   OK     1-byte burst writes
> 7    custom   linux_spi   RKspi     RKspi   OK    47-byte burst writes
> 8    custom   linux_spi   RKspi     RKspi   Fail  48-byte burst writes
>
> 3, 4) Unaccetably slow, device tree is
>  spi_gpio {
>    compatible =3D "spi-gpio";
>    #address-cells =3D <1>;
>    #size-cells =3D <0>;
>    cs-gpios   =3D <&gpio1 RK_PB2 GPIO_ACTIVE_HIGH>;
>    sck-gpios  =3D <&gpio1 RK_PB1 GPIO_ACTIVE_HIGH>;
>    mosi-gpios =3D <&gpio1 RK_PB0 GPIO_ACTIVE_HIGH>;
>    miso-gpios =3D <&gpio1 RK_PA7 GPIO_ACTIVE_HIGH>;
>    num-chipselects =3D <1>;
>    spidev@0 {
>      compatible =3D "spidev";
>      reg =3D <0>;
>      spi-max-frequency =3D <50000000>;
>    };
>  };
> 2, 5, 6, 7, 8) device tree is
>  &spi1 {
>    status =3D "okay";
>    spidev@0 {
>      compatible =3D "spidev";
>      reg =3D <0>;
>      spi-max-frequency =3D <50000000>;
>    };
>  };
> 5, 6, 7, 8) Burst writes are performed this way
>  enum { BURST =3D 48 };
>  struct spi_ioc_transfer msg[0x105];
>  unsigned i =3D 0;
>  for (unsigned j =3D 0; j < wcnt; j +=3D BURST) {
>    msg[i++] =3D { .tx_buf =3D warr, .len =3D BURST<wcnt-j ? BURST : wcnt-j =
};
>    warr +=3D BURST;
>  }
>  if (rcnt)
>    msg[i++] =3D { .rx_buf =3D rarr, .len =3D rcnt };
>  ioctl(fd, SPI_IOC_MESSAGE(i), msg);
> 1, 2, 5, 8) I have no logic analyzer to see what is happenning on the
> SPI bus, but when it fails at 48-byte bursts, the contents of the memory
> are like this:
> Addr Expected                                        Actual
> 000  FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  FF FF FF=20
> FF FF FF FF FF FF FF FF FF FF FF FF FF
> 010  FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  FF FF FF=20
> FF FF FF FF FF FF FF FF FF FF FF FF FF
> 020  FF FF FF FF FF FF FF FF FF FF FF FF F1 F2 F3 F4  FF FF FF=20
> FF FF FF FF FF FF F1 F2 F3 F4 FF FF FF
> 030  FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  FF FF FF=20
> FF FF FF FF FF FF FF FF FF FF FF FF FF
> 040  FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  FF FF FF=20
> FF FF FF FF FF FF FF FF FF FF FF FF FF
> 050  FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  FF FF FF=20
> FF FF FF FF FF FF FF FF FF FF FF FF FF
> 060  FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  FF FF FF=20
> FF FF FF FF FF FF FF FF FF FF FF FF FF
> 070  FF FF FF FF FF FF FF FF FF FF FF FF E1 E2 E3 E4  FF FF FF=20
> FF FF FF E1 E2 E3 E4 FF FF FF FF FF FF
> 080  FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  FF FF FF=20
> FF FF FF FF FF FF FF FF FF FF FF FF FF
> 090  FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  FF FF FF=20
> FF FF FF FF FF FF FF FF FF FF FF FF FF
> 0A0  FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  FF FF FF=20
> FF FF FF FF FF FF FF FF FF FF FF FF FF
> 0B0  FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  FF FF FF=20
> FF FF FF FF FF FF FF FF FF FF FF FF FF
> 0C0  FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  FF FF FF=20
> FF FF FF FF FF FF FF FF FF FF FF FF FF
> 0D0  FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  FF FF FF=20
> FF FF FF FF FF FF FF FF FF FF FF FF FF
> 0E0  FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  FF FF FF=20
> FF FF FF FF FF FF FF FF FF FF FF FF FF
> 0F0  FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  FF FF FF=20
> FF FF FF FF FF FF FF FF FF FF FF FF FF
> 780  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  00 00 00=20
> 00 00 00 00 00 00 00 00 00 00 00 00 00
> 790  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  00 00 00=20
> 00 00 00 00 00 00 00 00 00 00 00 00 00
> 7A0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  00 00 00=20
> 00 00 00 00 00 00 00 00 00 00 00 00 00
> 7B0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  00 00 00=20
> 00 00 00 00 00 00 00 00 00 00 00 00 00
> 7C0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  00 00 00=20
> 00 00 00 00 00 00 00 00 00 00 00 00 00
> 7D0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  00 00 00=20
> 00 00 00 00 00 00 00 00 00 00 00 00 00
> 7E0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  00 00 00=20
> 00 00 00 00 00 00 00 00 00 00 00 00 00
> 7F0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  00 FF FF=20
> FF FF FF FF FF FF FF FF FF FF FF FF FF
> 800  01 02 03 04 00 00 00 00 00 00 00 00 00 00 00 00  01 02 03=20
> 04 00 00 00 00 00 00 00 00 00 00 00 00
> 810  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  00 00 00=20
> 00 00 00 00 00 00 00 00 00 00 00 00 00
> 820  00 00 00 00 00 00 00 00 00 00 00 00 05 06 07 08  00 00 00=20
> 00 00 00 00 00 00 05 06 07 08 00 00 00
> 830  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  00 00 00=20
> 00 00 00 00 00 00 00 00 00 00 00 00 00
> 840  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  00 00 00=20
> 00 00 00 00 00 00 00 00 00 00 00 00 00
> 850  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  00 00 00=20
> 00 00 00 00 00 00 00 00 00 00 00 00 00
> 860  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  00 00 00=20
> 00 00 00 00 00 00 00 00 00 00 00 00 00
> 870  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  00 00 00=20
> 00 00 00 00 00 00 00 00 00 00 00 00 00
>
> Regards,
>  Vicen=C3=A7.
>
>
>
