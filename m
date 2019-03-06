From: Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH V2 0/8] spi: lpspi: Fix bugs and Add some functions support
Date: Wed, 6 Mar 2019 06:30:32 +0000
Message-ID: <20190306063020.793-1-xiaoning.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: "broonie@kernel.org" <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,

Sorry for replying so late. This patchset contains changes based on your an=
d other
reviewers' comments.

As subject, these fucntions support, including:
 - Support i.MX8 series boards;
 - Support cs-gpio fucntion;
 - Support DMA mode for both master and salve mode.

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
      2. The maximum transfer speed I test in slave mode is 15MHz(i.MX7ULP)=
,
         20MHz(i.MX8 series). In order to reach the maximum speed which is
         mentioned in datasheet, the load of connect wires between master a=
nd
         slave should be less than 15pF.

Each patch in this patchset should base on the previous one when applied.

Thank you!

Clark Wang (7):
  spi: lpspi: Add i.MX8 boards support for lpspi
  doc: lpspi: Document DT bindings for LPSPI clocks
  spi: lpspi: add the error info of transfer speed setting
  spi: lpspi: use the core way to implement cs-gpio function
  spi: lpspi: add dma mode support
  spi: lpspi: Add the missing NULL check
  spi: lpspi: Code cleanup

Han Xu (1):
  spi: lpspi: enable runtime pm for lpspi

 .../devicetree/bindings/spi/spi-fsl-lpspi.txt |  10 +-
 drivers/spi/spi-fsl-lpspi.c                   | 543 ++++++++++++++++--
 2 files changed, 495 insertions(+), 58 deletions(-)

--=20
2.17.1
