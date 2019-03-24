From: kernel@martin.sperl.org
Subject: [PATCH V2 0/9] spi: bcm2835aux: bug fixes and improvements
Date: Sun, 24 Mar 2019 17:49:53 +0000
Message-ID: <20190324175002.28969-1-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Martin Sperl <kernel@martin.sperl.org>
To: Mark Brown <broonie@kernel.org>, Eric Anholt <eric@anholt.net>,
 Stefan Wahren <stefan.wahren@i2se.com>,
 Hubert Denkmair <h.denkmair@intence.de>, linux-spi@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

From: Martin Sperl <kernel@martin.sperl.org>

Set of patches improving the spi-bcm2835aux driver and fixing
a data read corruption bug.

The main motivation is a rare data corruption fix that is mostly
observed in polling mode first reported by Hubert Denkmair.

So this patchset first implements a means to control the parameters
of when polling mode is used via module parameters and exports
the corresponding statistics.

As stated in original patch the driver does not support native CS.
But when cs-gpios is not configured in the dt (so a buggy dt) it is
still working with a lot of limitations, but the driver does not report
this fact.

So this patchset adds reporting and allows for a single native CS
(with limited functionality) to continue working with a buggy DT.
One question here remains: do we need to legacy support DTs
that are not following specs in the first place?

Then there is the real fix for the data-corruption which is split
into 3 parts: some code cleanup with code reuse, removing "dangerous"
fifo read (possibly introducing fifo data corruption) and safe fifo read.

Also we remove some dead code.

---
Changelog:
  V1 -> V2: reordering commits as per request of Stefan Wahren
            to help backporting the "essential" bugfixes go in first
	    remove the dependency on a different patchset focused on
	    making cs_change delay configurable

Martin Sperl (9):
  spi: bcm2835aux: unifying code between polling and interrupt driven
    code
  spi: bcm2835aux: remove dangerous uncontrolled read of fifo
  spi: bcm2835aux: use BCM2835_AUX_SPI_STAT_RX_LVL
  spi: bcm2835aux: remove dead code
  spi: bcm2835aux: fix driver to not allow 65535 (=-1) cs-gpios
  spi: bcm2835aux: warn in dmesg that native cs is not really supported
  spi: bcm2835aux: setup gpio-cs to output and correct level during
    setup
  spi: bcm2835aux: add driver stats to debugfs
  spi: bcm2835aux: make the polling duration limits configurable

 drivers/spi/spi-bcm2835aux.c | 207 +++++++++++++++++++++++++++++++------------
 1 file changed, 150 insertions(+), 57 deletions(-)

--
2.11.0
