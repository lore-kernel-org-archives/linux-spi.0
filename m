From: =?iso-8859-1?Q?Jan_Kundr=E1t?= <jan.kundrat@cesnet.cz>
Subject: Re: [PATCH] spidev: Enable the Liebherr's BK4 board to work with =?iso-8859-1?Q?spidev_driver?=
Date: Mon, 01 Oct 2018 16:20:32 +0200
Message-ID: <47e37a54-6df6-47c0-b38b-ad35e9bd4ce4@cesnet.cz>
References: <20180927223152.24990-1-lukma@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Cc: Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180927223152.24990-1-lukma@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On p=C3=A1tek 28. z=C3=A1=C5=99=C3=AD 2018 0:31:52 CEST, Lukasz Majewski wrot=
e:
> With this commit the DSPI driver on the BK4 board can be used for SPI
> transmission managed from user space (via /dev/spidev0.0).

Hi Lukasz,
I tried submitting a similar patch for another devicem but got no reaction=20=

[1]. In the meanwhile, there has been another proposal [2] which moves=20
handling of this into userspace via udev. You might want to take a look at=20=

that mechanism instead (and perhaps send your Tested-by tag). It has worked=20=

well for me.

[1] https://patchwork.kernel.org/patch/10558889/
[2]=20
https://patchwork.kernel.org/project/spi-devel-general/list/?series=3D21295

Cheers,
Jan
