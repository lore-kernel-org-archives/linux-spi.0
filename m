From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: CSR SiRFSoC PRIMA2: SPI compilation broken in 3.4-rc7
Date: Mon, 14 May 2012 13:14:23 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1205141311060.4916@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net,
 Linus Walleij <linus.walleij@linaro.org>, Barry Song <baohua.song@csr.com>
To: linux-arm-kernel@lists.infradead.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Hi

Might be good to try to fix for 3.4 release:

drivers/spi/spi-sirf.c: In function 'spi_sirfsoc_probe':
drivers/spi/spi-sirf.c:563: error: implicit declaration of function 'pinmux_get'
drivers/spi/spi-sirf.c:563: warning: assignment makes pointer from integer without a cast
drivers/spi/spi-sirf.c:568: error: implicit declaration of function 'pinmux_enable'
drivers/spi/spi-sirf.c:602: error: implicit declaration of function 'pinmux_disable'
drivers/spi/spi-sirf.c:603: error: implicit declaration of function 'pinmux_put'
make[3]: *** [drivers/spi/spi-sirf.o] Error 1

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
