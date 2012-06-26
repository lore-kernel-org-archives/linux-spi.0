From: Alain-Serge Nagni <alainsergenagni-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 7/7] ARM: mxs: Add SPI driver for mx233/mx28
Date: Tue, 26 Jun 2012 01:42:30 +0000 (UTC)
Message-ID: <loom.20120626T032724-306@post.gmane.org>
References: <1340477033-2761-1-git-send-email-marex@denx.de>
	<1340477033-2761-7-git-send-email-marex@denx.de>
	<CAOMZO5BYoU5=tJCUH1nkT24FJhhXXhNwF46yYREGJj7G33HdVg@mail.gmail.com>
	<201206251530.32203.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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



Marek Vasut <marex@...> writes:

> 
> Dear Fabio Estevam,
> 
> > Hi Marek,
> > 
> > On Sat, Jun 23, 2012 at 3:43 PM, Marek Vasut <marex@...> wrote:
> > > +       ssp->clk = clk_get(&pdev->dev, NULL);
> > > +       if (IS_ERR(ssp->clk)) {
> > > +               ret = PTR_ERR(ssp->clk);
> > > +               goto out_spi_free;
> > > +       }
> > 
> > You could use devm_clk_get here instead,
> > 
> > > +
> > > +       clk_prepare_enable(ssp->clk);
> > > +       ssp->clk_rate = clk_get_rate(ssp->clk) / 1000;
> > > +
> > > +       stmp_reset_block(ssp->base);
> > > +
> > > +       platform_set_drvdata(pdev, host);
> > > +
> > > +       ret = spi_register_master(host);
> > > +       if (ret) {
> > > +               dev_err(&pdev->dev, "Cannot register SPI master, %d\n",
> > > ret); +               goto out_clk_put;
> > > +       }
> > > +
> > > +       return 0;
> > > +
> > > +out_clk_put:
> > > +       clk_disable_unprepare(ssp->clk);
> > > +       clk_put(ssp->clk);
> > 
> > ,and then you would not need this clk_put here.
> 
> Oh, good point! I'll wait a little bit more until someone else reviews it and 
> then I'll resubmit new version.
> 
> btw. I'm already working on a combined PIO/DMA-capable version -- seems like 
> using PIO for small transfers and DMA for large transfers is good strategy
that 
> gives me about 200kbps boost 
> 
> > Driver looks good. Thanks for working on it.
> > 
> > Regards,
> > 
> > Fabio Estevam
> 
> Best regards,
> Marek Vasut
> 
> ------------------------------------------------------------------------------
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and 
> threat landscape has changed and how IT managers can respond. Discussions 
> will include endpoint security, mobile security and the latest in malware 
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> 



Hi Marek and Fabio,
 I have been testing your latest patch and have some problem to have it working.
The driver is crashing in the "mxs_spi_probe(struct platform_device *pdev)"
function (which is in the file spi-mxs.c) :
  It fails at this call:
          ssp->devid = pdev->id_entry->driver_data;

          after investigation, I can say that: pdev->id_entry  is null. So when
we access it, the kernel crashes.



I added these information in the mach-mx28evk.c file:

    a) in the static const iomux_cfg_t mx28evk_pads[] __initconst table:

       /* SPI2 */
       MX28_PAD_SSP2_SCK__SSP2_SCK,
       MX28_PAD_SSP2_MOSI__SSP2_CMD,
       MX28_PAD_SSP2_MISO__SSP2_D0,
       MX28_PAD_SSP2_SS0__SSP2_D3 |
        (MXS_PAD_3V3 | MXS_PAD_8MA | MXS_PAD_PULLUP),
       MX28_PAD_SSP2_SS1__SSP2_D4 |
        (MXS_PAD_3V3 | MXS_PAD_8MA | MXS_PAD_PULLUP),
       MX28_PAD_SSP2_SS2__SSP2_D5 |
        (MXS_PAD_3V3 | MXS_PAD_8MA | MXS_PAD_PULLUP),


       /* SPI3 */
       MX28_PAD_SSP3_SCK__SSP3_SCK,
       MX28_PAD_SSP3_MOSI__SSP3_CMD,
       MX28_PAD_SSP3_MISO__SSP3_D0,
       MX28_PAD_SSP3_SS0__SSP3_D3 |
        (MXS_PAD_3V3 | MXS_PAD_8MA | MXS_PAD_PULLUP),   



   b) I added an spi device definition:

      static struct spi_board_info mx28evk_spi_nor_device[] = {
      {
         .modalias    = "spidev",
         .chip_select    = 0,
         .max_speed_hz    = 5000000, // max spi clock (SCK) speed in HZ): 5MHz
         .bus_num    = 2,
         .mode = SPI_MODE_0,
      }, 
     };


    c) I added these calls in the "mx28evk_init(void)" function:

	mx28_add_mxs_spi(2);
	spi_register_board_info(mx28evk_spi_nor_device,
				ARRAY_SIZE(mx28evk_spi_nor_device));



What do you think may be the problem? If you need more details please let me
know.



Thanks for your help,
Alain-Serge



------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
