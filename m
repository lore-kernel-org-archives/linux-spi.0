From: "Jan Nikitenko" <jan.nikitenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [patch 3/4 2.6.23-rc2 + mm2-git-mmc] MMC core
	learns about SPI
Date: Fri, 19 Oct 2007 11:50:16 +0200
Message-ID: <c4bc83220710190250m6c3401end194917e2daa9104@mail.gmail.com>
References: <200708080906.18993.david-b@pacbell.net>
	<20070829092247.GA15021@pengutronix.de>
	<20070829165243.0236cc89@poseidon.drzeus.cx>
	<200708290943.59450.david-b@pacbell.net> <470A644A.8030405@gmail.com>
	<20071010203613.55676dba@poseidon.drzeus.cx>
	<c4bc83220710190240wd13bfd1r991ba9b1b1128f6c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Mikael Starvik <mikael.starvik-VrBV9hrLPhE@public.gmane.org>,
	Hans-Peter Nilsson <hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org>,
	Mike Lavender <mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org>
To: "Pierre Ossman" <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <c4bc83220710190240wd13bfd1r991ba9b1b1128f6c-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

On 10/10/07, Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org> wrote:
> On Mon, 08 Oct 2007 19:09:30 +0200
> Jan Nikitenko <jan.nikitenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
> >
> > I can confirm, that the byte-swapping patch from Sascha is needed on
> > my little endian mips testbed too.
> >
> > I can also see, that in earlier versions of mmc-spi, the byte swapping
> > was present in there together with routine to read csd/cid. Now it is
> > handled in mmc core, without byte swapping, so it does not work on
> > little endian systems...
> >
>
> Odd. Could you point to the byte swapping in the earlier version?

It was present in mmc-spi update patch posted here for example:
http://sourceforge.net/mailarchive/message.php?msg_id=200706042025.18252.david-b%40pacbell.net
Check the mmc_spi_read_cXd(), there are be32_to_cpus() calls present.

>
> > I've tested mmc-spi from linux-2.6.23-rc8-mm2, plus:
> >   - added byte-swapping patch from Sascha
> >   - added buffer length patch from Sascha as improved by David
> >
> > This resulted in nearly working mmc-spi, except the problem with the
> > last sector(s).
> > Tried to apply the fix to force single block read for last sector as
> > suggested by Sascha, but it fails not with the last sector, but
> > several of them at the end, with following error:
> > mmcblk0: error -22 sending stop command
> >
> > Changing the patch to use single block reads for any of 8 sectors at
> > the end of sd card, it works perfectly.
> >
>
> This is extremely weird. How common is this? (i.e. how many cards have
> you tested and how many fail).

well, it is the same for all 3 out of 3 different SD cards I have here:
mmcblk0: mmc0:0000 SD    999936KiB    (myFlash Turbo SD 150x 1GB A-Data)
mmcblk0: mmc0:0000 SMI-S 126464KiB  (X4store?)
mmcblk0: mmc0:0000 AF SD 249856KiB  (X4store?)

>
> Also, do you have some easy test case so that I can check with my stash?

I used just the dd command to read last 256 sectors (i.e.128KiB).
With patch from Sascha, it reads only 248 sectors.
Using my modification, it reads full 256 sectors at the end of sd card.

>
> > In addition to that, it seems, that retries are not enabled for sector
> > access in mmc core, so I needed to add set of brq.cmd.retries into
> > mmc_blk_issue_rq() and also checking of mrq->data->error and
> > mrq->stop->error with call to host->ops->request() into
> > mmc_request_done().
> >
> > Otherwise, block transfers are never retried. And there are cases,
> > that errors are caused by too long wires and high frequencies in my
> > environment, so retries are sometimes very useful.
> >
>
> Then you need to fix your board. Retrying write with a translation
> layer in the middle (the FTL on the card) can cause all kinds of weird
> results. So it's up to upper layers how to handle failures.

The board is ok, it is due to that the sd card is on external board,
connected wia cable, so it might happen rarely using 8.1MHz spi clock,
that there is an error in the transfer. As said, it works in 99.9%.
But when there is an error, retry is useful. The number of retries of
8 was a bit exaggerated, just one retry suffices for the setup I have
here.
What do you mean by FTL on the card?

>
> > Finally I have tested also the suspend/resume callbacks of mmc core.
> > As I am using sd card in embedded environment (assuming that sd card
> > will never be removed), so MMC_UNSAFE_RESUME is good to me.
> >
> > However, it seems to me, that the
> > -               if (!blk_queue_plugged(q))
> >                         req = elv_next_request(q);
> > in mmc_queue_thread() is too kind to accept new requests, even when
> > the queue is stopped.
> >
> > This seems to be much better for faster suspending:
> > +               if (!blk_queue_plugged(q) && !blk_queue_stopped(q))
> >                         req = elv_next_request(q);
> > so that new requests are not accepted if queue is stopped or plugged.
> >
>
> I'd rather not muck about with working code unless there is an actual
> gain. Have you observed a problem caused by the queue flush?

Without the !blk_queue_stopped(q) check, the suspend waits until dd
command finishes it's  job.
If the check is there, it's possible to suspend when dd command (or
any other file copy command) is running and properly resume after.

Best regards,
Jan

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
