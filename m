From: Ezra Buehler <ezra@easyb.ch>
Subject: Re: [RFC 00/25] arm64: realtek: Add Xnano X5 and implement
 TM1628/FD628/AiP1618 LED controllers
Date: Tue, 25 Feb 2020 22:42:57 +0100
Message-ID: <E33E27B9-D33C-4182-A5B1-C72FA40470BC@easyb.ch>
References: <20191212033952.5967-1-afaerber@suse.de>
 <7110806f-ddbd-f055-e107-7a1f7e223102@arm.com>
 <c86c6bc0-b0e5-c46e-da87-9d910b95f9f3@suse.de>
 <04e7d7cd-a8bc-621b-9205-1a058521cabe@arm.com>
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Cc: linux-realtek-soc@lists.infradead.org, linux-leds@vger.kernel.org,
        linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        csd@princeton.com.tw, devicetree@vger.kernel.org, sales@fdhisi.com,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, zypeng@titanmec.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, Dan Murphy <dmurphy@ti.com>,
        linux-rockchip@lists.infradead.org
To: Robin Murphy <robin.murphy@arm.com>,
        =?utf-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <04e7d7cd-a8bc-621b-9205-1a058521cabe@arm.com>
Sender: linux-leds-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Robin,
Hi Andreas,

> On 13 Dec 2019, at 15:07, Robin Murphy <robin.murphy@arm.com> wrote:
>=20
> I also have one of the H96 Max boxes (which I picked up out of =
curiosity
> for the mysterious RK3318) with an FD6551, although I've not attacked
> that one with the logic analyser yet to see how similar it is.

I have a T9 (RK3328) TV box with the same chip in it. The FD6551 uses an
I2C-like protocol. Every digit (and the symbols) have an I2C address,
but, the display does not signal ACK. AFAIK the FD650 and FD655 which
are used in other boxes (Amlogic) are very similar.

So far, I have whipped up a proof-of-cocept driver that uses i2c-gpio.
The digits seem to be rotated by 180 degrees. So, in order to use
map_to_7segment.h I had to define the BIT_SEG7_* constants differently.
My display also has multiple symbols (WIFI, network, pause, play, USB,
alarm) that are controlled by writing to the same address as for the
colon.

I=E2=80=99d love to work on a driver (similar to Andreas=E2=80=99 SPI =
based driver) for
these I2C connected chips.

Cheers,
Ezra.
