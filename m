From: Illia Smyrnov <illia.smyrnov-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/2] spi: omap2-mcspi: add FIFO buffer support
Date: Wed, 5 Jun 2013 14:39:56 +0300
Message-ID: <1370432398-7796-1-git-send-email-illia.smyrnov@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>,
	Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Illia Smyrnov <illia.smyrnov-l0cyMroinI0@public.gmane.org>,
	Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring
	<rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Mark Brown
	<broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

These patches introduce FIFO support for TI OMAP4/OMAP5 MCSPI controller.
Using FIFO unload the DMA and improve data throughput. On Blaze (OMAP 4460) 
ethernet throughput with 2 bytes MCSPI FIFO buffer enabled was increased 
from 7.0877 Mbps to 7.9200 Mbps. The FIFO implementation sanity test on 
OMAP5 Panda board also has been done.

The FIFO buffer can be used with some limitations, so if enabled, it will be
set up only for suitable SPI transfers:
* FIFO depth size defined as a multiple of the SPI word length;
* transfer's data size is a multiple of FIFO depth;
* transfer's words count less or equal 65535.

To store FIFO parameters in DT modified Matthias Brugger patch has been used
(see the discussion at https://patchwork.kernel.org/patch/2333911/)

Illia Smyrnov (1):
  spi: omap2-mcspi: Add FIFO buffer support

Matthias Brugger (1):
  spi: spi-omap2-mcspi.c: Add dts for slave device configuration.

 Documentation/devicetree/bindings/spi/omap-spi.txt |   19 ++
 drivers/spi/spi-omap2-mcspi.c                      |  199 ++++++++++++++++++--
 include/linux/platform_data/spi-omap2-mcspi.h      |    1 +
 3 files changed, 203 insertions(+), 16 deletions(-)


------------------------------------------------------------------------------
How ServiceNow helps IT people transform IT departments:
1. A cloud service to automate IT design, transition and operations
2. Dashboards that offer high-level views of enterprise services
3. A single system of record for all IT processes
http://p.sf.net/sfu/servicenow-d2d-j
