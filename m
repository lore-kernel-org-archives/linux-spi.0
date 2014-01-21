From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 0/4] m25p80 Quad/Dual updates
Date: Tue, 21 Jan 2014 13:59:15 +0100
Message-ID: <1390309159-19643-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Marek Vasut <marex@denx.de>, Sourav Poddar <sourav.poddar@ti.com>,
 linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

	Hi,

This patch series allows to really use Quad and Dual SPI Read Tranfers
with the m25p80 driver:
    [1/4] mtd: m25p80: Enable Quad SPI read transfers for s25fl512s
    [2/4] mtd: m25p80: Set rx_nbits for Quad SPI transfers
    [3/4] mtd: m25p80: Add dual read support
    [4/4] mtd: m25p80: Enable Dual SPI read transfers for s25fl256s1 and
	  s25fl512s

Patch [2/4] is a bug fix.
Patches [3/4] and [4/4] may be considered of limited use (why use Dual
transfers if you have Quad transfers?), but
  1. not all Quad-capable devices may be connected using 6 wires,
  2. it allows to test Dual SPI transfers in SPI master drivers.

This was tested with a preliminary version of the Renesas QSPI driver and a
Spansion s25fl512s SPI FLASH.

Thanks for your comments!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
