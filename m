From: Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH 0/8] STM32 SPI various fixes
Date: Fri, 23 Jun 2017 14:55:42 +0200
Message-ID: <1498222550-19092-1-git-send-email-amelie.delaunay@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, Amelie Delaunay <amelie.delaunay@st.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@st.com>
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

This patchset answers to the reviews done after STM32 SPI driver introduction.

Amelie Delaunay (8):
  dt-bindings: spi: stm32: use SoC specific compatible
  spi: stm32: fix compatible to fit with new bindings
  dt-bindings: spi: stm32: fix example with st,spi-midi-ns property
  spi: stm32: replace st,spi-midi with st,spi-midi-ns to fit bindings
  spi: stm32: use normal conditional statements instead of ternary
    operator
  spi: stm32: add runtime PM support
  spi: stm32: enhance DMA error management
  spi: stm32: fix potential dereference null return value

 .../devicetree/bindings/spi/spi-stm32.txt          |   6 +-
 drivers/spi/spi-stm32.c                            | 127 +++++++++++++++------
 2 files changed, 94 insertions(+), 39 deletions(-)

-- 
1.9.1
