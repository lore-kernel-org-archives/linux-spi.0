From: Boris Brezillon <boris.brezillon@collabora.com>
Subject: Re: [PATCH v2 06/11] mtd: spi-nor: add support for DTR protocol
Date: Thu, 27 Feb 2020 17:58:41 +0100
Message-ID: <20200227175841.51435e3f@collabora.com>
References: <20200226093703.19765-1-p.yadav@ti.com>
        <20200226093703.19765-7-p.yadav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org
To: Pratyush Yadav <p.yadav@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200226093703.19765-7-p.yadav@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, 26 Feb 2020 15:06:58 +0530
Pratyush Yadav <p.yadav@ti.com> wrote:

> Double Transfer Rate (DTR) is SPI protocol in which data is transferred
> on each clock edge as opposed to on each clock cycle. Make
> framework-level changes to allow supporting flashes in DTR mode.
> 
> Right now, mixed DTR modes are not supported. So, for example a mode
> like 4S-4D-4D will not work. All phases need to be either DTR or STR.

Didn't go deep into the patch but at first glance you don't seem to
extend the framework to support stateful modes as I tried to do here
[1]. That's really something we should address before considering
supporting xD-xD-xD modes, unless the SPI-NOR only supports one
stateful mode. If we don't do that first, we might face all sort of
unpleasant issues:

* kexec not working correctly because the previous kernel left the NOR
  in an unknown state
* suspend/resume not working properly
* linux not booting properly because the bootloader left the device in
  its non-default mode
* ...

[1]https://patchwork.kernel.org/cover/10638055/
