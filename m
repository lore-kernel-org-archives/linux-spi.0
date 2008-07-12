From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v2 4/5] spi: Add OF binding support
	for SPI busses
Date: Fri, 11 Jul 2008 23:21:49 -0600
Message-ID: <20080712052149.GA23213@secretlab.ca>
References: <20080703005749.26187.71719.stgit@trillian.secretlab.ca>
	<20080703010313.26187.99119.stgit@trillian.secretlab.ca>
	<9e4733910807022002n3c739c7cs8ed642e4a6027bb6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org,
	fabrizio.garetto-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <9e4733910807022002n3c739c7cs8ed642e4a6027bb6-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

On Wed, Jul 02, 2008 at 11:02:23PM -0400, Jon Smirl wrote:
> On 7/2/08, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:
> > From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> >
> >  This patch adds support for populating an SPI bus based on data in the
> >  OF device tree.  This is useful for powerpc platforms which use the
> >  device tree instead of discrete code for describing platform layout.
> >
> >  Signed-off-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> >  ---
> >  +               /* Select device driver */
> >  +               sprop = of_get_property(nc, "linux,modalias", &len);
> >  +               if (sprop && len > 0)
> >  +                       strncpy(spi->modalias, sprop, KOBJ_NAME_LEN);
> >  +               else
> >  +                       strncpy(spi->modalias, "spidev", KOBJ_NAME_LEN);
> 
> You're missing a request_module("%s", info.type) to make sure the
> module is loaded.
> 
> It might make sense to share code with of_find_i2c_driver() so we have
> a common way of guessing module names.

You're right.  I've refactored the i2c code to make it usable by SPI
also.  I'll post the new patch series this evening.

g.

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
