From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: add a bits_per_word to struct spi_board_info
Date: Thu, 9 Sep 2010 11:14:45 +0800
Message-ID: <20100909111445.47145de9@feng-i7>
References: <20100902100128.5d5b7d87@feng-i7>
	<930634.1250.qm@web180310.mail.gq1.yahoo.com>
	<20100902141348.669aa817@feng-i7>
	<20100908202159.GG7065@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20100908202159.GG7065-MrY2KI0G/OVr83L8+7iqerDks+cytr/Z@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Grant,

On Thu, 9 Sep 2010 04:21:59 +0800
Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:

> > > 
> > >  Yes, driver itself
> > > > know the bits_per_word info best in most case, but there
> > > > is
> > > > some device (Option GTM501L spi modem) which supports
> > > > multiple
> > > > bits_per_mode option, and here platform code
> > > is the good place to set it.
> > > 
> > > 
> > > Not unless it knows which mode the driver uses...
> > > a kind of layering violation.
> > 
> > spi_board_info has a member of "mode", so for my platform, I prefer
> > to set all these infos in platform code, while protocol driver can
> > check if the preset infos like speed_hz/mode/bits_per_word are
> > supported.
> 
> The real problem is that spi_drivers are normally allowed to change
> bits_per_word as needed. 

For drivers who don't accept bits_per_word comes from platform code, it
could just ignores it and set the value it wants.

> If the spi_driver gets unbound and
> rebound, then the original platform-set value for bits_per_word is
> lost and the behaviour changes.  

Um, if you are talking about driver load/unload, then the bits_per_word
info won't get lost as it is set to spi_device from spi_board_info when
spi_new_device get called.

> If you really want to give the driver
> hints about the best setting for bits_per_word or similar, then you
> should probably use a driver-specific pdata structure.

Good point, really a solution to the GTM501L modem driver. But still,
adding the bits_per_word to spi_board_info will be more generic when
more devices which support multiple bits models show up.

Thanks,
Feng


------------------------------------------------------------------------------
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
