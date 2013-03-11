From: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: [PATCH 00/12] spi/bcm63xx: various small cleanups and fixes
Date: Tue, 12 Mar 2013 00:13:35 +0100
Message-ID: <1363043627-23524-1-git-send-email-jogo@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Maxime Bizon <mbizon-MmRyKUhfbQ9GWvitb5QawA@public.gmane.org>,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

This patch series cleans up spi-bcm63xx and removes mostly redundant
checks that are already done by the spi core system itself, and also
adds some clock handling improvements. All in all nothing serious,
just some corner cases.

The only Patch I'm not 100% sure about is patch 7/12 ("check spi
bits_per_word in spi_setup"), because I'm not sure if setup is the
right place for that.

For all we care the spi can claim what it wants as its bit_per_word
as long as all transfers have it set to 8, so arguably we maybe
shouldn't reject it then.

Jonas Gorski (11):
  spi/bcm63xx: don't disable non enabled clocks in probe error path
  spi/bcm63xx: properly prepare clocks before enabling them
  spi/bcm63xx: remove duplicated mode bits check
  spi/bcm63xx: remove unneeded debug message
  spi/bcm63xx: remove unused variable bs from bcm63xx_spi_setup
  spi/bcm63xx: check spi bits_per_word in spi_setup
  spi/bcm63xx: simplify bcm63xx_spi_check_transfer
  spi/bcm63xx: remove spi chip select validity check
  spi/bcm63xx: inline bcm63xx_spi_check_transfer
  spi/bcm63xx: inline hz usage in bcm63xx_spi_setup_transfer
  spi/bcm63xx: use devm_ioremap_resource()

Kevin Cernekee (1):
  spi/bcm63xx: Remove unused variable

 drivers/spi/spi-bcm63xx.c |   79 +++++++++++----------------------------------
 1 file changed, 19 insertions(+), 60 deletions(-)

-- 
1.7.10.4


------------------------------------------------------------------------------
Symantec Endpoint Protection 12 positioned as A LEADER in The Forrester  
Wave(TM): Endpoint Security, Q1 2013 and "remains a good choice" in the  
endpoint security space. For insight on selecting the right partner to 
tackle endpoint security challenges, access the full report. 
http://p.sf.net/sfu/symantec-dev2dev
