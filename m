From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi/dw_spi: clean the cs_control code
Date: Thu, 2 Sep 2010 10:10:29 +0800
Message-ID: <20100902101029.2f17c8a5@feng-i7>
References: <1283319359-16297-1-git-send-email-feng.tang@intel.com>
	<20100901150757.GA13421@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	George Shore <george-ofzTHo7+kyPpQY4QmZNtDQ@public.gmane.org>,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20100901150757.GA13421-MrY2KI0G/OVr83L8+7iqerDks+cytr/Z@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, 1 Sep 2010 23:07:57 +0800
Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:

> Hi Feng,
> 
> On Wed, Sep 01, 2010 at 01:35:59PM +0800, Feng Tang wrote:
> > commit 052dc7c45 introduced cs_control code,
> 
> Be friendly to mere-mortals.  You should quote the patch title
> "spi/dw_spi: conditional transfer mode changes" in addition to the
> sha1 id.

Got it, thanks, will add it in V2

> > @@ -544,13 +540,13 @@ static void pump_transfers(unsigned long data)
> >  	 */
> >  	if (dws->cs_control) {
> >  		if (dws->rx && dws->tx)
> > -			chip->tmode = 0x00;
> > +			chip->tmode = SPI_TMOD_TR;
> >  		else if (dws->rx)
> > -			chip->tmode = 0x02;
> > +			chip->tmode = SPI_TMOD_RO;
> >  		else
> > -			chip->tmode = 0x01;
> > +			chip->tmode = SPI_TMOD_TO;
> >  
> > -		cr0 &= ~(0x3 << SPI_MODE_OFFSET);
> > +		cr0 &= ~SPI_TMOD_MASK;
> >  		cr0 |= (chip->tmode << SPI_TMOD_OFFSET);
> 
> Changing these values isn't mentioned in the patch description.  I
> assume this is not the bug fix because the #defines are the same
> values.

OK, it's a little confusing, there are 2 OFFSET here:
	SPI_MODE_OFFSET (for spi mode 0/1/2 etc setting)
	SPI_TMOD_OFFSET (for tx only/rx only/duplex)

So simple fix should be
-		cr0 &= ~(0x3 << SPI_MODE_OFFSET); 
+		cr0 &= ~(0x3 << SPI_TMOD_OFFSET);
while my new introduced SPI_TMOD_MASK make things complex :)

Thanks,
Feng

------------------------------------------------------------------------------
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
