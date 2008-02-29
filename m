From: "Zik Saleeba" <zik-fsgeVU6Z5FysTnJN9+BGXg@public.gmane.org>
Subject: Re: Problems with suspend/resume of pxa2xx_spi
Date: Fri, 29 Feb 2008 12:02:01 +1100
Message-ID: <33e9dd1c0802281702j423a99cfn4944a31d9c6da821@mail.gmail.com>
References: <33e9dd1c0802201932v6873415bm9202ad478f192b7f@mail.gmail.com>
	<33e9dd1c0802281502x3d045a03pcb6282a781ac4e56@mail.gmail.com>
	<33e9dd1c0802281635v18bcdd49te38d49e7a24abacf@mail.gmail.com>
	<200802281656.45757.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "David Brownell" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200802281656.45757.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

Thanks for the comments David. I'll submit a proper patch later.

Cheers,
Zik

On Fri, Feb 29, 2008 at 11:56 AM, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> On Thursday 28 February 2008, Zik Saleeba wrote:
>  > I fixed my other suspend/resume problem - it was unrelated to spi. So
>  > restoring the SSP registers is the fix. It's all working correctly for
>  > me now.
>
>  Good.  I can believe that driver hasn't had much suspend/resume testing;
>  many platforms don't get such testing, and often not all drivers get
>  covered.  PXA has had issues where even the reference boards (for folk
>  who have them) don't really leverage all the peripherals.
>
>
>
>  > I've never submitted a patch before so I'd appreciate a review of this
>  > before I submit it properly:
>
>  See Documentation/SubmittingPatches.  The most obvious bit:
>
>
>  > Index: pxa2xx_spi.c
>  > ===================================================================
>  > --- pxa2xx_spi.c        (revision 562)
>  > +++ pxa2xx_spi.c        (working copy)
>
>  Patch format should let it be applied at toplevei with "patch -p1" ...
>
>
>  > @@ -102,6 +102,12 @@
>
>  I prefer to see patches generated with "diff -p ..." so there's
>  more context to review *just the patch* ...
>
>
>
>  >         u32 int_cr1;
>  >         u32 clear_sr;
>  >         u32 mask_sr;
>  > +
>  > +        /* saved state for suspend/resume */
>  > +        u32 saved_sscr0;
>  > +        u32 saved_sscr1;
>  > +        u32 saved_sst0;
>  > +        u32 saved_sspsp;
>  >
>  >         /* Driver message queue */
>  >         struct workqueue_struct *workqueue;
>  > @@ -1570,11 +1576,16 @@
>  >  static int pxa2xx_spi_suspend(struct platform_device *pdev, pm_message_t state)
>  >  {
>  >         struct driver_data *drv_data = platform_get_drvdata(pdev);
>  > +       void *reg = drv_data->ioaddr;
>  >         int status = 0;
>  >
>  > -       /* Check all childern for current power state */
>
>  You should also generate patches aginst the *CURRENT* kernel,
>  which in this case doesn't have that needless loop.
>
>
>
>  > +        /* Save register state */
>  > +        drv_data->saved_sscr0 = read_SSCR0(reg);
>  > +        drv_data->saved_sscr1 = read_SSCR1(reg);
>  > +        if (drv_data->ssp_type != PXA25x_SSP)
>  > +                drv_data->saved_sst0 = read_SSTO(reg);
>  > +        drv_data->saved_sspsp = read_SSPSP(reg);
>  > +
>  > +       /* Check all children for current power state */
>  >         if (device_for_each_child(&pdev->dev, &state, suspend_devices) != 0) {
>
>  I think you have some indentation problems ... looks like you're
>  either not using TAB for indent, or added an extra space afterwards.
>
>
>
>
>  >                 dev_warn(&pdev->dev, "suspend aborted\n");
>  >                 return -1;
>  > @@ -1592,13 +1604,21 @@
>  >  static int pxa2xx_spi_resume(struct platform_device *pdev)
>  >  {
>  >         struct driver_data *drv_data = platform_get_drvdata(pdev);
>  > +       void *reg = drv_data->ioaddr;
>  >         int status = 0;
>  >
>  >         /* Enable the SSP clock */
>  >         pxa_set_cken(drv_data->master_info->clock_enable, 1);
>  >
>  > +       /* Load saved SSP configuration */
>  > +        write_SSCR0(0, reg);
>  > +        write_SSCR1(drv_data->saved_sscr1, reg);
>  > +        write_SSCR0(drv_data->saved_sscr0, reg);
>  > +        write_SSITR(0, reg);
>  > +       if (drv_data->ssp_type != PXA25x_SSP)
>  > +                write_SSTO(drv_data->saved_sst0, reg);
>  > +        write_SSPSP(drv_data->saved_sspsp, reg);
>  > +
>  >         /* Start the queue running */
>  >         status = start_queue(drv_data);
>  >         if (status != 0) {
>  >
>  >
>

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
