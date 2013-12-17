From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH v3 0/7] mtd: spi-nor: add a new framework for SPI NOR
Date: Tue, 17 Dec 2013 04:08:33 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EA56ADC@DBDE04.ent.ti.com>
References: <1387184330-14448-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
	"angus.clark@st.com" <angus.clark@st.com>,
	"lee.jones@linaro.org" <lee.jones@linaro.org>,
	"marex@denx.de" <marex@denx.de>,
	"Poddar, Sourav" <sourav.poddar@ti.com>,
	"broonie@linaro.org" <broonie@linaro.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"b44548@freescale.com" <b44548@freescale.com>,
	"b18965@freescale.com" <b18965@freescale.com>,
	"shawn.guo@linaro.org" <shawn.guo@linaro.org>
To: Huang Shijie <b32955@freescale.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1387184330-14448-1-git-send-email-b32955@freescale.com>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Shijie,

>From: Huang Shijie [mailto:b32955@freescale.com]
[...]
>Huang Shijie (7):
>  mtd: spi-nor: copy the SPI NOR commands to a new header file
>  mtd: spi-nor: add the basic data structures
>  mtd: spi-nor: add the framework for SPI NOR
>  mtd: m25p80: use the SPI nor framework
>  mtd: spi-nor: add a helper to find the spi_device_id
>  Documentation: add the binding file for Quadspi driver
>  mtd: spi-nor: Add Freescale QuadSpi driver
>
> .../devicetree/bindings/mtd/fsl-quadspi.txt        |   31 +
> drivers/mtd/Kconfig                                |    2 +
> drivers/mtd/Makefile                               |    1 +
> drivers/mtd/devices/Kconfig                        |    2 +-
> drivers/mtd/devices/m25p80.c                       | 1271 ++------------------

As much base code is copied from m25p90.c,
Do you mind keeping the sign-offs of the original contributors of m25p80.c
at-least in patches where much code is ported ?
This would at-least give some credit to original authors and contributors.

with regards, pekon
