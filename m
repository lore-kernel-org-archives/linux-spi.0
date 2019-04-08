From: Vicente Bergas <vicencb@gmail.com>
Subject: Re: [BUG] Rockchip SPI: long burst writes produce unexpected result
Date: Mon, 08 Apr 2019 13:19:14 +0200
Message-ID: <1fcd4954-e0e8-4f93-80d3-8cbd169d0af9@gmail.com>
References: <21d83ed2-a8db-49cf-ba8c-c7844157d7b0@gmail.com>
 <CANBLGcyeroURDCHrBPRQ8bbhNsy9u0LkCq0MQmWUyvPR=p4b8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Cc: "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
To: Emil Renner Berthing <emil.renner.berthing@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANBLGcyeroURDCHrBPRQ8bbhNsy9u0LkCq0MQmWUyvPR=p4b8w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sunday, April 7, 2019 9:55:10 PM CEST, Emil Renner Berthing wrote:
> Hi Vicente,
>
> On Sat, 6 Apr 2019 at 19:35, Vicente Bergas <vicencb@gmail.com> wrote:
>> Hi,
>> i have been experiencing issues writing to NOR-Flash SPI Memories
>> from two RK3399-based platforms: gru-kevin and sapphire board.
>> For kevin, this resulted in a bricked device because that memory
>> is the only boot device. ...
>
> Since you say reverting the "set min/max speed" patch fixes your issues
> could you try raising the spi clock like this and see if it works for you?
>
> +       assigned-clocks =3D <&cru SCLK_SPI1>;
> +       assigned-clock-rates =3D <400000000>;
>
> Of course the driver shouldn't let you configure the spi-controller in a wa=
y
> that makes it skip bytes, but if this works for you then I still think
> you're better off explicitly setting the spi clock speed rather than having=

> the driver raise it for you. At least while it does it without
> checking for errors
> or having a way to lower it again as outlined in the commit message.
>
>>     status =3D "okay";
>>     spidev@0 {
>>       compatible =3D "spidev";
>>       reg =3D <0>;
>>       spi-max-frequency =3D <50000000>;
>>     };
>>   };
>> ...
>
> /Emil
>

Hi Emil,
I've added both assigned-clocks properties to the spi1 node and tested
again. Unfortunately it still fails in a similar way:
Before the maximum write burst without errors was 47, now it is 33.
I've also tested it with an SPI bus speed of 100KHz to make sure the
external hardware is not overrun:
  ioctl SPI_IOC_WR_MAX_SPEED_HZ 100000

Regards,
  Vicen=C3=A7.
