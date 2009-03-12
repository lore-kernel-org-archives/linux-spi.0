From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: pxa2xx_spi suspend/resume
Date: Thu, 12 Mar 2009 10:38:46 -0400
Message-ID: <49B91E76.3090309@whoi.edu>
References: <1236771011.17708.37.camel@brutus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Daniel Ribeiro <drwyrm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1236771011.17708.37.camel@brutus>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Daniel Ribeiro wrote:
> Hello linux spi experts.
> 
> I'm trying to get suspend/resume working on my pxa27x board, but resume
> freezes waiting for SPI I/O.
> 
> After correcting suspend/resume ordering (i need MCI and UDC to resume
> after SPI, PMIC and USB transceiver on the SPI bus), it still freezes at
> the first SPI transfer.
> 
> I added some debug code to pxa2xx_spi.c as follows:
> 
> @@ -1095,6 +1097,14 @@ static void pump_transfers(unsigned long data)
>         /* after chip select, release the data by enabling service
>          * requests and interrupts, without changing any mode bits */
>         write_SSCR1(cr1, reg);
> +       mdebug("pump_transfersA SSCR0=%08x SSCR1=%08x SSTO=%08x SSPSP=%08x SSSR=%08x\n",
> +               read_SSCR0(drv_data->ioaddr), read_SSCR1(drv_data->ioaddr),
> +               read_SSTO(drv_data->ioaddr), read_SSPSP(drv_data->ioaddr), read_SSSR(drv_data->ioaddr));
> +       udelay(200);
> +       mdebug("pump_transfersB SSCR0=%08x SSCR1=%08x SSTO=%08x SSPSP=%08x SSSR=%08x\n",
> +               read_SSCR0(drv_data->ioaddr), read_SSCR1(drv_data->ioaddr),
> +               read_SSTO(drv_data->ioaddr), read_SSPSP(drv_data->ioaddr), read_SSSR(drv_data->ioaddr));
> +
>  }
>  
>  static void pump_messages(struct work_struct *work)
> @@ -1626,11 +1636,16 @@ static int pxa2xx_spi_suspend(struct platform_device *pdev, pm_message_t state)
>         int status = 0;
>  
>         status = stop_queue(drv_data);
> -       if (status != 0)
> +       if (status != 0) {
> +               mdebug("spi suspend: status error!\n");
>                 return status;
> +       }
>         write_SSCR0(0, drv_data->ioaddr);
>         clk_disable(ssp->clk);
> -
> +       mdebug("spi suspend ok\n");
> +       mdebug("SUSPEND SSCR0=%08x SSCR1=%08x SSTO=%08x SSPSP=%08x\n",
> +               read_SSCR0(drv_data->ioaddr), read_SSCR1(drv_data->ioaddr),
> +               read_SSTO(drv_data->ioaddr), read_SSPSP(drv_data->ioaddr));
>         return 0;
>  }
> @@ -1649,6 +1665,9 @@ static int pxa2xx_spi_resume(struct platform_device *pdev)
>                 dev_err(&pdev->dev, "problem starting queue (%d)\n", status);
>                 return status;
>         }
> +       mdebug("RESUME SSCR0=%08x SSCR1=%08x SSTO=%08x SSPSP=%08x\n",
> +               read_SSCR0(drv_data->ioaddr), read_SSCR1(drv_data->ioaddr),
> +               read_SSTO(drv_data->ioaddr), read_SSPSP(drv_data->ioaddr));
>  
>         return 0;
>  }
> 
>  
> And this generates the following debug output:
> 
> I/O before suspend:
> ezx_pcap_putget: W 9c0253d2
> pump_transfersA SSCR0=0010008f SSCR1=00380740 SSTO=00000064 SSPSP=00000000 SSSR=0000f034
> pump_transfersB SSCR0=0010008f SSCR1=00000740 SSTO=00000000 SSPSP=00000000 SSSR=0000f024
> ezx_pcap_putget: R 000253d2
> 
> Suspend/Resume:
> spi suspend ok
> SUSPEND SSCR0=00000000 SSCR1=00000740 SSTO=00000000 SSPSP=00000000
> RESUME SSCR0=00000000 SSCR1=00000740 SSTO=00000000 SSPSP=00000000
> 
> I/O after resume:
> ezx_mci_setpower: 23
> ezx_pcap_putget: W 1c000000
> pump_transfersA SSCR0=0010008f SSCR1=00380740 SSTO=00000064 SSPSP=00000000 SSSR=0000f024
> pump_transfersB SSCR0=0010008f SSCR1=00380740 SSTO=00000064 SSPSP=00000000 SSSR=0000f024
> 
> 
>>From my limited knowledge on this, it looks like there is no SSP
> peripheral clock after resume,  SSTO is not decremented after 200us.
> 
> Any pointer on how to fix this? Or other tests i should do?

I think that SSTO does not decrement during operation.  It is a value to
which the internal timer is reset each time there is RX activity.  The
reason it becomes zero in the pre-suspend example, is that it is
explicitly set to zero (disabled) during the end-of-transfer actions of
dma_transfer() and int_transfer_complete().  It looks like you are using
DMA mode (thus dma_transfer()) because RSRE and TSRE bits are set in
SSCR1, and the RIE and TIE bits are clear.

I think the interesting feature is that the BSY bit in SSSR is never set
after resume.  This bit is set automatically when the SSP is busy.  The
developer's manual is not exactly clear about what is required for this
bit to be set.  I expect that not loading data in the TX FIFO would
cause the SSP to not be busy, but I don't see how this would be
possible, because the loading of the TX FIFO is controlled by DMA.

I don't know if lack of clock would do prevent setting BSY or not. You
could directly read the CKEN register to see if the relevant clock
enable bits for your SSP port are set (one of bits 23, 3 or 4, for SSP1,
SSP2 or SSP3, respectively).  I can't find anything in the dev man that
says there needs to be a delay between enabling the clock and starting
operations on the SSP, but you might try introducing a short delay in
resume after enabling the clock.  The dev man does say that the clock
must be disabled before changing any of the clock selection bits in the
SSP registers (section 8.4.10), so you might check that none of these
bits are being changed after enabling the clock.

You may want to check DCSR to make sure the run bits are set for the
assigned dma channels.  You will probably need more printk's just to
find out what channels were assigned; they are assigned in
pxa2xx_spi_probe().  It's hard to believe that these would not be set,
as it is done pump_transfers(), and you know execution is going there.

That's about all I can think of for now.  I don't use suspend/resume in
my application on a PXA255, and I don't specifically know of anyone who
has used it.  I think the last suspend/resume bug fix may be been
discovered by inspection, not by someone trying it, but I'm not sure
about that.

-- 
Ned Forrester                                       nforrester-/d+BM93fTQY@public.gmane.org
Oceanographic Systems Lab                                  508-289-2226
Applied Ocean Physics and Engineering Dept.
Woods Hole Oceanographic Institution          Woods Hole, MA 02543, USA
http://www.whoi.edu/sbl/liteSite.do?litesiteid=7212
http://www.whoi.edu/hpb/Site.do?id=1532
http://www.whoi.edu/page.do?pid=10079


------------------------------------------------------------------------------
Apps built with the Adobe(R) Flex(R) framework and Flex Builder(TM) are
powering Web 2.0 with engaging, cross-platform capabilities. Quickly and
easily build your RIAs with Flex Builder, the Eclipse(TM)based development
software that enables intelligent coding and step-through debugging.
Download the free 60 day trial. http://p.sf.net/sfu/www-adobe-com
