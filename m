From: Brian Niebuhr <BNiebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
Subject: RE: [PATCH 1/2 v2] spi: overhaul davinci spi driver to correct
	multiple errors
Date: Mon, 15 Mar 2010 09:24:35 -0500
Message-ID: <A117B9F753B6EB4580D381ED91D0FED00178A905@transmail01.transcrypt.local>
References: <1268422520-22642-1-git-send-email-bniebuhr@efjohnson.com><1268422520-22642-2-git-send-email-bniebuhr@efjohnson.com>
	<87k4th2hpn.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
        davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: "Kevin Hilman" <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Content-Class: urn:content-classes:message
In-Reply-To: <87k4th2hpn.fsf-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-spi.vger.kernel.org

 > > This patch is a significant overhaul of the davinci spi 
> controller driver
> > that corrects multiple errors:
> >
> > - Eliminate a race condition that exists for slow SPI devices
> > - Fix DMA transfer length error
> > - Fix limitations preventing multiple SPI devices on the 
> same controller
> >
> > Signed-off-by: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
> 
> The verbose description of the issues addressed from PATCH 0/2 should
> go here is well so it makes it into the permanent git history.

I can certainly do that.
 
> That being said, I think for the sake of reviewing, you're going to
> need to break this up into reviewable pieces, each having a verbose
> description of the issues being solved.
> 
> There is also a mixture of fixes, enhancements, renames etc.  These
> should be done as separate patches. 
> 
> I know that it's more work to break it up like this, but that's the
> only way to make a large change like this reviewable by others.

I guess I was hoping that this could be reviewed as if it were a new
driver submission.  I ended up more or less rewriting all of the
functional parts of the driver (txrx_bufs(), chipselect(), IRQs and DMA
callbacks), so it's very difficult to show this as a series of changes.
I do understand the problem from your perspective, though.  My thought
was that if the TI folks were willing to look the driver over and they
gave their blessing, that you would look at it as if it were a
replacement driver and accept or deny it on that basis.

Thanks for your consideration,

Brian
