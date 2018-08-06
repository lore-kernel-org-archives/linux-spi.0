From: Kosta Zertsekel <zertsekel@gmail.com>
Subject: Re: [PATCH] spi: orion: cosmetics - alias long direct_access variables
Date: Mon, 6 Aug 2018 22:27:46 +0300
Message-ID: <CADxo8W+5rvp-cFzqiSJ7RGC13N42v45N0pJ+m+2qO8DQ5AWS7Q@mail.gmail.com>
References: <20180806185158.2382-1-zertsekel@gmail.com> <20180806190912.GJ9372@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?SmFuIEt1bmRyw6F0?= <jan.kundrat@cesnet.cz>,
        Stefan Roese <sr@denx.de>, Ken Wilson <ken.wilson@opengear.com>
To: Andrew Lunn <andrew@lunn.ch>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180806190912.GJ9372@lunn.ch>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Aug 6, 2018 at 10:09 PM Andrew Lunn <andrew@lunn.ch> wrote:
>> @@ -683,6 +683,7 @@ static int orion_spi_probe(struct platform_device *pdev)
>>
>>       /* Scan all SPI devices of this controller for direct mapped devices */
>>       for_each_available_child_of_node(pdev->dev.of_node, np) {
>> +             struct orion_direct_acc *dacc;
>
> I would prefer direct_access, but it looks like this is too long to
> put the devm_ioremap on one line. But it should be enough to fix the
> odd indentation of r->start and PAGE_SIZE.

Actually, the longest possible name to put devm_ioremap on one line is
`dir_acc`.
I think `dir_acc` is readable enough to ring the `direct_access` in
the mind of a reader.
