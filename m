From: Joakim Tjernlund <joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
Subject: [PATCH] SPI bit bang: Deactivate CS before
	restoring speed &	wordsize
Date: Fri, 07 Mar 2008 16:52:28 +0100
Message-ID: <1204905149.29669.22.camel@gentoo-jocke.transmode.se>
Reply-To: joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Restoring speed & wordsize on mpc83xx disables the controller temporarily
which makes the SPI outputs floating. This can cause a glich on
the SPI CLK which makes the slave in the other end unhappy.

Make sure that CS is disabled before restoring speed & wordsize
so any gliches are ignored by the SPI slave.

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
---

diff --git a/drivers/spi/spi_bitbang.c b/drivers/spi/spi_bitbang.c
index 0c85c98..53649cd 100644
--- a/drivers/spi/spi_bitbang.c
+++ b/drivers/spi/spi_bitbang.c
@@ -371,10 +371,6 @@ static void bitbang_work(struct work_struct *work)
 		m->status = status;
 		m->complete(m->context);
 
-		/* restore speed and wordsize */
-		if (setup_transfer)
-			setup_transfer(spi, NULL);
-
 		/* normally deactivate chipselect ... unless no error and
 		 * cs_change has hinted that the next message will probably
 		 * be for this chip too.
@@ -385,6 +381,10 @@ static void bitbang_work(struct work_struct *work)
 			ndelay(nsecs);
 		}
 
+		/* restore speed and wordsize */
+		if (setup_transfer)
+			setup_transfer(spi, NULL);
+
 		spin_lock_irqsave(&bitbang->lock, flags);
 	}
 	bitbang->busy = 0;


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
