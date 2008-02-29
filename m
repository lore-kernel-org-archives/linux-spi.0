From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: Problems with suspend/resume of pxa2xx_spi
Date: Thu, 28 Feb 2008 23:31:20 -0500
Message-ID: <47C78A98.6010808@whoi.edu>
References: <33e9dd1c0802201932v6873415bm9202ad478f192b7f@mail.gmail.com>
	<33e9dd1c0802281502x3d045a03pcb6282a781ac4e56@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Zik Saleeba <zik-fsgeVU6Z5FysTnJN9+BGXg@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <33e9dd1c0802281502x3d045a03pcb6282a781ac4e56-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

Zik Saleeba wrote:
> On Thu, Feb 21, 2008 at 2:32 PM, Zik Saleeba <zik-fsgeVU6Z5FysTnJN9+BGXg@public.gmane.org> wrote:
>> I've been having some more problems with my SPI application on the
>>  PXA270. When I suspend the system it all goes into suspend mode
>>  correctly but when it comes back on resume any call to the pxa2xx_spi
>>  code just hangs.
> 
> I've looked into this problem a bit more. It looks like suspend/resume
> can never have worked on the pxa2xx spi subsystem.

I'm not surprised, I've never used it with my Gumstix (I just power
cycle it, because it does not take long to boot), and I don't know if
Stephen Street tested it, either.  I'm not sure if others have tried it.
 Also, I think Stephen used a PXA255, as do I, so any differences with
PXA270 may be new.

> One problem I've found is that after suspend the SSP registers don't
> come back in their previous state. They need to be saved and restored.

Well, no.  They need to come back in a safe, stopped state.

> I found that saving and restoring SSCR0, SSCR1, SSITR, SST0 (for
> pxa270) and SSPSP was enough to bring the system back to life again.

But SSCR0, SSCR1, and SSTO are restored at the end of pump_transfers on
every transfer, including the first.  SSPSP should not matter if that
mode is not selected in SSCR0.  Is SSITR not resuming as all zeros?  Yes
it is, as the data you provided below confirms.  Something else is going on.

> Would more experienced people like to comment on whether I'm on the
> right track here?

Have you verified that the suspend process completes correctly?
Does pxa2xx_spi_suspend() return 0?

> Here's the contents of the registers before suspend:
> 
> SSCR0=00000387

As noted in earlier email, you don't want to capture the running state
(SSE = 1).

> SSCR1=00000ec0
> SSSR=0000f024
> SSITR=00000000
> SSTO=00000000

Are you really operating with with zero (no) timeout, or more likely did
this capture just catch the SSP between transfers?  (Unless there is an
error, it is normal, after a transfer, for SSE to remain high, but with
the interrupt and service enables off, and SSTO=0.) A zero timeout, in
and of itself, might cause the driver to never return messages if there
are trailing bytes after a DMA, though it should not cause problems for
the rest of the kernel.

> SSPSP=00000000

Good.  SSPSP is cleared in pxa2xx_spi_probe, and never set again.

> And after suspend:
> 
> SSCR0=00000000

This would be the correct restored value of SSCR0, because that is the
last value written during suspend.

> SSCR1=00000000

A valid state, though this would otherwise get fixed up at the end of
pump_transfers, just before the action starts.  The sate stored above
does not have any interrupt or DMA service enables set, so even if these
registers are restored, no data will be transferred until the next
transfers is started in pump_transfers.

> SSSR=0000f004
> SSITR=00000000
> SSTO=00000000
> SSPSP=00000000

These three zero values are valid, and the case of PSP and SSITR, desired.

> ===================================================================
> --- pxa2xx_spi.c        (revision 562)
> +++ pxa2xx_spi.c        (working copy)
> @@ -102,6 +102,12 @@
>         u32 int_cr1;
>         u32 clear_sr;
>         u32 mask_sr;
> +
> +        /* saved state for suspend/resume */
> +        u32 saved_sscr0;
> +        u32 saved_sscr1;
> +        u32 saved_sst0;
> +        u32 saved_sspsp;

It should be neither necessary, nor appropriate, to save these registers
in special locations.  The values of these registers are already known
to the driver (in struct chip_data), and should be restored from the
known values, except with SSCR0[SSE] low.

> @@ -1570,11 +1576,16 @@
>  static int pxa2xx_spi_suspend(struct platform_device *pdev, pm_message_t state)
>  {
>         struct driver_data *drv_data = platform_get_drvdata(pdev);
> +       void *reg = drv_data->ioaddr;
>         int status = 0;
> 
> -       /* Check all childern for current power state */
> +        /* Save register state */
> +        drv_data->saved_sscr0 = read_SSCR0(reg);
> +        drv_data->saved_sscr1 = read_SSCR1(reg);
> +        if (drv_data->ssp_type != PXA25x_SSP)
> +                drv_data->saved_sst0 = read_SSTO(reg);
> +        drv_data->saved_sspsp = read_SSPSP(reg);

The driver is about to be stopped, below, with stop_queue().  You don't
want to capture and restore a running state because that is not the
state the driver will be in during suspend!  Again, you need to verify
that suspend is completing correctly, and then, if saving these
registers really helps (I'm not convinced of that), restore the states
saved after shutdown.

> +
> +       /* Check all children for current power state */
>         if (device_for_each_child(&pdev->dev, &state, suspend_devices) != 0) {
>                 dev_warn(&pdev->dev, "suspend aborted\n");
>                 return -1;

As David pointed out, you are patching an obsolete version of the
driver.  These lines were recently removed.  I work with an old version
too, but be sure your patches are applied against the latest version.

> @@ -1592,13 +1604,21 @@
>  static int pxa2xx_spi_resume(struct platform_device *pdev)
>  {
>         struct driver_data *drv_data = platform_get_drvdata(pdev);
> +       void *reg = drv_data->ioaddr;
>         int status = 0;
> 
>         /* Enable the SSP clock */
>         pxa_set_cken(drv_data->master_info->clock_enable, 1);
> 
> +       /* Load saved SSP configuration */
> +        write_SSCR0(0, reg);
> +        write_SSCR1(drv_data->saved_sscr1, reg);
> +        write_SSCR0(drv_data->saved_sscr0, reg);

NO.  Even if it were right to restore SSCR0 to this value in
pxa2xx_spi_resume(), this register must be set last, after setting all
modes, in particular, SSPSP, below. (see section 8.5 of the PXA270
developer's manual).  This would not matter if SSCR0[SSE] was not set in
saved_sscr0, as it shouldn't be, but this is the wrong order, since you
have the bit erroneously set.

> +        write_SSITR(0, reg);
> +       if (drv_data->ssp_type != PXA25x_SSP)
> +                write_SSTO(drv_data->saved_sst0, reg);
> +        write_SSPSP(drv_data->saved_sspsp, reg);
> +
>         /* Start the queue running */
>         status = start_queue(drv_data);
>         if (status != 0) {

--

If these changes really fix your problem, then there is something more
subtle going on.  All the register values you show after resume are
valid, assuming the driver shutdown properly (queue stopped, and already
queued messages completed and given back).

Please try the following:

First, verify that you are not using a zero timeout, as that might cause
the trouble.

Next, verify that suspend is completing (empty queue).  Perhaps the
protocol driver is stopped first, and pxa2xx_spi blocks on giveback().
That would be bad.

If that is not it, then there may be something subtle about the timing
of setting up a non-zero state in SSCR1 and SSCR0.  Prior to 2.6.20, the
state was restored in pump_messages, which is somewhat earlier than
pump_transfers.  I don't know if suspend ever worked, but if it did,
that difference might be related.

Try restoring these two registers only, not with the values you saved,
but with the default values used in probe, after the comment:
/* Load default SSP configuration */

It that does not work, try (just as an experiment) loading the values
used by your first transfer after resume.

Just looking at all the other things initialized by probe and setup,
check to see if the following registers are preserved across suspend/resume:
	DRCMR(ssp->drcmr_rx) /* as accessed in probe */
	DRCMR(ssp->drcmr_tx)
Actually, on close look, these are the only other registers (than the
SSP registers already discussed) that are set in probe and setup, and
these would be fatal if not set properly on resume.  Since you have
gotten this to work, these registers are not likely to be the problem.

We need to isolate the problem, and fix the right thing.  Otherwise a
quick "fix", like the one above, is likely to break something for
someone else.  I would work on this, but I have no way to test it.

--

Since you are working on suspend/resume, it would be a good time to fix
what appears to be a bug in suspend.  If stop_queue fails, the function
returns without ever stopping the SSP or disabling its clock.  I think
that this should be changed so that a dev_err() message is output on
failure to stop queue, but that the SSP and clock should be disabled
anyway, else power savings are not achieved.  Probably in the error path
there is a need to flush the queue directly with calls to giveback()
setting the error status in each message.

If the queue is failing to flush, fixing it might solve the problem.  On
resume, start_queue() forces any message that was current
(drv_data->cur_msg != NULL) to be arbitrarily dropped, and never given
back; there aren't supposed to be any messages in progress.  Any such
message is still physically linked in the queue, however, so I'm not
quite sure what happens then.

More if I think of it.  Let me know what you think.

-- 
Ned Forrester                                       nforrester-/d+BM93fTQY@public.gmane.org
Oceanographic Systems Lab                                  508-289-2226
Applied Ocean Physics and Engineering Dept.
Woods Hole Oceanographic Institution          Woods Hole, MA 02543, USA
http://www.whoi.edu/sbl/liteSite.do?litesiteid=7212
http://www.whoi.edu/hpb/Site.do?id=1532
http://www.whoi.edu/page.do?pid=10079


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
