From: Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH V2 0/4] spi: lpspi: Add Slave Mode support for LPSPI
Date: Fri, 30 Nov 2018 04:29:03 +0000
Message-ID: <20181130042753.28756-1-xiaoning.wang@nxp.com>
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

i.MX LPSPI controller only works in Master mode previously. This patch
series adds support slave mode to LPSPI controller, including:
 - Replace all related structure names and object names which is named
   "master" with "controller",
 - adds SPI slave mode support for i.MX7ulp and i.MX8qm/qxp in PIO mode,
 - DT binding updates for slave mode.

Currently SPI Slave mode support patch has the following limitations:
1. The stale data in RXFIFO will be dropped when the Slave does any new
   transfer.
2. One transfer can be finished only after all transfer->len data been
   transferred to master device
3. Slave device only accepts transfer->len data. Any data longer than this
   from master device will be dropped. Any data shorter than this from
   master will cause LPSPI to stuck due to mentioned limitation 2.
4. Only PIO transfer is supported in Slave Mode.

Wire connection:
GND, SCK, MISO(to MISO of slave), MOSI(to MOSI of slave), SCS

Change log:
V2:=20
 - Split last version patch into 3 patches, and add the doc update.

Clark Wang (4):
  spi: lpspi: Replace all "master" with "controller"
  spi: lpspi: Add slave mode support
  spi: lpspi: Let watermark change with send data length
  doc: lpspi: Document DT bindings for LPSPI slave mode

 .../devicetree/bindings/spi/spi-fsl-lpspi.txt |   5 +-
 drivers/spi/spi-fsl-lpspi.c                   | 202 ++++++++++++------
 2 files changed, 138 insertions(+), 69 deletions(-)

--=20
2.17.1
