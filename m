From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] spi: add a bits_per_word to struct spi_board_info
Date: Wed, 8 Sep 2010 14:21:59 -0600
Message-ID: <20100908202159.GG7065@angua.secretlab.ca>
References: <20100902100128.5d5b7d87@feng-i7>
	<930634.1250.qm@web180310.mail.gq1.yahoo.com>
	<20100902141348.669aa817@feng-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100902141348.669aa817@feng-i7>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Sep 02, 2010 at 02:13:48PM +0800, Feng Tang wrote:
> Hi David,
> 
> 
> > > Grant also asked me the same question.
> > 
> > 
> > I saw him ask a different question (which
> > I quoted) ...
> 
> My mistake, I tried to answer Grant's and your questions in one email to
> keep the discussion in one thread.
> 
> > 
> > 
> >  Yes, driver itself
> > > know the bits_per_word info best in most case, but there
> > > is
> > > some device (Option GTM501L spi modem) which supports
> > > multiple
> > > bits_per_mode option, and here platform code
> > is the good place to set it.
> > 
> > 
> > Not unless it knows which mode the driver uses...
> > a kind of layering violation.
> 
> spi_board_info has a member of "mode", so for my platform, I prefer to
> set all these infos in platform code, while protocol driver can
> check if the preset infos like speed_hz/mode/bits_per_word are supported.

The real problem is that spi_drivers are normally allowed to change
bits_per_word as needed.  If the spi_driver gets unbound and
rebound, then the original platform-set value for bits_per_word is
lost and the behaviour changes.  If you really want to give the driver
hints about the best setting for bits_per_word or similar, then you
should probably use a driver-specific pdata structure.

g.


------------------------------------------------------------------------------
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
