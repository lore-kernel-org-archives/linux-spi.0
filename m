From: "Daniel Ribeiro" <drwyrm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] pxa2xx_spi: wait_rx_stall before
	deasserting CS on PIO mode
Date: Sun, 17 Aug 2008 19:53:19 -0300
Message-ID: <6669365c0808171553i3f64b667t18fcea589d94411a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

Hi,

I am converting a driver from ssp.c API to pxa2xx_spi. But
when using PIO mode i am getting bogus rx data.

I did some tests, and it looks like CS is being deasserted
before the IO is done.

The following patch solved the issue for me.

Please CC me on replies, im not subscribed to spi-devel.

-- 
Daniel Ribeiro


-- patch --
pxa2xx_spi: wait_rx_stall before deasserting CS on PIO mode

Signed-off-by: Daniel Ribeiro <drwyrm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

diff --git a/drivers/spi/pxa2xx_spi.c b/drivers/spi/pxa2xx_spi.c
index 0c452c4..4a9c34e 100644
--- a/drivers/spi/pxa2xx_spi.c
+++ b/drivers/spi/pxa2xx_spi.c
@@ -593,6 +593,10 @@ static void int_transfer_complete(struct
driver_data *drv_d {
        void __iomem *reg = drv_data->ioaddr;

+       if (wait_ssp_rx_stall(drv_data->ioaddr) == 0)
+               dev_err(&drv_data->pdev->dev,
+                       "interrupt_transfer: ssp rx stall failed\n");
+
        /* Stop SSP */
        write_SSSR(drv_data->clear_sr, reg);
        write_SSCR1(read_SSCR1(reg) & ~drv_data->int_cr1, reg);

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
