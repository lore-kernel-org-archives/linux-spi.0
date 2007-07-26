From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 2.6.22-git5 2/4] MMC block learns
	about SPI
Date: Thu, 26 Jul 2007 10:00:16 -0700
Message-ID: <200707261000.17339.david-b@pacbell.net>
References: <200707141504.51950.david-b@pacbell.net>
	<200707141506.42880.david-b@pacbell.net>
	<20070726183339.6631243f@poseidon.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Hans-Peter Nilsson <hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org>,
	Mikael Starvik <mikael.starvik-VrBV9hrLPhE@public.gmane.org>,
	Mike Lavender <mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20070726183339.6631243f-mgABNEgzgxm+PRNnhPf8W5YgPPQkE1Si@public.gmane.org>
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

On Thursday 26 July 2007, Pierre Ossman wrote:
> On Sat, 14 Jul 2007 15:06:42 -0700
> David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> 
> > @@ -302,13 +309,14 @@ static int mmc_blk_issue_rq(struct mmc_q
> >  			goto cmd_err;
> >  		}
> >  
> > -		if (rq_data_dir(req) != READ) {
> > +		if (!mmc_host_is_spi(card->host) && rq_data_dir(req) != READ) {
> >  			do {
> >  				int err;
> >  
> >  				cmd.opcode = MMC_SEND_STATUS;
> >  				cmd.arg = card->rca << 16;
> > -				cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
> > +				cmd.flags = MMC_RSP_SPI_R2 | MMC_RSP_R1
> > +						| MMC_CMD_AC;
> >  				err = mmc_wait_for_cmd(card->host, &cmd, 5);
> >  				if (err) {
> >  					printk(KERN_ERR "%s: error %d requesting status\n",
> 
> Nitpicking, but if this code isn't executed on a SPI host then a SPI
> response type is hardly needed. :) 

But then it can't hurt either, and will be safer to cut'n'paste.  :)

Andrew Morton regularly gives feedback which amounts to "that's correct
in this context, but please adopt this always-safe idiom" on the grounds
that a *LOT* of Linux code is developed by cloning.  It's hard for me to
disagree with that... especially when I see my code showing up in some
rather strange contexts!


> Otherwise ok.

So -- should I change that?

- Dave

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
