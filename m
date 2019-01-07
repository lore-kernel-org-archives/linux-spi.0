From: Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH 0/8] spi: lpspi: Fix bugs and Add some functions support
Date: Mon, 7 Jan 2019 07:47:32 +0000
Message-ID: <20190107074639.6336-1-xiaoning.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>
To: "broonie@kernel.org" <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,

As subject, these fucntions support, including:
 - Support i.MX8 series boards;
 - Support cs-gpio fucntion;
 - Support DMA mode for both master and salve mode.

>From patch 3 to 6 are some bug-fix for PIO mode. In order to avoid data los=
s
and improve data transmission stability.

These are some notes about cs-gpio and DMA:
 - cs-gpio:
   Because LPSPI driver don't use default implementation of
   transfer_one_message(), I do the cs-gpio control way as same as the way
   used in spi core;

 - DMA:
   Any frame length longer than half txfifosize will be sent by DMA mode.
   For now, there are some limits:
      1. The maximum transfer speed in master mode depends on the slave dev=
ice,
         at least 40MHz on i.MX8 series (tested by spi-nor on 8qm-lpddr4-ar=
m2
         base board);
      2. The maximum transfer speed in slave mode is 15MHz(i.MX7ULP),
         22MHz(i.MX8 series).

Clark Wang (8):
  spi: lpspi: Add i.MX8 boards support for lpspi
  spi: lpspi: enable runtime pm for lpspi
  spi: lpspi: Improve the stability of lpspi data transmission
  spi: lpspi: Fix wrong transmission when don't use CONT
  spi: lpspi: Fix CLK pin becomes low before one transfer
  spi: lpspi: add the error info of transfer speed setting
  spi: lpspi: Add cs-gpio support
  spi: lpspi: add dma mode support

 drivers/spi/spi-fsl-lpspi.c | 612 ++++++++++++++++++++++++++++++++----
 1 file changed, 552 insertions(+), 60 deletions(-)

--=20
2.17.1
