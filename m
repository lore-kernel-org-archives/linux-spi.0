From: Emil Renner Berthing <emil.renner.berthing@gmail.com>
Subject: Re: [BUG] Rockchip SPI: long burst writes produce unexpected result
Date: Sun, 7 Apr 2019 21:55:10 +0200
Message-ID: <CANBLGcyeroURDCHrBPRQ8bbhNsy9u0LkCq0MQmWUyvPR=p4b8w@mail.gmail.com>
References: <21d83ed2-a8db-49cf-ba8c-c7844157d7b0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
To: Vicente Bergas <vicencb@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <21d83ed2-a8db-49cf-ba8c-c7844157d7b0@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Vicente,

On Sat, 6 Apr 2019 at 19:35, Vicente Bergas <vicencb@gmail.com> wrote:
>
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
> Test user     user/kernel kernel    RK3399
> Num  space    interface   space       SoC   Status Notes
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
>   spi_gpio {
>     compatible = "spi-gpio";
>     #address-cells = <1>;
>     #size-cells = <0>;
>     cs-gpios   = <&gpio1 RK_PB2 GPIO_ACTIVE_HIGH>;
>     sck-gpios  = <&gpio1 RK_PB1 GPIO_ACTIVE_HIGH>;
>     mosi-gpios = <&gpio1 RK_PB0 GPIO_ACTIVE_HIGH>;
>     miso-gpios = <&gpio1 RK_PA7 GPIO_ACTIVE_HIGH>;
>     num-chipselects = <1>;
>     spidev@0 {
>       compatible = "spidev";
>       reg = <0>;
>       spi-max-frequency = <50000000>;
>     };
>   };
> 2, 5, 6, 7, 8) device tree is
>   &spi1 {

Since you say reverting the "set min/max speed" patch fixes your issues
could you try raising the spi clock like this and see if it works for you?

+       assigned-clocks = <&cru SCLK_SPI1>;
+       assigned-clock-rates = <400000000>;

Of course the driver shouldn't let you configure the spi-controller in a way
that makes it skip bytes, but if this works for you then I still think
you're better off explicitly setting the spi clock speed rather than having
the driver raise it for you. At least while it does it without
checking for errors
or having a way to lower it again as outlined in the commit message.

>     status = "okay";
>     spidev@0 {
>       compatible = "spidev";
>       reg = <0>;
>       spi-max-frequency = <50000000>;
>     };
>   };
> ...

/Emil
