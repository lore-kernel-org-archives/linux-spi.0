From: Frode Isaksen <fisaksen@baylibre.com>
Subject: Enable DMA for daVinci SPI controller
Date: Fri, 10 Feb 2017 16:29:36 +0100
Message-ID: <1486740584-17875-1-git-send-email-fisaksen@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: broonie@kernel.org, linux-spi@vger.kernel.org
To: nsekhar@ti.com, khilman@baylibre.com, ptitiano@baylibre.com,
 linux-arm-kernel@lists.infradead.org
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

Enable DMA for the daVinci SPI using the SPI framework DMA mapping
function. Also, add some extra options to the spi-loopback-test
module to catch errors caused by many SG entries.
This has been tested using spidev_test, spi-loopback-test and
mounting and read/write UBIFS volume over SPI flash.

In-Reply-To: 
