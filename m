From: kernel@martin.sperl.org
Subject: [PATCH 0/5] allow to define cs deassert times in us, ns and SCK-len
Date: Sat, 23 Feb 2019 08:49:47 +0000
Message-ID: <20190223084952.14758-1-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Martin Sperl <kernel@martin.sperl.org>
To: Mark Brown <broonie@kernel.org>, Eric Anholt <eric@anholt.net>,
 Stefan Wahren <stefan.wahren@i2se.com>, linux-spi@vger.kernel.org,
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

Using spi_transfer.cs_change right now means that there is a hard-coded
10 us delay between deassert and re-assert of cs.

For some devices this is way too long and either wastes resources
unecessarily or the driver works arround this currently with multiple
spi messages.

So this patch set modifies the spie core and some drivers so that
in spi_transfer we now can now define the minimum delay in units of:
microseconds, nanoseconds or spi clock length.

But note that on lower specs machines those ns delays are not realistic.
Lower limits on the actual delay are put by the gpio framework latency
for setting gpio level.
On a Raspberry Pi 3 this overhead has been observed to be in the order
1.2us.

As an idea: the xfer->cs_change_delay_unit could become more generic
by renaming it to delay_unit and then also us it as a modifier when
using xfer->delay_usecs.

Martin Sperl (5):
  spi: core: allow defining time that cs is deasserted
  spi: core: allow reporting the effectivly used speed_hz for a transfer
  spi: core: allow defining time that cs is deasserted as a multiple of
    SCK
  spi: bcm2835: support effective_speed_hz
  spi: bcm2835aux: support effective_speed_hz

 drivers/spi/spi-bcm2835.c    |  5 ++--
 drivers/spi/spi-bcm2835aux.c |  5 ++--
 drivers/spi/spi.c            | 68 +++++++++++++++++++++++++++++++++++++-------
 include/linux/spi/spi.h      | 13 +++++++++
 4 files changed, 75 insertions(+), 16 deletions(-)

--
2.11.0
