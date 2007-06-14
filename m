From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 3/4] MMC-over-SPI core updates
Date: Wed, 13 Jun 2007 17:53:46 -0700
Message-ID: <200706131753.47453.david-b@pacbell.net>
References: <200706101257.45278.david-b@pacbell.net>
	<200706101307.11394.david-b@pacbell.net>
	<466FA700.2080009@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Mikael Starvik <mikael.starvik-VrBV9hrLPhE@public.gmane.org>,
	Hans-Peter Nilsson <hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org>,
	Mike Lavender <mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org>
To: Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <466FA700.2080009-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
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

On Wednesday 13 June 2007, Pierre Ossman wrote:
> David Brownell wrote:
> > @@ -498,6 +505,19 @@ void mmc_detect_change(struct mmc_host *
> >  EXPORT_SYMBOL(mmc_detect_change);
> >  
> >  
> > +static int mmc_spi_fixup(struct mmc_host *host, u32 *ocrp)
> > +{
> > +	int err;
> > +
> > +	if (!mmc_host_is_spi(host))
> > +		return MMC_ERR_NONE;
> > +
> > +	err = mmc_spi_read_ocr(host, ocrp);
> > +	if (err == MMC_ERR_NONE);
> > +		err = mmc_spi_set_crc(host);
> > +	return err;
> > +}
> > +
> >  void mmc_rescan(struct work_struct *work)
> >  {
> >  	struct mmc_host *host =
> 
> I'd prefer if this is in mmc_rescan(). It's so little code that all this does is
> hide the init sequence.

I can move it.  I tried expanding it inline there, and thought
the result was worse:  (a) duplication, in both MMC and SD code
paths; (b) it complicates otherwise-clean logic; (c) you had
asked that the core patch be small.

You're quite sure you want those drawbacks ... ?


> > @@ -519,11 +539,13 @@ void mmc_rescan(struct work_struct *work
> >  		mmc_power_up(host);
> >  		mmc_go_idle(host);
> >  
> > -		mmc_send_if_cond(host, host->ocr_avail);
> > +		if (!mmc_host_is_spi(host))
> > +			mmc_send_if_cond(host, host->ocr_avail);
> >  
>
> If you have a look at the SD physical spec (the public one), you'll see that
> if_cond is needed on SPI aswell. I know you don't have cards for testing, but
> let's code according to spec and try to find people who can test all parts.

I just grabbed a new version of  that spec; the original omitted
absolutely *everything* about SPI.


> >  		err = mmc_send_app_op_cond(host, 0, &ocr);
> >  		if (err == MMC_ERR_NONE) {
> > -			if (mmc_attach_sd(host, ocr))
> > +			err = mmc_spi_fixup(host, &ocr);
> > +			if (err != MMC_ERR_NONE || mmc_attach_sd(host, ocr))
> >  				mmc_power_off(host);
> >  		} else {
> >  			/*
> 
> Looking at the example flow charts in the specs, this is not the proper way.
> I've spent the morning staring at both specs in parallel, and here's how I think
> it should be done:
> 
> [CMD8 for SD]
> CMD58 [with HCS bit for MMC]
> ACMD51, OK -> SD
> CMD1, OK -> MMC

I'll have to get back to you on that after I read that new SD doc.

 
> The SD spec states that both ACMD51 and CMD1 is legal, but nothing about why
> both are supported. It also states that CMD1 has a bit indicating SDHC support
> (as if CMD8 isn't enough), but ACMD51 doesn't. But the flow charts show ACMD51,
> not CMD1. :/

I think it's the usual reason:  ACMD fails on MMC, so use that early to
sort out SD-vs-MMC.  The Linux stack might be marginally quicker if that
were the *ONLY* reason it used ACMD51.

 
> The next step, in the bus handlers, will have to get the OCR on their own. SD
> states that the OCR is valid in the initial CMD58 (before CMD1/ACMD51), but MMC
> states that it is not. So for the sake of consistency, let both paths reissue a
> CMD58 for the OCR.

That's done in the spi_fixup() routine.  ;)

I observed that some cards didn't like CMD58 (READ_OCR) until after
the reset was done, although all the specs I have say that it's
supposed to work while the reset is happening.

 
> > --- pxa.orig/drivers/mmc/core/mmc_ops.c	2007-06-10 13:00:21.000000000 -0700
> > +++ pxa/drivers/mmc/core/mmc_ops.c	2007-06-10 13:00:34.000000000 -0700
> > @@ -31,6 +31,10 @@ static int _mmc_select_card(struct mmc_h
> >  
> >  	BUG_ON(!host);
> >  
> > +	/* SPI doesn't multiplex; "select" is meaningless */
> > +	if (mmc_host_is_spi(host))
> > +		return MMC_ERR_NONE;
> > +
> >  	memset(&cmd, 0, sizeof(struct mmc_command));
> >  
> >  	cmd.opcode = MMC_SELECT_CARD;
> 
> I do not like this. Unsupported commands shouldn't be issued. We should not have
> voodoo in here that makes them a no-op. That just obscures things. Feel free to
> put a check in there if you feel the risk is too great.

Again, you had asked for the core patch to be small ... and
the patch is smaller that way, than when replicating it to
both call site.


> > -int mmc_send_ext_csd(struct mmc_card *card, u8 *ext_csd)
> > +struct mmc_cxd {
> > +	struct mmc_card	*card;		/* optional */
> > +	void		*buf;
> > +	unsigned	len;
> > +	u32		opcode;
> > +	u32		arg;
> > +	unsigned	flags;
> > +};
> > +
> 
> This seems overly complex.

The direct translation of the existing code would have needed them
all as function parameters; ungood to have so many params!


> You can do this with arguments as most of that struct 
> is superfluous:
> 
>  - card can be specified at all times if you reorg the init a bit, allowing you
> to drop the host argument.

Hmm, that may be right.  I was trying to touch that code as
little as possible ... less to break that way!

 
>  - arg and flags are the same for all three commands, so those can be dropped.

Arg is zero (except in the native send_csd), and two of
the three commands are not valid down that route in the
native code.  So I suppose it wouldn't hurt to pass an R1
response code there, knowing that it will never be used,
even though the correct code for those is R2.  That sort
of trick is a bit too ugly for my personal taste; I would
not have thought of always passing invalid parameters.  ;)


> > @@ -230,6 +251,85 @@ int mmc_send_ext_csd(struct mmc_card *ca
> >  	return MMC_ERR_NONE;
> >  }
> >  
> > +int mmc_spi_read_ocr(struct mmc_host *host, u32 *ocrp)
> > +{
> 
> How about moving these further down so that the mmc_send_cxd_data() users are
> right below it?

I'll move it so that and the crc routine are _after_ them ... to
keep all related code together.


> Also, the theme I've tried to have here is to take a card pointer whenever you
> operate on a specific card, and a host pointer for bus wide things. It adds a
> bit of readability.

There's a difference for SPI?!?  :)

Actually, the CRC and OCR stuff gets called before a card struct
is available.  That may be different in the rest of the code.

 
> > --- pxa.orig/drivers/mmc/core/mmc.c	2007-06-10 13:00:21.000000000 -0700
> > +++ pxa/drivers/mmc/core/mmc.c	2007-06-10 13:00:34.000000000 -0700
> > @@ -320,9 +320,15 @@ static int mmc_init_card(struct mmc_host
> >  	/*
> >  	 * Fetch CID from card.
> >  	 */
> > -	err = mmc_all_send_cid(host, cid);
> > -	if (err != MMC_ERR_NONE)
> > -		goto err;
> > +	if (mmc_host_is_spi(host)) {
> > +		err = mmc_spi_send_cid(host, cid);
> > +		if (err != MMC_ERR_NONE)
> > +			goto err;
> > +	} else {
> > +		err = mmc_all_send_cid(host, cid);
> > +		if (err != MMC_ERR_NONE)
> > +			goto err;
> > +	}
> >  
> >  	if (oldcard) {
> >  		if (memcmp(cid, oldcard->raw_cid, sizeof(cid)) != 0)
> 
> This is entirely subjective, but wouldn't this be cleaner:
> 
> 	if (mmc_host_is_spi(host))
> 		err = mmc_spi_send_cid(host, cid);
> 	else
> 		err = mmc_all_send_cid(host, cid);
> 
> 	if (err != MMC_ERR_NONE)
> 		goto err;
> 
> It's fewer lines at least, which should make Linus happy. ;)

Likewise on the SD side.  Though ... *both* need to re-enable
the CRC mode, currently only the SD path does so; fixed.


> > @@ -401,13 +411,15 @@ static int mmc_sd_init_card(struct mmc_h
> >  	}
> >  
> >  	/*
> > -	 * Set card RCA.
> > +	 * For native busses:  set card RCA and leave open drain mode.
> >  	 */
> 
> While your in the processes of fixing my crappy comments, this command actually
> gets, not sends the RCA (SD is a bit backwards). :)

Done (in sd.c only).


> > @@ -455,9 +467,11 @@ static int mmc_sd_init_card(struct mmc_h
> >  		/*
> >  		 * Fetch switch information from card.
> >  		 */
> > -		err = mmc_read_switch(card);
> > -		if (err != MMC_ERR_NONE)
> > -			goto free_card;
> > +		if (!mmc_host_is_spi(host)) {
> > +			err = mmc_read_switch(card);
> > +			if (err != MMC_ERR_NONE)
> > +				goto free_card;
> > +		}
> >  	}
> >  
> >  	/*
> 
> Don't you want high-speed on your SPI bus? ;)
> 
> Add a FIXME here if you don't have the cards to test this. Or implement it
> according to spec and wait for bug reports.

I'll add a REVISIT, unless I get inspired by this updated spec
that I just downloaded.

 
> > --- pxa.orig/drivers/mmc/core/sd_ops.c	2007-06-06 16:47:58.000000000 -0700
> > +++ pxa/drivers/mmc/core/sd_ops.c	2007-06-10 13:00:34.000000000 -0700
> > @@ -89,10 +89,10 @@ int mmc_app_cmd(struct mmc_host *host, s
> >  
> >  	if (card) {
> >  		cmd.arg = card->rca << 16;
> > -		cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
> > +		cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
> >  	} else {
> >  		cmd.arg = 0;
> > -		cmd.flags = MMC_RSP_R1 | MMC_CMD_BCR;
> > +		cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_BCR;
> >  	}
> >  
> >  	err = mmc_wait_for_cmd(host, &cmd, 0);
> 
> You also need to fix the check further down as SPI doesn't have a bit indicating
> if it toggled into ACMD mode.

Right now this is not needed, since the host records that and hands
it back in the R1 status mapping.

Other than that status mapping, this is useful to make sure the right
tracing statements are emitted:  report ACMDx not CMDx.  It makes
message tracing easier to read.  (This is something the MMC/SD core
might benefit from, too.  Did I mention I'm glad that it now issues
the CMDx messages in decimal, matching all docs, not hex?  :)


> > @@ -175,6 +179,9 @@ int mmc_send_if_cond(struct mmc_host *ho
> >  	int err;
> >  	static const u8 test_pattern = 0xAA;
> >  
> > +	if (mmc_host_is_spi(host))
> > +		return MMC_ERR_FAILED;
> > +
> >  	/*
> >  	 * To support SD 2.0 cards, we must always invoke SD_SEND_IF_COND
> >  	 * before SD_APP_OP_COND. This command will harmlessly fail for
> 
> See above, we need this for SDHC.

If the doc I just downloaded covers SDHC, I can code it to spec.

- Dave


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
