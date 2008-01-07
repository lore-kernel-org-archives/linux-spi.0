From: Sebastian Siewior <sfgeneral-tbOqE5TproD1e3ktjv5YCg@public.gmane.org>
Subject: drivers/spi/mpc52xx_psc_spi.c,
	potential use after free
Date: Mon, 7 Jan 2008 15:30:25 +0100
Message-ID: <20080107143025.GA21720@Chamillionaire.breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Dragos Carp <dragos.carp-+ybMorV4k0dBDgjK7y7TUQ@public.gmane.org>
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

Hello Dragos,

Your mpc52xx_psc_spi_do_remove() from current git:

| static int __exit mpc52xx_psc_spi_do_remove(struct device *dev)
| {
|         struct spi_master *master = dev_get_drvdata(dev);
|         struct mpc52xx_psc_spi *mps = spi_master_get_devdata(master);
| 
|         flush_workqueue(mps->workqueue);
|         destroy_workqueue(mps->workqueue);
|         spi_unregister_master(master);
|         free_irq(mps->irq, mps);
|         if (mps->psc)
|                 iounmap(mps->psc);
| 
|         return 0;
| }

It looks to me that spi_unregister_master() frees your mps struct and
the following free_irq() and iounmap() touches deallocated memory.
Might this be correct?

Sebastian

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
